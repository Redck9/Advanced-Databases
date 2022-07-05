# Advanced-Databases
This project aims at comparing a relational database and a NoSQL database in terms of data modelling, querying, transactions and optimizations.

<br> 

## Infrastructure:

- Relational: 

  - PostgreSQL: It is recommended to use a local installation of the PostgreSQL (http://www.postgresql.org/). If not possible the appserver can be used (http://appserver.di.fc.ul.pt/phpPgAdmin/). Other DBMS can be used but they will have no support. You can use https://www.pgadmin.org/  as a frontend for PostgreSQL.

- NoSQL: 

  - Document database: MongoDB (use a local installation or a free cloud installation with Atlas - up to 500Mb)

  - Graph database: Neo4J (use a local installation, try the sandboxes to help you get creative and design interesting queries)
  
<br>  
  
## Data:
The data for the project consists of 5 csv files extracted from dbpedia (www.dbpedia.org)

Take a look at http://dbpedia.org/page/Radiohead if you are curious.

<br> 

## Files:
**band-band_name.csv:** Contains 10k music band dbpedia URIs, and band names

**band-album_data.csv:** Contains band URIs and associated album names, along with their abstract, release date, running time (in minutes) and sales amount (if available).

**band-genre_name.csv:** Contains band URIs and genre names associated with the music band

**band-member-member_name.csv:** Contains band URIs, current member URIs and their names associated with the music band

 **band-former_member-member_name.csv:** Contains band URIs, former member URIs and their names associated with the music band

<br> 

## Part 1: Data Modelling and Querying

### Tasks:
1. Select which NoSQL database you wish to work with (MongoDB or Neo4j 

2. Write the specifications for two fairly complex data operations that are able to showcase the differences between relational and NoSQL databases 

    1. Example: Insert a new album called "Best Of" for a band that released their first album in the 70s who sold the most albums in the 90s.

    2. This is a complex operation because it includes multiple queries, includes write and read operations, and includes heavy queries (sort by, group by, range queries).
    3. The two operations must create possible conflicts when run at the same time, e.g. they read/write the same piece of data
3. Define the relational schema :
    1. You can draw an Entity-Relationship model
    2. You can draw a a Relational Diagram
    3. You MUST write the CREATE TABLES statements
4. Build a relational database in Postgres to store your data and implement the operations designed in 2.

5. Build a NoSQL database in the system selected in 1 to store your data and implement the operations designed in 2.

<br> 

### Part 2: Reliability and Scalability
This part of the project focuses on the Relational Database and reliability of transactions. You will learn how to code complex operations in a procedural language and then use these in concurrency anomaly experiments. You will learn how to identify, demonstrate and solve concurrency anomalies.

1. Implement your complex operations in PL/pgSQL:
    1. Using the operations designed in part 1, implement each of them as part of a single procedure with at least two separate queries.
    2. Implement simple WRITE queries that change the data read by the complex operations to support your concurrency experiments.
2. Concurrency anomalies experiments
    1. Identify the types of concurrency anomalies that concurrent execution of your operations could result in
    2. Demonstrate concurrency issues (following the tutorial example) by:
        1. changing isolation levels in Postgres
        2. using the sleep function inside the procedure.
    3. Solve the concurrency anomalies using locks inside your procedures
    4. Compare the use locks and isolation level settings.

<br> 

### Part 3: Indexing and Optimization
This part of the project focuses on improving the performance of your databases, both relational and NoSQL. You will learn how to use indexes and consider query rewriting to improve query performance and how to do schema and data model optimization. You will learn how to evaluate the impact of these changes in the performance of your database.

1. Rewrite the queries developed in part 1 and 2 in case they can be optimized.

2. Apply indexes to both your databases (relational and NoSQL) to improve the performance of your complex operations implemented in parts 1 and 2.

3. Introduce changes to the relational schema to improve the performance

4. Consider alterations to the data model in NoSQL to improve the performance

5. Demonstrate the impact of the options 1-4 in each query performance using the analytical tools provided by each database system.

6. Discuss the trade-offs (if any) between each design choice for each query.
