use tempdb 
go

select *
from openjson(dbo.GetJson())
with (
     id         int                 '$.id'
    ,date       datetime2(0)        '$.date'
    ,username   varchar(32)         '$.username'
    ,country    varchar(2)          '$.country'
    ,email      nvarchar(256)       '$.email'
    ,category   nvarchar(32)        '$.category'
    ,comment    nvarchar(max)       '$.comment'
)
for xml path('comment'), root('comments')