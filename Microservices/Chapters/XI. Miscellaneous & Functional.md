### 81. What are lambda functions?

**Lambda functions** (or **lambda expressions**) in Java are **anonymous functions** — methods without a name — used to simplify code, especially when working with functional interfaces (interfaces with a single abstract method).

They make the code **concise**, **readable**, and **functional-style**.

**Syntax:**

```java
(parameter) -> expression
```

**Example (Real-World):**  
Suppose you want to filter active users in a list.

```java
List<User> activeUsers = users.stream()
    .filter(user -> user.isActive())  // lambda used here
    .collect(Collectors.toList());
```

**Without lambda:**

```java
List<User> activeUsers = new ArrayList<>();
for(User user : users) {
    if(user.isActive()) {
        activeUsers.add(user);
    }
}
```

**Real-World Use Case:**  
In a Spring Boot application, lambda expressions are often used in **Streams**, **event listeners**, and **functional routes** (e.g., reactive programming with WebFlux).

---

### 82. What is an anti-pattern in Microservices?

An **anti-pattern** is a **common but bad practice** that leads to performance, scalability, or maintenance issues in a Microservices system.

**Common Microservices Anti-Patterns:**

1. **Distributed Monolith:**
    
    - Services are split but tightly coupled, deploying together.
        
    - Example: Multiple services share the same database schema or must deploy in sync.
        
2. **Shared Database per Multiple Services:**
    
    - Violates data independence and domain isolation.
        
    - Each Microservice should ideally manage its **own database**.
        
3. **Chatty Communication:**
    
    - Excessive synchronous calls between services causing latency.
        
    - Solution: Use **asynchronous messaging (Kafka/RabbitMQ)**.
        
4. **No Centralized Logging/Monitoring:**
    
    - Hard to debug distributed issues.
        
5. **Overengineering with Too Many Services:**
    
    - Breaking down services too much increases complexity and deployment overhead.
        

**Real-World Example:**  
In an e-commerce system, if `OrderService`, `InventoryService`, and `PaymentService` all share one big `ecommerce_db`, updating one schema could break others.  
→ This is a **Shared Database Anti-Pattern**.

**Correct Approach:**  
Each service should own its **bounded context** — `order_db`, `inventory_db`, etc. — communicating via APIs or events.