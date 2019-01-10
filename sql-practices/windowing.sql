

select 
     object_id 
    ,type_desc
    ,name
    ,len(name) NameLength 
    ,(  select sum(len(name)) 
        from sys.all_objects i
        where i.object_id<=o.object_id 
            and i.type_desc = o.type_desc 
     ) LengthInGroup
    ,(  select sum(len(name))
        from sys.all_objects i
        where i.object_id<=o.object_id 
     ) TotalLength
from sys.all_objects o
order by object_id 



;with o as (select top 10 * from sys.all_objects)
select 
     object_id 
    ,type_desc
    ,name
    ,len(name) NameLength 
    ,(  select sum(len(name)) 
        from o i
        where i.object_id<=o.object_id 
            and i.type_desc = o.type_desc 
     ) LengthInGroup
    ,(  select sum(len(name))
        from o i
        where i.object_id<=o.object_id 
     ) TotalLength
from o o
order by object_id 


select 
     object_id 
    ,type_desc 
    ,name 
    ,len(name) NameLength 
    ,sum(len(name)) over(
        partition by type_desc
        order by object_id 
        rows between unbounded preceding 
             and current row
        ) LengthInGroup
    ,sum(len(name)) over(
        order by object_id 
        rows between unbounded preceding 
             and current row
        ) TotalLength 
from sys.all_objects 
order by object_id 