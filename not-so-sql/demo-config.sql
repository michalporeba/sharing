use tempdb 
go

create or alter function dbo.Config() 
returns nvarchar(max) 
AS
BEGIN
    return N'
        {
            "objects": {
                "top": "1",
                "bottom": "2"
            }
        }
    '
END
go

create or alter procedure SelectTopObjects
as
begin
    set nocount on
    declare @top int = isnull(convert(int, json_value(dbo.Config(), '$.objects.top')), 0)
    select top(@top) * from sys.all_objects order by object_id asc
end
go

create or alter procedure SelectBottomObjects
as
begin
    set nocount on
    declare @top int = isnull(convert(int, json_value(dbo.Config(), '$.objects.bottom')), 0)
    select top(@top) * from sys.all_objects order by object_id desc
end
go

exec SelectTopObjects 
exec SelectBottomObjects



--isnull(convert(int, json_value(dbo.GetConfig(), '$.Objects.Top')), 1)

