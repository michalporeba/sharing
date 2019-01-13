testing sql
talk for testers
showing how sql code can be broken

transact-sql 
can be full of surprises for developers using primarily other, imperative languages. Throw, raiserror, catch that doesn't always catch, problems with datetime, varchar without precision. 


csv splitting using loops, tally, recursive and xml 
go back and explain why loops are bad, how tally can help solve problems, that there are recursive queries (explain CTE) and XML solution

inline valued function, schemabinding, explicit tables

top 3 from category, combine with csv aggregation


when talking about string aggregation using XML explain cross apply and potential benefits, but show how it can easily appear to be slower when mistakes are made
show how tally table with on the fly cross join can be improved with top(10000)
there is recursion limit by default 100

T-SQL for analytical queries
problems with types (varchar with no precision for example)
querying time - temporal, chage data tracking, problems with timestamp and datetime types
