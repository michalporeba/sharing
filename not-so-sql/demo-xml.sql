use tempdb 
go

/* 1. Auto Select */

select top (3)
     object_id              as id 
    ,type_desc              as [type]
    ,schema_name(schema_id) as [schema]
    ,[name]                 as [name] 
from sys.all_objects as hello
for xml auto

/* 2. Path Select 
 *
 * Nodes can be renamed when using path parameter 
 * and a root object can be added too
 */

select top (3)
     object_id              as '@id' 
    ,type_desc              as [type]
    ,schema_name(schema_id) as 'properties/schema'
    ,[name]                 as 'properties/name'
from sys.all_objects as objects
for xml path('object'), root('objects')

/* 3. XML object per row of data 
 *
 * By default subquery results are text, not xml
 * Applying any XML methods will fail unless 'type' is specified
 */

select top (3)
    (select 
        object_id              as '@id' 
        ,type_desc              as [type]
        ,schema_name(schema_id) as 'properties/schema'
        ,[name]                 as 'properties/name'
     for xml path('object'), type) as XmlData
from sys.all_objects as objects

/* 4. Documents can be created without tables */

declare 
     @id    int             = 123 
    ,@name  nvarchar(max)   = 'something'

--select @id 'id', @name 'name' for xml auto
select @id '@id', @name 'name' for xml path('object')
select @id '@id', @name 'text()' for xml path('object')

-------------------------------------------------------------------------------
/* 5. Create function that returns XML */

go
create or alter function dbo.GetXml()
returns xml
as
begin
    return (
        select top (5)
            object_id              as '@id' 
            ,type_desc              as [type]
            ,schema_name(schema_id) as 'properties/@schema'
            ,[name]                 as 'properties/name'
        from sys.all_objects as objects
        for xml path('object'), root('objects')
    ) 
end
go

/* 6. Getting individual values from XML */

declare @xml xml = dbo.GetXml()

select @xml

select 
     @xml.value('(/objects/object[1]/@id)[1]', 'int')                   as Id
    ,@xml.value('(/objects/object[2]/properties/name)[1]', 'sysname')   as Name
    
/* 7. XML nodes to a table */

go
declare @xml xml = dbo.GetXml()

select
    -- *
    o.query('.') ObjectNode
    ,o.query('./properties') Properties
    ,o.value('./@id', 'int') Id
    --,o.value('./properties/name', 'sysname') Name
    ,o.value('./properties[1]/name[1]', 'sysname') Name
    ,o.value('(./properties/name)[1]', 'sysname') Name
from @xml.nodes('//object') t(o)

go
declare @xml xml = dbo.GetXml()
select o.query('.') as [Data]
into #XmlData
from @xml.nodes('//object') t(o)

select * from #XmlData



/* 8. Querying XML in a table */

select [Data]
    ,[Data].value('(/object/@id)[1]', 'int') Id 
    ,[Data].value('(/object/abc)[1]', 'int') MissingThing
from #XmlData 


/* 9. Modifying the data */

select * from #XmlData 
update #XmlData set [Data].modify('
        replace value of (/object/@id)[1]
        with "0"
    ')
update #XmlData set [Data].modify('
        delete (/object/type)[1]
    ')
update #XmlData set [Data].modify('
        insert <new>1</new>
        as first 
        into (/object)[1]
    ')
update #XmlData set [Data].modify('
        insert attribute new {"2"}
        as last 
        into (/object/properties)[1]
    ')
select * from #XmlData 


/* 10. Using XQuery as a functional language */

declare @password nvarchar(32) = 'Secret1234'
declare @hash varbinary(max) = hashbytes('md5', @password)

select 
     @password Password 
    ,@hash Hash 

    ,convert(xml, N'').value('
        xs:base64Binary(xs:hexBinary(sql:variable("@hash")))', 'varchar(max)'
    ) Base64Hash