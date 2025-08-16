### 7.1 Introduction

Architecture patterns are **blueprints** for structuring systems. They don’t prescribe exact technologies but instead define **high-level styles** that influence scalability, reliability, maintainability, and cost.

Interviewers use architecture questions to check if you understand **trade-offs**, not just buzzwords. It’s less about saying _“microservices are better”_ and more about being able to explain _when and why you’d choose one over another_.

---

### 7.2 Monolith vs. Microservices vs. Modular Architecture

#### Monolithic Architecture

- **Definition**: Entire application deployed as a single unit (e.g., WAR file in Java).
    
- **Strengths**:
    
    - Simple to develop and deploy.
        
    - Shared memory and transactions across components.
        
    - Easy debugging and monitoring.
        
- **Weaknesses**:
    
    - Hard to scale individual features.
        
    - Long build and deployment times.
        
    - A single bug may crash the whole system.
        
- **Use Case**: Startups, MVPs, low-scale apps.
    

#### Modular Monolith

- **Definition**: Codebase is modularized internally (separate modules with clear boundaries) but still deployed as a single artifact.
    
- **Strengths**:
    
    - Enforces good boundaries early.
        
    - Easier to later migrate to microservices.
        
    - Less operational overhead than microservices.
        
- **Weaknesses**:
    
    - Still limited by deployment as a single unit.
        
- **Use Case**: Growing teams that want to avoid microservices overhead too early.
    

#### Microservices Architecture

- **Definition**: Independent services, each owning its own database, communicating via APIs or messaging.
    
- **Strengths**:
    
    - Independent scaling of services.
        
    - Independent deployment cycles.
        
    - Polyglot freedom (different languages/DBs per service).
        
- **Weaknesses**:
    
    - Operational overhead (DevOps, monitoring, logging, service discovery).
        
    - Distributed transactions are hard.
        
    - Network failures must be handled.
        
- **Use Case**: Large-scale, fast-moving organizations (Netflix, Amazon).
    

👉 **Interview Tip**: Always highlight that microservices aren’t “better” by default. They bring trade-offs. Mention **team autonomy** and **independent scaling** as reasons to adopt them, not just buzzword compliance.

---

### 7.3 Event-Driven Architecture

- **Definition**: Instead of synchronous request/response, services communicate via **events** (messages, Kafka topics, RabbitMQ).
    
- **Flow**:
    
    - Producer emits an event (e.g., “OrderPlaced”).
        
    - Consumers subscribe and react independently (e.g., Inventory Service reserves stock, Payment Service charges, Notification Service sends email).
        
- **Strengths**:
    
    - Loose coupling between services.
        
    - Natural scaling for async workflows.
        
    - Enables real-time streaming.
        
- **Weaknesses**:
    
    - Debugging is harder (event chains are asynchronous).
        
    - Eventual consistency issues.
        
- **Use Case**: E-commerce order processing, IoT data ingestion, real-time analytics.
    

👉 **Java Spring Boot Example**:  
Using **Spring Kafka**, you can define an `@KafkaListener` in Inventory Service that consumes `OrderPlaced` events asynchronously.

---

### 7.4 CQRS (Command Query Responsibility Segregation) Basics

- **Definition**: Split system into **commands** (writes) and **queries** (reads).
    
- **Motivation**: Reads and writes often have different scaling requirements.
    
- **Benefits**:
    
    - Read models can be denormalized for performance.
        
    - Write model enforces strong consistency.
        
- **Challenges**:
    
    - Complexity increases.
        
    - Requires eventual consistency between read and write models.
        
- **Use Case**: Banking transactions, e-commerce dashboards, systems with very heavy read traffic.
    

👉 **Example**:

- **Write side**: Order Service writes to DB.
    
- **Read side**: Projection Service updates a read-optimized cache or NoSQL store.
    
- **Query**: Users hit the read store, not the transactional DB.
    

---

### 7.5 Saga Pattern (Choreography vs. Orchestration)

Distributed transactions across services are hard. Saga pattern solves this by breaking a long transaction into **local transactions + compensating actions**.

#### Choreography

- **Definition**: Services react to each other’s events.
    
- **Example**:
    
    - Order Service publishes `OrderPlaced`.
        
    - Inventory Service reserves stock → publishes `StockReserved`.
        
    - Payment Service charges → publishes `PaymentSuccessful`.
        
- **Pros**: No central coordinator, fully decoupled.
    
- **Cons**: Harder to trace/debug, spaghetti event chains.
    

#### Orchestration

- **Definition**: A central “orchestrator” service coordinates the saga.
    
- **Example**:
    
    - Order Orchestrator calls Inventory, then Payment, then Notification.
        
- **Pros**: Easier debugging, centralized flow.
    
- **Cons**: Orchestrator may become a bottleneck.
    

👉 **Spring Boot + Kafka Example**:

- Use Kafka topics for event-based choreography.
    
- Or, implement an Orchestrator service using Spring Boot’s orchestration framework + Kafka producers/consumers.
    

---

### 7.6 Strangler Fig Pattern (Migrating Legacy Systems)

- **Definition**: Gradually replace parts of a legacy monolith by routing specific requests to new microservices, until the old system “strangles” away.
    
- **Steps**:
    
    1. Put an API Gateway in front of the legacy app.
        
    2. Route some endpoints (e.g., `/users`) to a new microservice.
        
    3. Gradually migrate feature by feature.
        
    4. Retire the legacy monolith.
        
- **Advantages**:
    
    - Low risk, incremental migration.
        
    - Can run old + new systems in parallel.
        
- **Use Case**: Large enterprises (banks, airlines) modernizing core systems.
    

---

### 7.7 Interview Pitfalls

- Saying _“microservices are always better”_. Instead, say: _“Depends on team size, scaling needs, and domain complexity.”_
    
- Ignoring **observability**. Microservices demand distributed tracing (Jaeger, Zipkin).
    
- Forgetting **data ownership per service**. Shared DB across microservices kills independence.
    
- Not mentioning **transaction handling** in distributed systems.
    

---

✅ **End of Chapter 7 Summary**

- Monolith → simple, fast startup, but scaling pain.
    
- Modular Monolith → good middle ground.
    
- Microservices → powerful, but high operational cost.
    
- Event-driven → async, scalable, but harder to debug.
    
- CQRS → separates reads/writes for performance.
    
- Saga → ensures distributed consistency with compensations.
    
- Strangler Fig → safe migration from legacy systems.
    