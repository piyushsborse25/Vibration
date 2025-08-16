## **1. Fundamentals (must-have)**

- High-level vs Low-level Design

- Functional vs Non-functional requirements

- Scalability basics (vertical vs horizontal)

- Latency vs throughput trade-offs

- Estimating load (RPS, storage, cache size)


👉 **Pitfall**: jumping into microservices too early.

---

## **2. Networking & APIs**

- REST vs gRPC vs WebSockets

- API Gateway (routing, auth, logging)

- Rate limiting & throttling

- Load balancing (DNS, L4, L7, reverse proxy)


👉 **Pitfall**: not considering retries → retry storm

---

## **3. Storage & Databases**

- SQL vs NoSQL (when to use which)

- DB indexing (B-Tree, Hash, covering index)

- Replication (leader-follower, multi-leader)

- Sharding (hash, range, consistent hashing)

- Federation vs Partitioning

- Transactions (ACID, isolation levels)


👉 **Pitfall**: assuming NoSQL means no transactions

---

## **4. Consistency & Reliability**

- CAP theorem (CP vs AP)

- Strong vs eventual consistency

- Quorum-based reads/writes

- Idempotency in APIs

- Saga pattern for distributed transactions (Java microservices real case)


👉 **Pitfall**: ignoring duplicate message handling in Kafka

---

## **5. Caching & Performance**

- Write-through, write-back, write-around

- Cache invalidation strategies

- CDN basics

- Hot key problem

- Cache stampede (solution: locking, request coalescing)


👉 **Pitfall**: caching sensitive data without TTL

---

## **6. Messaging & Async Processing**

- Message queue vs Event streaming

- Kafka basics (topics, partitions, consumer groups)

- DLQ (Dead Letter Queue)

- At-least-once vs Exactly-once delivery

- Backpressure handling


👉 **Pitfall**: assuming Kafka guarantees exactly-once by default

---

## **7. Architecture Patterns**

- Monolith vs Microservices vs Modular

- Event-driven architecture

- CQRS basics

- Saga (choreography vs orchestration with Spring Boot + Kafka)

- Strangler Fig pattern (migrating legacy systems)


👉 **Pitfall**: making too many small services → operational overhead

---

## **8. Scalability & Resilience**

- Circuit breaker (Resilience4j, Hystrix)

- Service discovery (Eureka, Consul)

- Graceful shutdown in Spring Boot

- Distributed locks (Redis/Zookeeper)

- Leader election basics (not deep, just Raft/Paxos awareness)


👉 **Pitfall**: not handling partial failures between services

---

## **9. Deployment & Observability**

- Deployment strategies: blue-green, rolling, canary

- Kubernetes basics (pods, services, ingress)

- Health checks (liveness vs readiness)

- Monitoring (Prometheus + Grafana)

- Centralized logging (ELK/EFK)

- Distributed tracing (Zipkin, Jaeger)


👉 **Pitfall**: logging sensitive data (PII, passwords)

---

## **10. Security**

- API authentication: OAuth2, JWT

- Authorization: RBAC basics

- Data encryption (at rest, in transit)

- Secret management (Spring Cloud Config, Vault)


👉 **Pitfall**: keeping secrets in code/config

---

## **11. Advanced (Good to Mention, Not Expected to Master)**

- Hot vs cold data storage

- Schema evolution (Avro, Protobuf with Kafka)

- Multi-region setup basics

- GDPR/data retention awareness


---

✅ For **3 years Java developer interviews**, interviewers mostly expect you to:

- Design **medium-scale systems** (e.g., URL shortener, e-commerce order system, notification system)

- Explain **trade-offs** (SQL vs NoSQL, sync vs async)

- Connect theory with **Spring Boot + Kafka + DB** real-world examples
