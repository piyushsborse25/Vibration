### **1. System Design Fundamentals**
* High-level vs Low-level Design
* Functional vs Non-functional Requirements
* Scalability (Vertical vs Horizontal)
* Latency vs Throughput
* Load Balancing (DNS, Client-side, Layer 4, Layer 7)
* Caching strategies (write-through, write-back, cache invalidation)
* Database replication & sharding
* API rate limiting and throttling
* CDN basics
* Fault tolerance and redundancy
* Data partitioning vs data federation

### **2. Consistency & Reliability**
* ACID properties
* Isolation levels: Read Uncommitted, Read Committed, Repeatable Read, Serializable
* CAP theorem and trade-offs (CP, AP, CA)
* Types of consistency: strong, eventual, causal, monotonic
* Quorum-based reads/writes
* Idempotency techniques
* Distributed transactions (2PC, 3PC)

### **3. Architecture Patterns**
* CQRS pattern
* Event sourcing basics
* Event-driven architecture
* Saga pattern (choreography vs orchestration)
* Microservices vs monolith vs modular

### **4. Scalability & Resilience**
* Circuit breakers (Hystrix, Resilience4j)
* Service discovery (Eureka, Consul, Zookeeper)
* Health checks (liveness, readiness probes)
* Graceful shutdown
* Distributed locking mechanisms (Redis, Zookeeper)
* Leader election algorithms (Raft, Paxos)
* Message ordering strategies
* Partitioning techniques (hash-based, range-based, consistent hashing)

### **5. Communication & Data Flow**
* Server-Sent Events (SSE) vs WebSockets vs Long Polling
* Asynchronous messaging
* Message brokers vs event streaming
* Dead-letter queues (DLQ)

### **6. Deployment & Operations**
* Blue-green deployments 
* Canary releases
* Rolling updates
* Monitoring (Prometheus, Grafana)
* Distributed tracing (Jaeger, Zipkin)
* Centralized logging (ELK, EFK)

### **7. Security**
* API authentication (OAuth2, JWT, mTLS)
* API rate limiting for security
* Data encryption at rest & in transit

### **8. Additional Topics**
* API versioning
* Data retention policies
* Schema evolution and compatibility
* Backpressure handling
* Hot vs cold data storage strategies