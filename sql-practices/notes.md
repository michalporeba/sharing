# SQL Practicies Notes

It is a document with random thoughts, quotes and ideas that can be used in the future to make this talk better. 

Mike Myatt, 2012 

https://www.forbes.com/sites/mikemyatt/2012/08/15/best-practices-arent/#4fbdca8d407b

> “There is no such thing as best practices.” The reality is best practices are nothing more 
> than disparate groups of methodologies, processes, rules, concepts and theories that attained
> a level of success in certain areas, and because of those successes, have been deemed as universal
> truths able to be applied anywhere and everywhere. Just because someone says something doesn’t
> mean it’s true. Moreover, just because “Company A” had success with a certain initiative 
> doesn’t mean that “Company B” can plug-and-play the same process and expect the same outcome. 
> There is always room for new thinking and innovation, or at least there should be.

Declarative language shouldn't need to understand the internal implementation, yet SQL is not perfect in that regard. 


SQL Server tips and tricks. How to think like a DB Dev.
The Internet if full of outdated information. 
The weird and the beautiful. Complex solutions to simple problems and how to avoid them. 
some sergio leone reference? The good, the bad and the ugly Transact-SQL? 

good practicies: 

treat T-SQL as any other language 
but think in sets not in rows
remember it is supposed to be a declarative programming
but knowing how the code will be executed helps with performance. 
use SSOS. 


## other potential examples
parameter sniffing
string splitting using old tricks like @variables, loops and xml

csv splitting using loops, tally, recursive and xml 
go back and explain why loops are bad, how tally can help solve problems, that there are recursive queries (explain CTE) and XML solution

inline valued function, schemabinding, explicit tables

confusing - it doesn't matter until it does
the execution plan can change with no change to a query
query that ones just worked, starts to time out
optimal plan can be no longer optimal 
parameter sniffing 

