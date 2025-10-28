### 36. How would you implement data consistency across Microservices?

- Use **event-driven architecture** and **asynchronous communication** (Kafka, RabbitMQ).
    
- Each service updates its local DB and emits an **event** to notify others.
    
- Use **Saga pattern** for distributed transactions.
    

_Example:_  
In an order flow, `order-service` creates an order → publishes `OrderCreatedEvent` → `payment-service` listens and processes payment.

---

### 37. How do you ensure data consistency across services with separate databases?

- Use **event sourcing** or **transactional outbox** pattern.
    
- Each service maintains its own DB and shares updates via **events** to avoid direct DB coupling.
    
- Use **idempotent consumers** to handle duplicate events.
    

_Example:_  
`inventory-service` updates stock based on order events from Kafka instead of sharing DB with `order-service`.

---

### 38. What is database sharding and why is it used in Microservices?

- **Sharding** splits large databases into smaller chunks (shards) to improve performance and scalability.
    
- Each shard holds a subset of data (e.g., by region or customer ID).
    

_Example:_  
Users from Asia are stored in `user_db_asia`, users from Europe in `user_db_eu`.  
This reduces query load and improves latency.

---

### 39. What is table partitioning?

- Dividing a single large table into smaller **logical parts (partitions)** while keeping them in the same database.
    
- Helps in improving **query speed**, **maintenance**, and **data management**.
    

_Example:_  
Partitioning an `orders` table by **order_date** to optimize date-based queries.

---

### 40. How is database connection pooling achieved?

- Connection pooling allows reuse of DB connections instead of creating a new one each time.
    
- Spring Boot uses **HikariCP** as the default connection pool.
    

**Example (application.properties):**

```properties
spring.datasource.hikari.maximum-pool-size=10
spring.datasource.hikari.minimum-idle=5
```

---

### 41. Who manages the database connection pool?

- Managed by the **connection pooling library** (e.g., HikariCP, C3P0).
    
- Spring Boot auto-configures HikariCP as the connection pool manager.
    

---

### 42. What is JNDI?

- **Java Naming and Directory Interface** — a Java API for accessing resources like databases or queues by name.
    
- Often used in **application servers (Tomcat, WebLogic)** for centralized DB connection management.
    

_Example:_  
JNDI lookup for a DataSource configured in Tomcat context.xml.

---

### 43. How did you implement cache in MySQL?

- Used **Hibernate second-level cache** or **Redis** as external cache.
    
- Frequently accessed queries (like `getUserById`) are cached to reduce DB hits.
    

**Spring Boot Example:**

```java
@Cacheable("users")
public User getUserById(Long id) {
    return userRepository.findById(id).orElseThrow();
}
```

---

### 44. What is Redis? Have you used it?

- **Redis** is an **in-memory data store** used as cache, message broker, or session store.
    
- Reduces latency for frequently accessed data.  
    _Example:_ Caching user sessions or product lists in Redis for faster retrieval.
    

**Spring Boot config:**

```java
spring.cache.type=redis
spring.data.redis.host=localhost
spring.data.redis.port=6379
```

---

### 45. Can we implement connection pooling in Redis?

Yes. Redis clients like **Lettuce** and **Jedis** provide built-in connection pooling to handle multiple concurrent requests efficiently.

**Example:**

```java
LettucePoolingClientConfiguration.builder()
    .poolConfig(new GenericObjectPoolConfig<>())
    .build();
```

---

### 46. What are database communication ways?

1. **Direct DB communication** – JDBC, JPA/Hibernate.
    
2. **Message-based communication** – via Kafka or RabbitMQ (async updates).
    
3. **REST API-based communication** – services call each other instead of sharing DBs directly.
    

---

### 47. How do you handle data consistency?

- **At transaction level** – Use ACID principles within a service.
    
- **Across services** – Use eventual consistency via events or sagas.
    
- **Validation** – Implement data versioning or optimistic locking to avoid conflicts.
    

_Example:_  
When updating product price, use a version field to ensure no concurrent update overwrites data.