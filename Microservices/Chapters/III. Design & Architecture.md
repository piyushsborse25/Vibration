### 23. What design patterns have you used while implementing Microservices?

Common patterns:

- **API Gateway Pattern** – Centralized entry point for all requests.  
    _Example:_ Using Spring Cloud Gateway to route requests to `user-service` and `order-service`.
    
- **Circuit Breaker Pattern** – To handle service failures gracefully using **Resilience4j**.
    
- **Saga Pattern** – To manage distributed transactions across services (e.g., order → payment → inventory).
    
- **Event Sourcing** – Captures all changes as events in Kafka.
    
- **Repository Pattern** – Separates database logic from service layer.
    

---

### 24. What is the CQRS pattern in Microservices? What problem does it solve?

**CQRS (Command Query Responsibility Segregation)** separates read and write operations into different models.

- **Problem solved:** Improves scalability and performance by separating query and update loads.  
    _Example:_
    
- Command service handles **create/update order**,
    
- Query service handles **fetch order details** from a read-optimized database.
    

---

### 25. What are some common Microservices design principles?

- **Single Responsibility** – Each service should do one thing well.
    
- **Loose Coupling & High Cohesion** – Minimize dependencies.
    
- **API First** – Define clear contracts via OpenAPI/Swagger.
    
- **Decentralized Data** – Each service owns its data.
    
- **Observability** – Logs, metrics, tracing (ELK, Prometheus, Zipkin).
    

---

### 26. What is event-driven architecture in Microservices?

Architecture where services communicate via **events** using message brokers (Kafka, RabbitMQ).  
_Example:_  
When `order-service` creates an order, it publishes an `OrderCreatedEvent`. `inventory-service` listens and reduces stock.

**Spring Boot Example:**

```java
@KafkaListener(topics = "orders", groupId = "inventory-service")
public void consumeOrder(String message) {
    // Update inventory based on order
}
```

---

### 27. What is the Sidecar pattern?

A helper service deployed alongside a main service to handle cross-cutting concerns like logging, monitoring, or configuration.  
_Example:_  
Running **Envoy proxy** as a sidecar to each microservice pod in Kubernetes for service mesh traffic management.

---

### 28. What are the DDD (Domain-Driven Design) principles?

- **Bounded Context** – Each domain (e.g., user, order) has clear boundaries.
    
- **Entities & Value Objects** – Represent business models.
    
- **Aggregates** – Group of related entities treated as one.
    
- **Ubiquitous Language** – Common vocabulary between devs and business.  
    _Example:_  
    `Order` aggregate contains `OrderItem` entities; `OrderService` acts as aggregate root.
    

---

### 29. How do you handle backward compatibility in Microservices?

- Use **versioned APIs** (`/api/v1/users`, `/api/v2/users`).
    
- Keep old endpoints running until all clients migrate.
    
- Maintain **contract testing** using tools like **Spring Cloud Contract**.
    

---

### 30. How do you prevent cascading effects of a failure in Microservices?

- Use **Circuit Breaker** (Resilience4j, Hystrix).
    
- Implement **Timeouts** and **Retries**.
    
- Apply **Bulkhead Pattern** to isolate failures.  
    _Example:_  
    If payment service is down, the order service shows “Payment Pending” instead of crashing.
    

---

### 31. How do Microservices communicate with each other?

- **Synchronous** – REST, gRPC for real-time calls.
    
- **Asynchronous** – Message brokers like Kafka for event-driven workflows.  
    _Example:_  
    `order-service` calls `payment-service` via REST for payment confirmation.
    

---

### 32. How do you handle inter-service communication failure?

- Use **Retry & Fallback** mechanisms (Resilience4j).
    
- Implement **Dead Letter Queues (DLQ)** for failed messages.
    
- Monitor failed calls through **distributed tracing**.
    

**Spring Boot Example:**

```java
@Retry(name = "paymentService", fallbackMethod = "fallbackPayment")
public String callPaymentService() {
    return restTemplate.getForObject("http://payment-service/pay", String.class);
}
```

---

### 33. What is the purpose of a retry pattern?

To automatically **re-attempt failed operations** due to transient issues (like network delays).  
_Example:_  
Retry payment call 3 times before marking order as failed.

---

### 34. What is canary deployment?

Deploying a **new version of a service** to a small subset of users before full rollout.  
_Example:_  
Deploy v2 of `user-service` to 10% of users, monitor performance, then scale to 100%.

---

### 35. What are the best practices for deploying Microservices in production?

- **Use containers (Docker, K8s)** for scalability.
    
- **Centralized logging** (ELK, Fluentd).
    
- **CI/CD pipelines** (Jenkins, GitHub Actions).
    
- **Health checks** for readiness/liveness.
    
- **Monitor metrics** (Prometheus + Grafana).
    
- **Implement blue-green or canary deployments** for zero downtime.
    