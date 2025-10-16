## ✅ **1. [[System Design]]  & Distributed Systems**

### **Consistency & Reliability**

- **ACID vs BASE** – Strong consistency vs eventual consistency
- **CAP Theorem** – Trade-offs between Consistency, Availability, Partition Tolerance
- **Types of Consistency** – Strong, Eventual, Causal, etc.
- **Idempotency** – Ensuring safe retries without side effects

### **Architecture Patterns**

- **CQRS** – Command Query Responsibility Segregation
- **Event Sourcing** – Persisting state changes as a sequence of events
- **Saga Pattern**
    - *Orchestration vs Choreography* – Managing distributed transactions
- **Event-Driven Architecture (EDA)**

### **Scalability & Resilience**

- **Circuit Breaker Pattern** – Preventing cascading failures
- **Service Discovery** – Eureka, Consul, etc.
- **Load Balancing** – Horizontal scaling strategies
- **Rate Limiting** – API throttling and protection
- **Partitioning & Sharding** – Distributing data across nodes
- **Message Ordering** – Preserving order across partitions
- **Distributed Caching** – Redis, Memcached
- **Server-Sent Events (SSE)** – Real-time push over HTTP
- **Health Checks** – Application liveness/readiness probes

---

## ☕ **2. Core Java**

### **Exception Handling**

- Exception Hierarchy – Checked vs Unchecked
- Exception Translation – Especially in repositories and DAOs

### **[[Multithreading]] & Concurrency**

- `run()` vs `start()` – Execution semantics
- `synchronized` vs ReentrantLock
- **ExecutorService** – Thread pool management
- Concurrency Utilities – `BlockingQueue`, `CopyOnWriteArrayList`, etc.

### **Java Special Collections (Hierarchy)**

- Collections Hierarchy – List, Set, Map
- Null behavior in collections
- Iterators – `Iterator`, `ListIterator`, `Enumeration`
- Legacy Collections – `Vector`, `Hashtable`
- Specialized Maps – `EnumMap`, `WeakHashMap`, `IdentityHashMap`
- Read-Only Collections – `unmodifiableList()`, `Collections.unmodifiableMap()`
- Load Factor & Hashing Concepts
- Red-Black Tree – Underlying structure in `TreeMap`, `TreeSet`

### **I/O and Streams**

- File I/O – Streams, Readers, Writers
- Java Stream API – Grouping, filtering, mapping, etc.

### **Language Features**

- Diamond Operator (`<>`)
- Default Methods in Interfaces
- Enums – Usage, benefits, and patterns

---

## 🌱 **3. Spring & Spring Boot**

### **Core Concepts**

- IoC Container & Dependency Injection
- Bean Scopes – Singleton, Prototype, Request, Session, Application
- Bean Lifecycle – Instantiation, initialization, destruction
- Lifecycle Hooks – `@PostConstruct`, `@PreDestroy`
- Lazy Initialization
- Bean Conflict Resolution
- Handling Circular Dependencies

### **Bean Management**

- Non-singleton Beans – Defining prototype-scoped beans
- `@Configuration` vs `@Component`
- `@Service` vs `@Repository` – Semantics & use-cases
- Bean Initialization Order – `@DependsOn`, `@Order`, `@Priority`
- Can Bean Method Return `void`?

### **Spring Boot Internals**

- `@Import` – Modularizing configuration
- Spring Profiles – Environment-specific configs
- `spring.factories` – SPI mechanism in Spring Boot
- Conditional Annotations:
    - `@ConditionalOnClass`
    - `@ConditionalOnMissingBean`
    - `@ConditionalOnProperty`
- Auto-Configuration – How Spring Boot configures beans magically

### **Spring Data & JPA**

- Repository Interfaces – `CrudRepository`, `PagingAndSortingRepository`
- Entity Design Best Practices
- Transient Fields – `@Transient`
- JPA Lifecycle Events – `@PrePersist`, `@PostPersist`

### **Validation & Security**

- Built-in & Custom Validators
- CSRF Protection
- Common Security Vulnerabilities in Spring apps

### **Spring Ecosystem Extensions**

- Spring Batch – Job configuration and execution
- Spring Integration – Messaging systems
- Spring JMS – Java Message Service integration
- Spring Web Services
- Spring Cloud – Config, Discovery, Circuit Breakers, etc.

---

## 🧩 **4. Microservices Architecture**

- **REST vs SOAP** – Protocol comparison
- **Service Communication** – Sync vs async, REST, gRPC, Messaging
- **API Gateway** – Routing, throttling, auth
- **Service Discovery** – Dynamic service registration
- **Data Consistency** – Saga, CQRS, Eventual consistency
- **Resilience Patterns** – Retry, Circuit Breaker, Timeout, Bulkhead
- **Observability** – Logging, Metrics, Tracing (e.g., ELK, Prometheus + Grafana)

---

## 📊 **5. Kafka**

- Kafka Architecture – Topics, Brokers, Zookeeper
- Partitioning & Ordering Guarantees
- Offset Management – Commit strategies
- Kafka Retention Policies – Data expiry
- Kafka Performance – Zero-copy, batching, log-based design
- Kafka Use Cases – Event sourcing, streaming pipelines
- Kafka Challenges – Message duplication, ordering, backpressure

---

## 🔢 **6. Java Versions**

- **Java 8 Features** – Lambdas, Streams, Optional, Date/Time API, Default Methods
- **Java 11 Features** – var keyword, HttpClient, String methods, Performance improvements
- Java 8 vs Java 11 – Migration considerations

---

## 💡 **7. General Software Engineering**

- **SOLID Principles** – Clean code architecture
- **Design Patterns** – Singleton, Factory, Strategy, Observer, etc.
- **Security Fundamentals** – Common vulnerabilities (XSS, CSRF, SQL Injection)
- **Version Control (Git)** – Branching, merging, rebase
- **Testing** – Unit, Integration, Mocking

---

## 💡 **8. [[Elasticsearch]]**

- **What is Elasticsearch?** – A distributed search and analytics engine used for full-text search, log analysis, and real-time data
- **Indexing & Inverted Index** – Documents are stored in indexes using inverted indexing for efficient searching
- **Shards & Replicas** – Data is distributed and replicated across nodes to ensure scalability and high availability
- **Search Queries** – Supports structured queries, full-text search, filtering, and scoring using relevance algorithms like BM25
- **Aggregations** – Powerful for real-time analytics, metrics, and dashboards
- **Bulk API** – Enables high-performance ingestion of large datasets efficiently
- **Integration with Spring** – `Spring Data Elasticsearch` allows seamless repository-style interaction with Elasticsearch
- **ELK Stack** – Combined with Logstash and Kibana for log aggregation, visualization, and monitoring