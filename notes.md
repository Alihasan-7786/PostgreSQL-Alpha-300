what kind of things are we storing ?
we are storing a list of cities.
we should create a table called cities.
what properties does this things have?
each city has a name, country, population, and area
the table should have columns of name county, population , area .
what type of data soes each of those properties contain?
name --> string 
country --> string
population --> number
area --> number 
each column should indicate the type of data tyat it is going to store
 





  keyword: CREATE TABLE
  identifier: cities
VARCHAR(50) is the cariable character that can only store character upto 50 

INSERT INTO
  cities(name, country, population, area)
VALUES
  ('tokyo', 'Japan', 38505000, 8223),
  ('Delhi', 'India', 28125000, 2240),
  ('Shanghai', 'China', 22125000, 4015),
  ('sao paulo', 'Brazil', 20935000, 3043);



1NF
* using row order to convey information is not permitted
*mixing data types within the same column is not permitted 
*having a table without primary key is not permittedd 
* repeating groups are not permitted
Normalization begins here to ensure basic data structure integrity. Key rules include:

No row order: Row order should not be used to convey meaning.
Atomic data types: Every column must contain only one data type (e.g., no mixing strings and integers).
Primary Key: Every table must have a primary key to uniquely identify each row.
No repeating groups: Data must not be stored in repeating groups (like a wide table with many columns for inventory); instead, use separate rows.

2NF
2NF addresses the relationship between non-key attributes and the primary key.

Rule: Every non-key attribute must be dependent on the entire primary key, not just a part of it.
The Problem: If an attribute depends only on part of a composite key, it causes anomalies (e.g., repeating a player's rating multiple times because it depends only on the player ID, not the inventory item).
The Solution: Split the table into smaller tables so that each attribute is tied to its relevant, complete key.

3NF
3NF further refines the design by removing transitive dependencies.

Rule: Every non-key attribute must depend on the key, the whole key, and nothing but the key.
The Problem: A non-key attribute depending on another non-key attribute creates a transitive dependency (e.g., player rating depending on skill level, which depends on player ID).
The Solution: Move the dependent attributes to a separate lookup table.
Note: The video briefly notes Boyce-Codd Normal Form (BCNF), a slightly stronger version of 3NF where every attribute must depend on the key, regardless of whether it's a key or non-key attribute.

Boyce-codd normal form(BCNF)
each attribute in the table must depend on the key, the whole key, and nothing but the key .


4NF
4NF focuses on multivalued dependencies.

Rule: A table should not contain more than one independent multi-valued dependency (e.g., if a birdhouse model has multiple available colors and multiple available styles, they are independent facts).
The Solution: Split independent facts into separate tables to prevent data inconsistencies when updating lists.

5NF
5NF is the final stage ensuring a table cannot be broken down further.

Rule: A table is in 5NF if it cannot be decomposed into smaller tables that, when joined back together, recreate the original data.
The Goal: If a table can be logically represented as the result of joining smaller, specific tables, it is not in 5NF and should be decomposed.


*DENORMALIZATION*
Denormalization is the intentional process of adding redundancy to a database design, or choosing not to normalize it at all, to achieve specific practical or performance goals

Normally, designers normalize tables to ensure data integrity and prevent inconsistencies. However, you might choose to denormalize for a few key reasons:
*Flexibility against changing rules: Sometimes, rigid normalized structures can break if business rules change (e.g., pricing policies). Keeping data in a simpler, denormalized format can be more resilient to these changes.
*Performance optimization: In some cases, joining many large tables can be slow. If you cannot optimize the process through the database's processing layer (like indexing), you might denormalize by duplicating data to avoid expensive JOIN operations.
*Read-only reporting: In systems like data marts, where the goal is to provide intuitive and fast access to data for users, designers often use denormalized structures (like facts and dimensions) to make queries easier and more efficient.
The Trade-off: The main risk of denormalization is data inconsistency, where different parts of the database might hold conflicting information because the same data is stored in multiple places.

*Tpyes of keys*
*primary key 
he main, unique identifier for a row (e.g., a State Code like 'RJ' in INDIA). It cannot contain null values and must be 100% reliable for identifying a specific record.
*candidate key 
 Any column (or set of columns) that could have served as the Primary Key because it uniquely identifies rows (e.g., State Name could also be a unique identifier).
 *Alternate key
 Any Candidate Key that was not chosen to be the Primary Key. You can set these to be unique, even if they aren't the primary identifier.
 *super key
 A combination of columns that identifies a row, but is not "irreducible." If you include extra, unnecessary columns (like State Code + Region), it is a Superkey, not a Candidate Key.
 *Foreign key
 A column that links to a Primary Key in another table. This ensures data consistency by forcing values in one table to match existing records in another (e.g., a voter's state code must match a valid state code in the states table).
 *surrigate key 
An artificial, arbitrary ID created by the database (e.g., a numeric State ID). It has no real-world meaning and only exists to identify rows within the system.
*natural key 
An identifier that has meaning in the real world, such as an email address, social security number, or postal code.
*Intelegent key 
A Natural Key where the parts of the code have specific meanings (e.g., a product code like CLS-TRN-016 where 'CLS' stands for 'Classic' and 'TRN' for 'Train'). These can be risky if those meanings change over time.

*Entity relationship diagram*

An Entity Relationship Diagram (ERD) is a visual tool used to map out the logical structure of a database . Think of it as a blueprint or a map that helps designers clarify exactly what data needs to be stored and how different pieces of information relate to each other.
Entities: These are the "things" or nouns you need to keep track of, such as a Person or a Pet.
Relationships: These describe how those things interact, such as a Person owning a Pet
Cardinality: This is a fancy term for asking "how many." It defines the rules for these connections—for instance, can one person own multiple pets, or just one?
Attributes: These are the specific details or characteristics of an entity, like a pet's Name, Photo, or Type.

crow's foot notation 
use specific symbols at end of the realtionship lins to deifne cardinality:0 a circle for zero , a verrticle line for  one, a crow foot for multiple\many . each end of the line has two symbols to represent the minimum and maximun constraints.
many to many relationship :
many pets own by the many peoplw and manmy people can pet many pets so its many to many relationship
many to one:
a mother can have miultiple daughter but a daughter can not have many mother 
one to one:
each employee have i id card and each id card belongs to one employee

*SQL joins*
inner joins 
Explains how to retrieve only rows with successful matches cross tables, using a chemical compound database example.
left outer join
 Details how to include all rows from a primary table, even when there is no matching record in the secondary table, resulting in NULL values where data is missing.
 RIGHT OUTER JOIN 
 Describes how this is functionally equivalent to a left join, simply changing the perspective of which table is considered the "left" or "right" source.
CROSS JOIN
Covers how to generate a Cartesian product, pairing every row from one table with every row of another.
SELF-JOIN
Demonstrates how to join a table to itself, illustrated by an example of an employee table mapping staff to their respective approvers.

*Boyce-codd normal form *
the difference btw bcnf and 3nf is that bcnf is a slightly stronger and moe rigorous version of 3nf
in 3nf each non-key attribute in a table should depend on the key, the whole key, and nothing but the key 
