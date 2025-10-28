### 75. How was the authenticator integrated in your project?

In our project, authentication was implemented using **JWT (JSON Web Tokens)** integrated via **Spring Security**.

- The **Authenticator Service** validated credentials and issued a token.
    
- Each subsequent request carried this token in the **Authorization header** (`Bearer <token>`).
    
- Downstream services validated the token before processing the request.
    

**Example:**

```java
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6...
```

- We used a **custom filter** to decode and verify JWT before allowing access.
    
- Tokens were signed with a **shared secret key** known to all Microservices.
    
- The approach supported **stateless authentication**, improving scalability.
    

---

### 76. How would you handle token expiry scenarios?

Token expiry ensures security but must be handled gracefully.  
**Approach:**

1. **Short-lived access tokens** with **longer refresh tokens**.
    
2. When a token expires, clients call the **refresh endpoint** to get a new access token.
    
3. If both tokens expire, users must reauthenticate.
    

**Example Flow:**

- Access token (15 min) → expires → client uses refresh token (7 days) → new access token issued.
    
- In **Spring Security**, refresh tokens were managed through a dedicated endpoint like `/auth/refresh`.
    

**Best Practice:**  
Include expiry (`exp`) in the JWT payload and check it before API access.

---

### 77. How would you handle inter-service communication failure?

When one Microservice fails while another depends on it:

1. **Circuit Breaker Pattern:**
    
    - Implemented via **Resilience4j** to detect repeated failures and stop sending requests temporarily.
        
2. **Fallback Mechanism:**
    
    - Return cached or default response if dependent service is unavailable.
        
3. **Retry Mechanism:**
    
    - Retry failed calls with exponential backoff using **Spring Retry**.
        
4. **DLQ (Dead Letter Queue):**
    
    - For async systems like Kafka, failed events are moved to DLQ for later reprocessing.
        
5. **Centralized Logging:**
    
    - Helps track which service failed and at what stage.
        

---

### 78. How would you trace a failed request across multiple services?

To trace requests across services:

1. Use **Distributed Tracing** tools like **Zipkin**, **Jaeger**, or **OpenTelemetry**.
    
2. Generate a **unique trace ID** per request (via Sleuth in Spring Cloud).
    
3. Propagate the trace ID in HTTP headers like:
    
    ```
    X-B3-TraceId: 8a12f07b9...
    ```
    
4. Each service logs this ID, enabling tracking of the full call chain.
    

**Example:**  
If a payment failure occurs, tracing helps you identify which service (Order → Inventory → Payment) caused the issue and how long each took.

---

### 79. How would you manage data consistency across services during order processing?

In distributed systems, achieving **strong consistency** is difficult, so we use **eventual consistency**:

1. **Saga Pattern:**
    
    - Each service performs its part and publishes an event.
        
    - If one step fails, compensating transactions roll back prior actions.
        
2. **Event-Driven Architecture:**
    
    - Use **Kafka topics** like `order-created`, `payment-success`, `inventory-reserved`.
        
    - Consumers update their databases asynchronously.
        
3. **Idempotent Operations:**
    
    - Ensure retrying events doesn’t create duplicate records.
        

**Example Flow:**

- Order placed → event emitted → Inventory checks stock → Payment charged → Confirmation sent.  
    If Payment fails → compensating event triggers Inventory rollback.
    

---

### 80. Explain how you’d debug a distributed failure impacting multiple Microservices.

Debugging distributed failures requires a structured approach:

1. **Check Centralized Logs:**
    
    - Use ELK or EFK to search by trace ID or user ID.
        
2. **Use Distributed Tracing:**
    
    - Tools like Jaeger visualize the request path and show latency/failure points.
        
3. **Correlate Metrics:**
    
    - Check **Prometheus + Grafana** dashboards for spikes in errors or latency.
        
4. **Inspect Message Queues:**
    
    - Check Kafka or RabbitMQ for unprocessed or failed messages.
        
5. **Reproduce Locally:**
    
    - Use Postman or local Docker setup to replay the failing scenario.
        
6. **Root Cause Analysis (RCA):**
    
    - Identify the service or dependency that triggered the cascade.
        

**Example:**  
If “Order Confirmation” is delayed — logs show `OrderService` succeeded, but `NotificationService` queue backlog caused the delay → fixed by scaling consumer instances.