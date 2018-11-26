# Not so SQL anymore

## About me and the talk

My name is Michal and I am an Explorer 
I work with RDBMS (mostly SQL Server, but MySQL and PostgreSQL too)
Exploring XML and Service Broker in SQL Server since 2005 
Experimenting with NoSQL in 2011 (mong, cassandra, couchdb)
Time Series Database (influxdb) or earlier Round Robin Databases (rrdtool)
Keeping one eye on them but not using them in line of business applications
Talk about getting the benefits of NoSQL when there is no business case to go all in

## The RDBMS era 

Some background - the competing data models that lead to RBDMS era

Edgar Codd in 1970 defines the relational data model (relations and tuples)
Abstraction for business data processing
Normalization to avoid redundancy of data, and improve data integrity
ACID principals emerged eventually in 1983
(Atomicity, Consistency, Isolation, Durability)

1974 - IBM System R
1979 - Oracle (first commercially available)
Mainstream by 1980

SQL-86 - first ANSI standard
89 - minor
92 - major revision
SQL:1999 - recursive queries, procedures, flow control,

and with the turn of millenia the development ended 
at least looking at the code I see nowadays

SQL:2003 - XML related features (windowing functions)
SQL:2006 - more XML and XQuery
SQL:2008 - 
SQL:2011
SQL:2016 - JSON

### Problems with RDBMS

ACID constraints 
Object Relational Impedence Mismatch
Inflexible data model
Normalization - problem with data locality
Scalability - high data volumes or hight write throughputs 

## The NoSQL hype

NoSQL hashtag in 2009
IBM's IMS (Information Management System) for Apollo Program using hierarchical model similar to JSON
Started to work around problems in RDBMS
Types - Key-Value, Document, Column, Graph

### Typical Problems with NoSQL

Many to One and Many to Many relationships
(example of geographical locations with translation)
(recommendations or communication)
Implied schema. Design for read.
CAP theorem - eventual consistency

## The Gap

the need to chose persistent model
the narrowing down (ACID in noSQL)
ANSI Standards - evolution (comparing NoSQL to 90s SQL)

Not Only SQL (http://blog.sym-link.com/2009/10/30/nosql_whats_in_a_name.html)

RethinkDB (JSON Database), Marklogic (Document Database) (ACID)

Document types in RDBMS - history of features

XML in SQL 2005
https://technet.microsoft.com/en-us/library/ms345117%28v=sql.90%29.aspx?f=255&MSPPError=-2147217396

SQL Server 2005 (XML) and 2016 (JSON)
PostgreSQL since version 9.3 (2013) (XML and JSON functions) and 9.5 (2016) (JSON type)
MySQL since version 5.7 (2015) (XML and JSON)
MySQL 8.0 - The Document Store (2018) (XML and JSON)
IBM DB2 since version 10.5 (2013)
Oracle since Oracle9i (2001) XML and since Oracle12c (2013) json

Documents were included in RDBMS before NoSQL and featured in Codd's theory from 1970

## Demo 

queries for xml/json from tables as one object or per row
creating xml/json from variables 
is xml / is json 
schema validation / strict mode 
limitation of return length 
querying documents
updating documents
parameters to stored procedures (instead of table parameters)
open recordset 

graph? 

## Whe use Document types in SQL? 

Solving specific problems without starting from scratch 
Getting the benefits of flexible schema to solve specific problems
Pass through parameters
Better code (complex parameters)

## Will the days of RDBMS come back? 

Mainstream from 1980 because they were good at abstracting physical data models. 
Over the years there were many competitors to the relational model. 
    1970s to 80s - Heirarchical and Network models
    1980s to 90s - Object model
    2000s - XML databases
NoSQL is here to stay but RDBMS are not going anywhere either
