# Levels of schema

Database diagrams can model one of three levels of schema, with each level demonstrating a different level of abstraction. The levels are:

- Conceptual
- Logical
- Physical

The level of detail increases from conceptual to physical.

 

### Conceptual

 A conceptual database diagram has a high-level design and is concerned with bigger objects and higher level concepts. A conceptual diagram is not concerned with how data values will be stored in a database. It identifies entities and their relationships. Conceptual schemes are sometimes referred to as an entity-relationship model.

In a conceptual schema diagram, entities are represented as rectangles with the entity name in the middle and relationships are represented as lines. The lines can represent 'one' (straight line) or 'many' (branched line) relationships.

![Levels%20of%20schema%2076aac5cdc9c04d4383f21f8d6c35ba6b/Untitled.png](Levels%20of%20schema%2076aac5cdc9c04d4383f21f8d6c35ba6b/Untitled.png)

### Logical

A logical schema is somewhere between a conceptual and physical schema. It might list the attributes and their data types (similar to physical schema) but in a manner that isn't specific to a particular database. Don't usually spend much time on this step.

### Physical

A physical schema is a low-level design concerned with the database-specific implementation of the objects detailed in the conceptual schema. This schema outlines the attributes in the database, the data types of the attributes and the relationships they have to one another. 

![Levels%20of%20schema%2076aac5cdc9c04d4383f21f8d6c35ba6b/Untitled%201.png](Levels%20of%20schema%2076aac5cdc9c04d4383f21f8d6c35ba6b/Untitled%201.png)

Conceptual schema at the top with physical schema of the same model below.

![Levels%20of%20schema%2076aac5cdc9c04d4383f21f8d6c35ba6b/Untitled%202.png](Levels%20of%20schema%2076aac5cdc9c04d4383f21f8d6c35ba6b/Untitled%202.png)