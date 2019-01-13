set nocount on;

declare @ts datetime = getdate()

declare @i int = 0;
declare @t table (Sample int, Ts datetime)

while @i<1000
begin
    set @ts = dateadd(MILLISECOND, 1, @ts) 
    insert into @t values (@i, @ts)
    set @i += 1
end

select * from @t 


        select convert(datetime2, '2019-01-04 23:50:58.94012') 
union all select convert(datetime2, '2019-01-04 23:50:58.94433') 
union all select convert(datetime2, '2019-01-04 23:50:58.9455') 
