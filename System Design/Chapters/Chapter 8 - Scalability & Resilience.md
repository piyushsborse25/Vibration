When we build distributed systems, we quickly realize that **failure is the norm, not the exception**. Servers crash, networks partition, caches expire, and services go down. A system that cannot tolerate failure will collapse under real-world conditions.

This chapter focuses on patterns, tools, and mechanisms that allow systems to **scale to millions of users** while remaining **resilient in the face of failures**.

---

## **8.1 Circuit Breaker Pattern**

A **circuit breaker** is a defensive mechanism that prevents one failing service from dragging down the entire system.

Imagine a payment service that is down. If your order-service keeps calling it, every call will time out, threads will block, and soon your service will crash. Instead, a circuit breaker **cuts the connection temporarily**, letting requests fail fast.

- **Closed state** → Normal operation, requests flow.
    
- **Open state** → The service is unhealthy, calls fail immediately.
    
- **Half-open state** → After a cooldown, system tests if the service has recovered.
    

### Tools in Java:

- **Hystrix (Netflix OSS, now legacy)** – pioneered the concept.
    
- **Resilience4j** – lightweight, modern library widely used in Spring Boot.
    

Example (Spring Boot + Resilience4j):

```java
@CircuitBreaker(name = "paymentService", fallbackMethod = "fallbackPayment")
public PaymentResponse processPayment(PaymentRequest request) {
    return paymentClient.callPaymentService(request);
}

public PaymentResponse fallbackPayment(PaymentRequest request, Throwable ex) {
    return new PaymentResponse("FAILED", "Payment service unavailable");
}
```

👉 **Interview Tip**: Be ready to explain the **state transitions**, why circuit breakers prevent **cascading failures**, and compare it with **retry + exponential backoff**.

---

## **8.2 Service Discovery**

In microservices, we don’t hardcode IPs or hostnames. Instead, services **register themselves** in a registry, and other services **discover them dynamically**.

### Approaches:

1. **Client-side discovery**
    
    - Clients query the registry directly (e.g., Netflix Eureka).
        
    - Load balancing happens at the client.
        
2. **Server-side discovery**
    
    - Clients hit a **load balancer** (e.g., AWS ELB, NGINX), which queries the registry.
        

### Tools:

- **Eureka** – from Netflix, widely used in Spring Boot microservices.
    
- **Consul** – by HashiCorp, provides DNS + health checks.
    
- **Zookeeper** – older, but still used in Kafka and Hadoop ecosystems.
    

👉 **Pitfall**: Forgetting **health checks** → a dead service may remain in registry → leads to blackhole routing.

---

## **8.3 Graceful Shutdown in Spring Boot**

When a pod in Kubernetes or a VM shuts down, requests in progress shouldn’t just be killed. A **graceful shutdown** ensures that ongoing work completes and new traffic is stopped.

Spring Boot (since v2.3) supports graceful shutdown:

```yaml
server:
  shutdown: graceful
spring:
  lifecycle:
    timeout-per-shutdown-phase: 30s
```

Steps in graceful shutdown:

1. Stop accepting new requests.
    
2. Let in-flight requests finish (within a timeout).
    
3. Release resources and close connections.
    

👉 **Interview Scenario**: "What happens if you deploy a new version of order-service during peak traffic?" → Answer should cover **graceful shutdown + rolling updates**.

---

## **8.4 Distributed Locks**

In distributed systems, multiple services may try to modify the same resource simultaneously. To avoid race conditions, we use **distributed locks**.

### Options:

- **Redis Redlock** → lightweight lock with TTL.
    
- **Zookeeper** → hierarchical locking, strong consistency.
    

Redis example (using Redisson in Java):

```java
RLock lock = redissonClient.getLock("order:123");
try {
    if (lock.tryLock(10, 30, TimeUnit.SECONDS)) {
        processOrder(123);
    }
} finally {
    lock.unlock();
}
```

👉 **Pitfall**: Forgetting TTL → lock never released if the process crashes → deadlock. Always set **expiry**.

---

## **8.5 Leader Election Basics**

In distributed clusters, one node is often chosen as the **leader** to coordinate work (e.g., Kafka partition leaders, Zookeeper quorum leader).

### Common Algorithms:

- **Raft** – designed to be understandable; used in etcd, Consul.
    
- **Paxos** – mathematically complex, used in Google Chubby.
    

Interviewers don’t expect you to explain consensus proofs, but you must know:

- **Leader election is needed** for coordination.
    
- **Heartbeat mechanism** → leader sends periodic signals.
    
- **Failover** → if leader dies, a new one is elected.
    

👉 **Pitfall**: Assuming leader election is instant. In reality, there is **downtime** while cluster agrees on the new leader.

---

## **8.6 Common Interview Pitfalls**

- Not handling **partial failures** (one service fails, others hang).
    
- Forgetting **timeouts** → default HTTP client may block forever.
    
- Ignoring **retries + backoff** → retry storms can overload the network.
    
- Assuming **synchronous calls** always scale → async messaging may be better.
    