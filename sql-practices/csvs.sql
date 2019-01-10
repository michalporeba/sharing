use tempdb
go


/* 1NF it is not, but end users like it
 * https://stackoverflow.com/questions/13639262/optimal-way-to-concatenate-aggregate-strings
 * it cannot be that hard!
 *
 * https://www.red-gate.com/simple-talk/sql/t-sql-programming/concatenating-row-values-in-transact-sql/
 * red-gate, they know what they are doing (check date, 2008, reviewed 2012)
 *   - Recursive CTE (2 methods)
 *   - Blackbox XML 
 *   - Using CLR 
 *   - Scalar UDF with recursion 
 *   - TVF with a loop
 *   - Dynamic SQL 
 *   - The Cursor Approach 
 *   - Scalar UDF with T-SQL update extension 
 *   - Scalar UDF with variable concatenation in SELECT
 *
 */

select name from sys.all_objects

declare @csv nvarchar(max) 

select @csv = isnull(@csv + ', ', '') + name 
from sys.all_objects 
order by name asc

select @csv 
go

--

select 
     type_desc Category
    ,stuff((
            select ', ' + name 
            from sys.all_objects i 
            where o.type_desc = i.type_desc 
            order by name asc 
            for xml path('')
        ),1,2,'') Objects 
from sys.all_objects o
group by type_desc 
order by type_desc 


select distinct 
     type_desc Category 
    ,t.Objects
from sys.all_objects o 
cross apply (
    select 
        stuff((
            select ', ' + name 
            from sys.all_objects i 
            where o.type_desc = i.type_desc 
            order by name asc 
            for xml path('')
        ),1,2,'') 
) t(Objects)

---

select 
     type_desc Category
    ,(  select count(*) 
        from sys.all_objects i 
        where o.type_desc = i.type_desc 
     ) Count 
    ,stuff((
            select ', ' + name 
            from sys.all_objects i 
            where o.type_desc = i.type_desc 
            order by name asc 
            for xml path('')
        ),1,2,'') Objects 
from sys.all_objects o
group by type_desc 
order by type_desc 

print '------------------------'

select distinct 
     type_desc Category 
    ,t.*
from sys.all_objects o 
cross apply (
    select 
         count(*) Count
        ,stuff((
            select ', ' + name 
            from sys.all_objects i 
            where o.type_desc = i.type_desc 
            order by name asc 
            for xml path('')
        ),1,2,'') Objects 
) t

print '-----------------------------'

select 
     o.type_desc Category  
    ,t.*
from (select distinct type_desc from sys.all_objects) o
cross apply (
    select 
         count(*) Count
        ,stuff((
            select ', ' + name 
            from sys.all_objects i 
            where o.type_desc = i.type_desc 
            order by name asc 
            for xml path('')
        ),1,2,'') Objects 
) t

print '-----------------------------'

select 
     type_desc     Category
    ,count(*)       Count 
    ,string_agg(convert(nvarchar(max), name), ', ') Objects 
from sys.all_objects
group by type_desc 
order by type_desc 

-- select type_desc, name from sys.all_objects
drop table if exists #csvs 
select 
     type_desc     Category
    ,string_agg(convert(nvarchar(max), name), ', ') Objects 
into #csvs
from (select distinct type_desc from sys.all_objects) o 
cross apply (
    select top 100 name
    from sys.all_objects i 
    where i.type_desc = o.type_desc 
    order by name 
) t
group by type_desc 
order by type_desc 




/* splitting csv */

/*
 * Aaron Bertrand - Sentry One 
 *  https://sqlperformance.com/2012/07/t-sql-queries/split-strings
 *
 * CLR - fastest, but let's not go there, even though there is still Adam Mechanic's function out there
 * XML 
 */

declare 
     @csv nvarchar(max) = 'a,bc,def,g'
    ,@delimiter nvarchar(8) = ','

