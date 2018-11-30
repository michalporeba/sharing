use tempdb 
go

/* 1. Auto Select */

select top (3)
     object_id              as id
    ,type_desc              as [type] 
    ,schema_name(schema_id) as [schema]
    ,[name]                 as [name] 
from sys.all_objects 
for json auto


/* 2. Path Select 
 *
 * A root object can be added
 */

select top (3)
     object_id              as id 
    ,type_desc              as [type] 
    ,schema_name(schema_id) as 'properties.schema'
    ,[name]                 as 'properties.name'
from sys.all_objects 
for json path, root('test') 

/* 3. JSON object per row of data 
 * 
 * Still the wrapper is automatically added
 * but it can be removed with 'without_array_wrapper'
 */

select top (3)
    (select
        object_id              as id 
        ,type_desc              as [type] 
        ,schema_name(schema_id) as 'properties.schema'
        ,[name]                 as 'properties.name'
     for json path, without_array_wrapper) JsonData
from sys.all_objects 

/* 4. Documents can be created without tables */

declare 
     @id    int             = 123 
    ,@name  nvarchar(max)   = 'something'

--select @id 'id', @name 'name' for json auto
select @id 'id', @name 'name' for json path, without_array_wrapper
select @id 'id', @name 'text()' for json path, without_array_wrapper

-------------------------------------------------------------------------------

/* 5. Create function that returns JSON */

go
create or alter function dbo.GetJson()
returns nvarchar(max)
as
begin
    return (
        select top (5)
            object_id              as id 
            ,type_desc              as [type] 
            ,schema_name(schema_id) as 'properties.schema'
            ,[name]                 as 'properties.name'
        from sys.all_objects 
        for json path
    )
end
go

/* 6. Getting individual values from JSON */

declare @json nvarchar(max) = dbo.GetJson()

select @json 

select 
     json_value(@json, '$[0].id')               as Id
    ,json_value(@json, '$[1].properties.name')  as Name


/* 7. JSON array to a table */

select * from openjson(dbo.GetJson())

select * from openjson(N'
{  
   "StringValue":"Hello",  
   "IntValue":45,  
   "NullValue":null,  
   "ArrayValue":["1","2","3"],  
   "ObjectValue":{"say":"hello"}  
}
')

select 
    Id, [Type], properties Properties
    ,json_value(properties, '$.schema') Schema2 
    --,convert(sysname, json_value(properties, '$.name')) Name2
from openjson(dbo.GetJson())
with (
      Id            int             '$.id'
     ,[Type]        sysname         '$.type'
     ,[Schema]      sysname         '$.properties.schema'
     ,[Name]        sysname         '$.properties.name'
     ,properties    nvarchar(max)   as json 
)
for xml path('object'), root('objects')

select [value] as [Data] 
into #JsonData 
from openjson(dbo.GetJson())

select * from #JsonData

/* 8. Querying JSON in a table */

select [Data] 
    ,json_value([Data], '$.properties') Properties 
    ,convert(int, json_value([Data], 'strict $.id')) Id 
    ,convert(int, json_value([Data], 'lax $.abc')) MissingThing
from #JsonData
--add strict or lax to show both modes

/* 9. Modify the data */

select * from #JsonData 
update #JsonData set [Data] = json_modify([Data], '$.id', 0)
update #JsonData set [Data] = json_modify([Data], '$.type', null)
update #JsonData set [Data] = json_modify([Data], '$.new', 1)
update #JsonData set [Data] = json_modify([Data], '$.properties.new', 2)
select * from #JsonData 

/* 10. Using JSON for schema configuration */


