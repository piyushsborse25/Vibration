## **[[Chapter 1 - Fundamentals of System Design]]**

- High-level vs Low-level Design

- Functional vs Non-functional requirements

- Scalability basics (vertical vs horizontal)

- Latency vs throughput trade-offs

- Estimating load (RPS, storage, cache size)


👉 **Pitfall**: jumping into microservices too early.

---

## **[[Chapter 2 - Networking & APIs]]**

- REST vs gRPC vs WebSockets

- API Gateway (routing, auth, logging)

- Rate limiting & throttling

- Load balancing (DNS, L4, L7, reverse proxy)


👉 **Pitfall**: not considering retries → retry storm

---

## **[[Chapter 3 – Databases & Storage Systems]]**

- SQL vs NoSQL (when to use which)

- DB indexing (B-Tree, Hash, covering index)

- Replication (leader-follower, multi-leader)

- Sharding (hash, range, consistent hashing)

- Federation vs Partitioning

- Transactions (ACID, isolation levels)


👉 **Pitfall**: assuming NoSQL means no transactions

---

## **[[Chapter 4 - Consistency & Reliability]]**

- CAP theorem (CP vs AP)

- Strong vs eventual consistency

- Quorum-based reads/writes

- Idempotency in APIs

- Saga pattern for distributed transactions (Java microservices real case)


👉 **Pitfall**: ignoring duplicate message handling in Kafka

---

## **[[Chapter 5 – Caching & Performance]]**

- Write-through, write-back, write-around

- Cache invalidation strategies

- CDN basics

- Hot key problem

- Cache stampede (solution: locking, request coalescing)


👉 **Pitfall**: caching sensitive data without TTL

---

## **[[Chapter 6 - Messaging & Asynchronous Processing]]**

- Message queue vs Event streaming

- Kafka basics (topics, partitions, consumer groups)

- DLQ (Dead Letter Queue)

- At-least-once vs Exactly-once delivery

- Backpressure handling


👉 **Pitfall**: assuming Kafka guarantees exactly-once by default

---

## **[[Chapter 7 – Architecture Patterns]]**

- Monolith vs Microservices vs Modular

- Event-driven architecture

- CQRS basics

- Saga (choreography vs orchestration with Spring Boot + Kafka)

- Strangler Fig pattern (migrating legacy systems)


👉 **Pitfall**: making too many small services → operational overhead

---

## **[[Chapter 8 - Scalability & Resilience]]**

- Circuit breaker (Resilience4j, Hystrix)

- Service discovery (Eureka, Consul)

- Graceful shutdown in Spring Boot

- Distributed locks (Redis/Zookeeper)

- Leader election basics (not deep, just Raft/Paxos awareness)


👉 **Pitfall**: not handling partial failures between services

---

## **[[Chapter 9 - Deployment & Observability]]**

- Deployment strategies: blue-green, rolling, canary

- Kubernetes basics (pods, services, ingress)

- Health checks (liveness vs readiness)

- Monitoring (Prometheus + Grafana)

- Centralized logging (ELK/EFK)

- Distributed tracing (Zipkin, Jaeger)


👉 **Pitfall**: logging sensitive data (PII, passwords)

---

## **[[Chapter 10 - Security in System Design]]**

- API authentication: OAuth2, JWT

- Authorization: RBAC basics

- Data encryption (at rest, in transit)

- Secret management (Spring Cloud Config, Vault)


👉 **Pitfall**: keeping secrets in code/config

---

## **[[Chapter 11 - Advanced (Good to Mention)]]**

- Hot vs cold data storage

- Schema evolution (Avro, Protobuf with Kafka)

- Multi-region setup basics

- GDPR/data retention awareness

---

# **[[Chapter 12 – Categorized System Design Questions]]**

-  12.1 Fundamentals (Basics)

-  12.2 Intermediate (Most Common)

-  12.3 Applied Real-World

-  12.4 Advanced Distributed Systems

-  12.5 Global & Cutting Edge

## 📚 Resources  

- [Byte Monk](https://youtube.com/playlist?list=PLJq-63ZRPdBt423WbyAD1YZO0Ljo1pzvY&si=XmekirtPo34tfE1q)  
- [BM Questions](https://youtube.com/playlist?list=PLJq-63ZRPdBssWTtcUlbngD_O5HaxXu6k&si=u1Llr5vb6JGqqQt8)  
- [Mastering the System Design Interview](https://www.udemy.com/share/105lfQ3@35wprKQG9_CiVb4YlHLR8oONruYoAhw_j9pjf8VE8VETMDJ4pF_pW5imH08KnYhX/)
- [System Design Interview Question](https://youtube.com/playlist?list=PLPtUyMfD0mNJDZg50fg2CptjLBavHot47&si=ZmPRDiT99C9DURhR)  
- [System Design School](https://systemdesignschool.io/primer#introduction)
