Databases form the backbone of almost every large-scale system. Whether it’s Netflix tracking what you watched, Amazon storing your orders, or a payment service logging transactions, databases ensure that data is **stored, retrieved, and managed efficiently**.

System design interviews test your ability to **choose the right database**, **model data correctly**, and **design for scale, consistency, and fault tolerance**. This chapter will deeply explore:

1. **Relational Databases (SQL)**
    
2. **NoSQL Databases (Document, Key-Value, Column, Graph)**
    
3. **Database Indexing**
    
4. **Replication & Sharding**
    
5. **Consistency Models (CAP Theorem, PACELC)**
    
6. **Transactions & Isolation Levels**
    
7. **Data Partitioning Strategies**
    
8. **Data Warehousing & Analytics Systems**
    
9. **Pitfalls & Trade-offs in Database Design**
    
10. **Real-world case studies (Amazon, Uber, Netflix, Twitter)**
    

---

## 3.1 Relational Databases (SQL)

Relational databases (RDBMS) like **MySQL, PostgreSQL, Oracle, IBM DB2** are the oldest and most widely used form of structured storage. They use **tables (rows & columns)** with a fixed schema and enforce **ACID (Atomicity, Consistency, Isolation, Durability)** guarantees.

- **Strengths:**
    
    - Strong consistency.
        
    - Powerful query language (SQL).
        
    - Well-suited for structured data and relationships.
        
    - Transactions ensure reliability.
        
- **Weaknesses:**
    
    - Difficult to scale horizontally beyond a certain limit.
        
    - Schema rigidity makes them less flexible for fast-changing applications.
        

👉 Example in an interview:

- “How would you store banking transactions?” → Likely SQL, because strong consistency is required.
    
- “How would you store social media posts?” → Could use SQL, but at scale, NoSQL is often better.
    

---

## 3.2 NoSQL Databases

NoSQL arose to handle **scale, unstructured data, and high availability** where SQL struggled. Types include:

1. **Key-Value Stores (Redis, DynamoDB):**
    
    - Store data as `{key → value}`.
        
    - Extremely fast lookups.
        
    - Great for caching, session storage, user profiles.
        
2. **Document Stores (MongoDB, Couchbase):**
    
    - Store JSON-like documents.
        
    - Flexible schema.
        
    - Ideal for user-generated content, product catalogs.
        
3. **Column Stores (Cassandra, HBase):**
    
    - Store data in **columns instead of rows**.
        
    - Optimized for large-scale analytics, time-series, logging.
        
4. **Graph Databases (Neo4j, JanusGraph):**
    
    - Store entities as **nodes** and relationships as **edges**.
        
    - Excellent for social networks, recommendation engines, fraud detection.
        

👉 Interview Tip:  
Be ready to compare SQL vs NoSQL in terms of **consistency, scalability, flexibility, and query capabilities**.

---

## 3.3 Database Indexing

Indexes are like the “table of contents” of a book – they help databases locate rows quickly without scanning the entire table.

- **B-Tree Indexes:** Balanced search trees for range queries.
    
- **Hash Indexes:** Fast lookups for exact matches.
    
- **Full-text Indexes:** For search functionality (like Google’s inverted index).
    

👉 Pitfall: Over-indexing slows down writes, while under-indexing slows down reads. In interviews, always mention the **read/write trade-off**.

---

## 3.4 Replication & Sharding

- **Replication:** Keeping multiple copies of data across servers.
    
    - _Master-Slave:_ Writes go to master, reads from slaves.
        
    - _Master-Master:_ Both can accept writes (but conflict resolution needed).
        
- **Sharding:** Splitting data across multiple servers.
    
    - _Range-based sharding:_ Split by ranges (e.g., A–M, N–Z).
        
    - _Hash-based sharding:_ Distribute based on hash(userId).
        
    - _Geo-sharding:_ Store data near the users’ location.
        

👉 Example: Twitter shards tweets by user ID, so no single DB holds all tweets.

---

## 3.5 Consistency Models (CAP Theorem, PACELC)

- **CAP Theorem:** You can only choose 2 out of 3:
    
    - Consistency (every read sees the latest write)
        
    - Availability (system always responds)
        
    - Partition Tolerance (system works despite network failures)
        
- **PACELC:** If Partition happens → choose **A vs C**, else → tradeoff between **Latency vs Consistency**.
    

👉 Example:

- Banking → CP (Consistency + Partition tolerance).
    
- Social media feeds → AP (Availability + Partition tolerance).
    

---

## 3.6 Transactions & Isolation Levels

- **ACID Transactions** ensure reliability.
    
- **Isolation Levels:** Read Uncommitted → Read Committed → Repeatable Read → Serializable.
    
    - Tradeoff: Higher isolation = slower performance.
        

---

## 3.7 Data Partitioning Strategies

- **Horizontal Partitioning (Sharding):** Split rows across servers.
    
- **Vertical Partitioning:** Split tables by columns.
    
- **Directory-based Partitioning:** Use lookup service to decide where to store.
    

---

## 3.8 Data Warehousing & Analytics Systems

- **OLTP (Online Transaction Processing):** Small, frequent transactions (banking, orders).
    
- **OLAP (Online Analytical Processing):** Aggregations & reports (business intelligence).
    

Tools: Snowflake, BigQuery, Redshift.

---

## 3.9 Pitfalls & Trade-offs

- Using SQL where NoSQL fits better → performance bottlenecks.
    
- Using NoSQL where SQL is needed → loss of data integrity.
    
- Poor indexing → slow queries.
    
- Wrong sharding key → data skew.
    

---

## 3.10 Real-world Case Studies

- **Amazon:** DynamoDB for product catalog (availability focus).
    
- **Uber:** Cassandra for trip logs, MySQL for payments.
    
- **Netflix:** Cassandra + Redis + Elasticsearch for different workloads.
    
- **Twitter:** MySQL + custom sharding for tweets.
    