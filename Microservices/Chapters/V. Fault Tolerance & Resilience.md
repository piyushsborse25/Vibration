### 48. How do you handle partial failures in Microservices?

Partial failures occur when one service fails while others continue working.  
**Strategies:**

- Use **Circuit Breaker** (Resilience4j, Hystrix) to stop cascading failures.
    
- Implement **Fallback logic** to serve cached or default data.
    
- Use **Timeouts** to prevent waiting on unresponsive services.
    

**Example:**  
If `payment-service` is down, `order-service` marks the order as _Payment Pending_ instead of failing the request.

```java
@CircuitBreaker(name = "paymentService", fallbackMethod = "paymentFallback")
public String callPaymentService() {
    return restTemplate.getForObject("http://payment-service/pay", String.class);
}
```

---

### 49. How would you handle inter-service communication failure?

**Approaches:**

- **Retries:** Automatically retry failed calls (Resilience4j Retry).
    
- **Fallbacks:** Return alternative response or queue the request.
    
- **Dead Letter Queues (DLQ):** Store undelivered messages for manual retry.
    
- **Timeouts:** Configure network timeouts to avoid blocking threads.
    

**Example:**  
When sending a Kafka event fails, push it to a DLQ for later processing.

---

### 50. How do you handle Microservices failure?

- Use **Health checks** (`/actuator/health`) to monitor status.
    
- **Restart policies** in Kubernetes (auto-restart failed pods).
    
- **Service discovery** reroutes traffic from unhealthy instances.
    
- **Graceful degradation** — continue essential functions even when parts fail.
    

_Example:_  
If `notification-service` fails, system continues order processing but logs pending notifications.

---

### 51. How do you handle retries and failed message deliveries?

- Use **Retry pattern** for transient issues.
    
- Implement **Exponential backoff** (wait longer between retries).
    
- Store **failed events in DLQ** for later reprocessing.
    

**Spring Boot (Kafka Retry Example):**

```java
@RetryableTopic(attempts = "3", backoff = @Backoff(delay = 2000))
@KafkaListener(topics = "orders")
public void consume(String message) {
    // process message
}
```

---

### 52. How do you prevent cascading effects of a failure in Microservices?

- Use **Circuit Breaker** – isolates failing services.
    
- **Bulkhead Pattern** – isolates resources (thread pools) per service.
    
- **Timeouts and Retries** – limit impact of slow services.
    
- **Graceful Degradation** – fallback behavior to maintain user experience.
    

_Example:_  
If `inventory-service` fails, `order-service` responds with “Stock unavailable” instead of crashing.

---

### 53. How do you ensure resilience in inter-service communication?

- **Resilience4j** for retries, circuit breakers, bulkheads, and rate limiting.
    
- **Load Balancing** with Ribbon/Eureka to distribute requests.
    
- **Message queues (Kafka/RabbitMQ)** for async processing to decouple services.
    
- **Monitoring & Alerts** to detect early failures.
    

**Example (application.yml):**

```yaml
resilience4j.circuitbreaker.instances.paymentService:
  failure-rate-threshold: 50
  wait-duration-in-open-state: 10s
```

---

### 54. What is operational complexity in Microservices and how do you manage it?

Operational complexity arises due to **many small services** running, communicating, and scaling independently.  
**Ways to manage:**

- **Centralized logging** (ELK, Fluentd).
    
- **Monitoring** (Prometheus, Grafana).
    
- **Distributed tracing** (Zipkin, Jaeger).
    
- **Automation** with CI/CD pipelines and Infrastructure as Code (Terraform, Helm).
    

_Example:_  
When you have 30+ microservices, managing logs manually becomes difficult — ELK stack aggregates and visualizes all service logs centrally.