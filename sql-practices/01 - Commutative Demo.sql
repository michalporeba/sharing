select * 
from TableC c 
inner join TableB b on c.Id = b.Id 
inner join TableA a on b.Id = a.Id 
where c.Id > 95

select * 
from TableA a 
left outer join TableB b on a.Id = b.Id 
left outer join TableC c on b.Id = c.Id 
where c.Id > 95

;with c as (
    select * 
    from TableC 
    where Id > 95
)
select * 
from (select * from TableB) b 
cross apply (
    select * 
    from TableA a 
    where b.Id = a.Id
) a
inner join c on c.Id = b.Id 






dbcc freeproccache with no_infomsgs

select t.[text], p.usecounts 
from sys.dm_exec_cached_plans p 
cross apply sys.dm_exec_sql_text(p.plan_handle) t 
where t.[text] like '%TableA%' and t.[Text] not like '%cached_plans%'

dbcc freeproccache with no_infomsgs

select * from dbo.TableA 
select * from dbo.TableA

select * 
from dbo.TableA 