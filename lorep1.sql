//Creating cluster1 

C:\Program File\PostgreSQL\10\bin\initdb -D d:\clu1 -U PostgreSQL -W



//Starting cluster1 and check the connction server


C:\Program File\PostgreSQL\10\bin\pg_ctl -D d:\clu1 start

C:\Program File\PostgreSQL\10\bin\pg_ctl -D d:\clu1 status

C:\Program File\PostgreSQL\10\bin\psql -d postgres -p 9999 -U PostgreSQL




//creating database and table on clu1

postgres=#create database test1;
CREATE DATABASE
postgres=#
postgres=#\c test1
You are now connected to database "test1" as user "postgres" .
test1=#
test1=#create table empinfo(id serial,name text,price decimal,constraint test1_pkey primary key(id));
CREATE TABLE


//Creating role for Replication

test1=#create role test1user with replication login password 'secret_password';
CREATE ROLE
test1=#grant all privileges on database test1 to test1user;
GRANT
test1=#grant all privileges on all tables in schema public to test1user;
GRANT
test1=#create publication my_publica;
CREATE PUBLICATION
test1=#alter publication my_publica add table empinfo;
ALTER
test1=#
test1=#
test1=#insert into empinfo (name, price) values ('icecream',10.10);
test1=#insert into empinfo (name, price) values ('sweet',501.10);
test1=#insert into empinfo (name, price) values ('choki',94.20);
test1=#insert into empinfo (name, price) values ('cake',15.92);
test1=#insert into empinfo (name, price) values ('milkybar',20.10);
INSERT 5 5
test1=#
test1=#
test1=#select * from empinfo;
id  |  name    | price |
-----------+----------+-------
1   | icecream | 10.10
2   | sweet    | 501.10 
3   | choki    | 94.20
4   | cake     | 15.92 
5   | milkybar | 20.10

//Creating cluster2 

C:\Program File\PostgreSQL\10\bin\initdb -D d:\clu2 -U Postgresql


//Starting cluster2 and check the connction server

C:\Program File\PostgreSQL\10\bin\pg_ctl -D d:\clu2 start

C:\Program File\PostgreSQL\10\bin\pg_ctl -D d:\clu2 status

C:\Program File\PostgreSQL\10\bin\psql -d postgres -p 9898 -U Postgresql



//creating database and table on clu2

postgres=#create database test1;
CREATE DATABASE
postgres=#
postgres=#\c test1
test1=#
test1=#create table empinfo(id serial,name text,price decimal,constraint test1_pkey primary key(id));
CREATE TABLE
test1=#
test1=#
test1=#create subscription my_subs connection 'host=localhost port=9999 password=secret_password user=test1user dbname=test1' publication my_publica;
CREATE SUBSCRIPTION
test1=#
test1=#select * from empinfo;
id  |  name    | price |
-----------+----------+-------
1   | icecream | 10.10
2   | sweet    | 501.10 
3   | choki    | 94.20
4   | cake     | 15.92 
5   | milkybar | 20.10





