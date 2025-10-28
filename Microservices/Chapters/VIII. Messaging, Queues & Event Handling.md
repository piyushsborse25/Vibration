### 67. What is Kafka?

**Apache Kafka** is a **distributed event-streaming platform** used for building **real-time data pipelines** and **event-driven architectures**.

**Key features:**

- High throughput and fault tolerance.
    
- Decouples producers and consumers.
    
- Stores messages in topics (partitioned logs).
    

**Real Example:**  
When a user places an order —

- `order-service` publishes an event to the `orders` topic.
    
- `inventory-service` and `notification-service` consume that event asynchronously.
    

**Spring Boot Kafka Example:**

```java
@KafkaListener(topics = "orders", groupId = "inventory-service")
public void consumeOrder(String message) {
    // Update inventory when a new order is created
}
```

---

### 68. What is RabbitMQ?

**RabbitMQ** is a **message broker** that implements the **AMQP protocol**.  
It supports **message queues, routing, and acknowledgments**.

**Key features:**

- Suitable for **reliable message delivery**.
    
- Supports **queue-based** and **pub/sub** models.
    
- Built-in **dead-letter queues (DLQ)** and **message acknowledgment**.
    

**Real Example:**  
`email-service` consumes messages from a queue `email_notifications` and sends confirmation emails asynchronously after an order is placed.

---

### 69. What is a dead-letter queue (DLQ)?

A **DLQ** is a special queue that stores **messages that could not be processed successfully** after several attempts.

**Use case:**  
If a consumer keeps failing to process a message (e.g., invalid data), the message is sent to DLQ for later inspection.

**Spring Boot RabbitMQ Example:**

```java
@Bean
public Queue ordersDlq() {
    return QueueBuilder.durable("orders.dlq").build();
}
```

**Real Example:**  
When `inventory-service` can’t process an `OrderCreatedEvent` after 3 retries, the message is sent to `orders.dlq` for manual analysis.

---

### 70. What are lazy queues?

**Lazy queues** in RabbitMQ are queues where messages are **stored on disk** instead of memory until consumed.  
This reduces memory usage and improves performance under heavy load.

**Real Example:**  
For large batch notifications or logs, lazy queues store messages on disk — ensuring system stability even with millions of pending messages.

---

### 71. What is the difference between lazy queues and normal queues?

|Feature|Normal Queue|Lazy Queue|
|---|---|---|
|Message Storage|In-memory|On disk|
|Speed|Faster but high memory usage|Slightly slower, memory efficient|
|Use Case|Low latency, high-speed apps|High-volume, memory-bound workloads|

**Example:**

- Normal Queue → Real-time payments or order confirmations.
    
- Lazy Queue → Logging, email notifications, or delayed jobs.
    

---

### 72. How do you handle retries and failed message deliveries?

**Approaches:**

- **Automatic Retries:** Configure retry count and delay in Kafka/RabbitMQ.
    
- **DLQ (Dead-Letter Queue):** Move messages that exceed retry limit.
    
- **Exponential Backoff:** Increase delay between retries gradually.
    
- **Idempotent Consumers:** Prevent duplicate processing.
    
- **Monitoring:** Use Prometheus or ELK to track message failures.
    

**Spring Boot Kafka Retry Example:**

```java
@RetryableTopic(attempts = "3", backoff = @Backoff(delay = 2000))
@KafkaListener(topics = "orders")
public void consume(String message) {
    // Retry 3 times before sending to DLQ
}
```

**Real Example:**  
If `payment-service` temporarily fails to process a message, Kafka retries 3 times before moving it to `payments.DLQ`.