go
create or alter function dbo.SplitStringsWithLoop(@csv nvarchar(max), @delimiter nvarchar(8))
returns @output table(value nvarchar(max))
as
begin 
    declare 
         @value     nvarchar(max)
        ,@i         int             = charindex(@delimiter, @csv)
        
    while @i > 0 
    begin
        select 
             @value = substring(@csv, 1, @i-1)
            ,@csv   = substring(@csv, @i+len(@delimiter), len(@csv)-@i)

        insert into @output values (@value) 

        set @i = charindex(@delimiter, @csv)
    end
    
    return
end
go

select * from dbo.SplitStringsWithLoop('a,bc,def,g', ',')

go
create or alter function dbo.SplitStringsWithTally(@csv nvarchar(max), @delimiter nvarchar(8))
returns table 
as return (
    with tally as (
        select top (10000) row_number() over (order by o1.object_id) n
        from sys.all_objects o1
        cross join sys.all_objects o2
    )
    select substring(@csv, n, charindex(@delimiter, @csv + @delimiter, n)-n) value 
    from tally 
    where n <= len(@csv)
        and substring(@delimiter+@csv, n, len(@delimiter)) = @delimiter
)
go

select * from dbo.SplitStringsWithTally('a,bc,def,g', ',')

go
create or alter function dbo.SplitStringsWithRecursion(@csv nvarchar(max), @delimiter nvarchar(8))
returns table 
as return (
    with cte(valueStart, valueEnd) as (
        select 
             1
            ,charindex(@delimiter, @csv)
        union all 
        select 
             convert(int, valueEnd+len(@delimiter))
            ,charindex(@delimiter, @csv, valueEnd+len(@delimiter))
        from cte
        where valueEnd>0
    )
    select substring(
             @csv
            ,valueStart
            ,case 
                when valueEnd > 0 
                then valueEnd-valueStart 
                else len(@csv)-valueStart+1
             end
        ) value
    from cte
)
go

select * from dbo.SplitStringsWithRecursion('a,bc,def,g', ',')

go
create or alter function dbo.SplitStringsWithXml(@csv nvarchar(max), @delimiter nvarchar(8))
returns table 
with schemabinding 
as return (
    select v.value('(./text())[1]', 'nvarchar(max)') value
    from (
        select convert(xml, '<v>' + replace(@csv, @delimiter, '</v><v>') + '</v>') x
    ) t cross apply x.nodes('v') w(v)
)
go

select * from dbo.SplitStringsWithXml('a,bc,def,g', ',')


if not exists(select 1 from sys.tables where name = 'Tally')
create table Tally (n int not null, constraint PK_Tally primary key(n)) 

insert into Tally (n) 
select row_number() over(order by o1.object_id, o2.object_id) 
from sys.all_objects o1 
cross join sys.all_objects o2 
where not exists(select 1 from Tally)

go
create or alter function dbo.SplitStringsWithTallyTable(@csv nvarchar(max), @delimiter nvarchar(8))
returns table 
with schemabinding 
as return (
    select substring(@csv, n, charindex(@delimiter, @csv + @delimiter, n)-n) value 
    from dbo.Tally 
    where n <= len(@csv)
        and substring(@delimiter+@csv, n, len(@delimiter)) = @delimiter
)
go

select * from dbo.SplitStringsWithTallyTable('a,bc,def,g', ',')



----

print '-----------------------------LOOP-------'
select Category, value  
from #csvs 
cross apply dbo.SplitStringsWithLoop(Objects, ', ')

print '-----------------------------TALLY------'

select Category, value  
from #csvs 
cross apply dbo.SplitStringsWithTally(Objects, ', ')

print '-----------------------------TALLY_TABLE'

select Category, value  
from #csvs 
cross apply dbo.SplitStringsWithTallyTable(Objects, ', ')

print '-----------------------------RECURSION--'

select Category, value  
from #csvs 
cross apply dbo.SplitStringsWithRecursion(Objects, ', ')

print '-----------------------------XML--------'

select Category, value  
from #csvs 
cross apply dbo.SplitStringsWithXml(Objects, ', ')


print '-----------------------------STRING_SPLIT'

select Category, value  
from #csvs 
cross apply string_split(Objects, ',' )



