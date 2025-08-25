### **System Design Fundamentals**
1. **Key Concepts:**
   - Scalability (horizontal vs. vertical scaling).
   - High Availability and Fault Tolerance.
   - Consistency vs. Availability (CAP Theorem).
   - Latency and Throughput.

2. **Component Design:**
   - API Gateway, Load Balancer, Proxy.
   - Databases (RDBMS vs. NoSQL).
   - Caching (Redis, Memcached).
   - Message Queues (RabbitMQ, Kafka).

---

### **Low-Level Design (LLD)**
1. **Object-Oriented Design:**
   - Classes, Interfaces, Relationships.
   - Applying SOLID principles.
   - Use of Design Patterns (Factory, Singleton, Observer, etc.).

2. **Examples:**
   - Design a Library Management System.
   - Design an Online Parking Lot System.
   - Design a File Storage System (e.g., Google Drive).

---

### **High-Level Design (HLD)**
1. **Distributed System Design:**
   - Designing scalable systems (e.g., e-commerce, URL shortener, social media platforms).
   - Partitioning and Sharding (database and services).
   - Data Replication and Consistency.

2. **System Components:**
   - Designing RESTful APIs.
   - Rate Limiting and Throttling.
   - Logging and Monitoring (using tools like ELK, Prometheus).

3. **Examples:**
   - Design a URL Shortener like Bitly.
   - Design a News Feed system like Facebook or Twitter.
   - Design a real-time Chat Application.
   - Design a Booking System (e.g., movie tickets, hotel booking).

---

### **Java-Specific Topics in System Design**
1. **Frameworks:**
   - Using Spring Boot for Microservices.
   - Spring Cloud for service registry (Eureka), configuration, and resilience (Resilience4j).

2. **Concurrency:**
   - Handling concurrent requests using Executor Framework.
   - Thread-safe designs (e.g., BlockingQueue).

3. **Database Design:**
   - Schema design for relational databases.
   - Using Hibernate for ORM and efficient queries.

4. **Caching Strategies:**
   - Using Hazelcast or Redis for distributed caching.
   - Implementing cache eviction policies (LRU, LFU).

---

### **Key System Design Concepts**
1. **Databases:**
   - SQL: Normalization, Joins, Indexing.
   - NoSQL: MongoDB, Cassandra (use cases and trade-offs).
2. **API Design:**
   - REST vs. gRPC.
   - Versioning, Pagination, Rate Limiting.
3. **Asynchronous Communication:**
   - Event-driven design using Kafka or RabbitMQ.

---

### **Commonly Asked Scenarios**
1. Design a Scalable URL Shortener.
2. Design an E-commerce System (Search, Catalog, Cart, Checkout).
3. Design a Notification Service (Email, SMS, Push).
4. Design a Real-time Messaging System like WhatsApp.
5. Design a Logging System for Distributed Microservices.