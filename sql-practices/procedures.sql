
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'SearchA')
DROP PROCEDURE SearchA 
GO 

CREATE PROCEDURE SearchA 
@NAME VARCHAR(MAX),
@TOP INT
AS SELECT TOP(@TOP) * 
FROM sys.sysobjects 
WHERE ISNULL(name,'missing') LIKE ISNULL(@NAME+'%', 'missing')


--- second attempt
if exists(select 1 from sys.procedures where name = 'SearchB')
drop procedure SearchB 

go
create procedure SearchB 
    @name varchar(max),
    @top int 
as 
begin 
    select top(@top) *
    from sys.objects 
    where name like isnull(@name+'%', name)
end
go


--- third attempt
if object_id(N'dbo.SearchC', N'P') is null 
exec(N'create procedure dbo.SearchC as select 1 tmp')
go
alter procedure dbo.SearchC
     @name  varchar(max)    
    ,@top   int
as 
begin
    set nocount on
    select top (@top)
         object_id 
        ,name 
    from sys.objects 
    where 
        @name is null 
        or name like @name+'%'
end
go  


--- fourth attempt 
create or alter procedure dbo.SearchD
     @name  sysname    
    ,@top   int             = 3
as 
begin
    set nocount on; 
    select top (@top)
         object_id 
        ,name 
    from sys.objects 
    where 
        @name is null 
        or name like @name+'%'
    order by object_id;
end
go 

