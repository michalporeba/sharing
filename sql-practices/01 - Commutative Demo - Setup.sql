use tempdb 
go

drop table if exists TableA
drop table if exists TableB
drop table if exists TableC

-- create test tables 
create table TableA (Id int not null identity primary key, [Value] uniqueidentifier default newid())
create table TableB (Id int not null identity primary key, [Value] uniqueidentifier default newid())
create table TableC (Id int not null identity primary key, [Value] uniqueidentifier default newid())
go 

-- populate test tables 
insert into TableA default values 
go 100

insert into TableB default values 
go 500 

insert into TableC default values 
go 1000 


select top 10 * from TableA
select top 10 * from TableB
select top 10 * from TableC
