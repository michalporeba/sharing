Mike Myatt, 2012 - there is no such thing as best practicies - get full quote

Declarative language shouldn't need to understand the internal implementation, yet SQL is not perfect in that regard. 

search for T-SQL not SQL
check the dates

SQL Server tips and tricks. How to think like a DB Dev.
The Internet if full of outdated information. 
The weird and the beautiful. Complex solutions to simple problems and how to avoid them. 
some sergio leone reference? The good, the bad and the ugly Transact-SQL? 

best practicies: 

treat T-SQL as any other language 
but think in sets not in rows
remember it is supposed to be a declarative programming
but knowing how the code will be executed helps with performance. 
use SSOS. 


parameter sniffing

## examples
create or alter 

string aggregation and splitting using old tricks like @variables, loops and xml
lazy joins and filters where isnull(column,'unknown')=@value


start with string aggregation 
then csv splitting using loops, tally, recursive and xml 
go back and explain why loops are bad, how tally can help solve problems, that there are recursive queries (explain CTE) and XML solution

inline valued function, schemabinding, explicit tables

top 3 from category, combine with csv aggregation


when talking about string aggregation using XML explain cross apply and potential benefits, but show how it can easily appear to be slower when mistakes are made
show how tally table with on the fly cross join can be improved with top(10000)
there is recursion limit by default 100


don't assume order - sets are not ordered
but don't order unless it is absolutely necessary

Weird - declarative
Bad 
Ugly 

confusing - it doesn't matter until it does
the execution plan can change with no change to a query
query that ones just worked, starts to time out
optimal plan can be no longer optimal 
parameter sniffing 
implicit type conversion



T-SQL for analytical queries
problems with types (varchar with no precision for example)
querying time - temporal, chage data tracking, problems with timestamp and datetime types
