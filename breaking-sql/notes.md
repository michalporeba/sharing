## varchar of surprising length

declare @short  varchar         = 'long text'
declare @long   varchar(max)    = convert(varchar, 'a very long text that does not make much sense but works as an example)

select @short [Text], len(@short) [Length]
union all select @long, len(@long)

## datetime precision problems