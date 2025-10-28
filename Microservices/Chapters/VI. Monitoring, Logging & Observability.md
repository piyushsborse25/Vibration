### 55. How would you monitor Microservices?

- Use **application metrics, logs, and traces** to monitor system health.
    
- Integrate tools like **Prometheus** (metrics), **Grafana** (visualization), and **ELK** (logging).
    
- Enable **Spring Boot Actuator** for health checks and metrics.
    

**Example:**  
Monitor CPU, memory, request latency, and active thread count for each service.

**Spring Boot setup:**

```properties
management.endpoints.web.exposure.include=health,metrics,prometheus
```

---

### 56. How do you approach logging and monitoring in a Microservices environment?

- Use **centralized logging** to collect logs from all services.
    
- Each log should include **service name**, **timestamp**, and **trace ID**.
    
- **Monitor key metrics** like request count, latency, and error rate.
    

_Example:_  
Use ELK (Elasticsearch + Logstash + Kibana) for logs and Prometheus + Grafana for performance metrics.

---

### 57. What is the mechanism to monitor different Microservices?

- **Health Checks:** `/actuator/health` endpoint for each service.
    
- **Distributed Tracing:** Track requests using tools like **Zipkin** or **Jaeger**.
    
- **Metrics Exporters:** Services push data to **Prometheus**.
    
- **Log Aggregation:** All logs sent to **Elasticsearch** for analysis.
    

---

### 58. How can you trace one request across multiple services?

- Use **distributed tracing** with a unique **trace ID** propagated through all service calls.
    
- Tools: **Spring Cloud Sleuth** with **Zipkin** or **Jaeger**.
    
- The trace ID is added to headers and logs for tracking.
    

**Example:**  
When a user places an order, the same trace ID follows from `order-service` → `payment-service` → `notification-service`.

---

### 59. How do you trace a request across multiple Microservices?

- Implement **Spring Cloud Sleuth** for automatic trace and span ID propagation.
    
- Use **Zipkin UI** to visualize latency across services.
    

**Example (Maven dependency):**

```xml
<dependency>
  <groupId>org.springframework.cloud</groupId>
  <artifactId>spring-cloud-starter-sleuth</artifactId>
</dependency>
<dependency>
  <groupId>org.springframework.cloud</groupId>
  <artifactId>spring-cloud-starter-zipkin</artifactId>
</dependency>
```

**Result:**  
Each log entry will include `[traceId, spanId]` — enabling end-to-end request tracking.

---

### 60. What is ELK?

**ELK Stack** = **Elasticsearch + Logstash + Kibana**

- **Elasticsearch:** Stores and indexes logs.
    
- **Logstash:** Collects and processes logs from services.
    
- **Kibana:** Visualizes and searches logs in a web UI.
    

_Example:_  
Developers use Kibana dashboards to detect failures or latency spikes across services.

---

### 61. Have you implemented ELK?

Yes. Integrated **ELK Stack** for centralized logging:

1. **Logback** → sends logs to **Logstash**.
    
2. **Logstash** → filters & sends to **Elasticsearch**.
    
3. **Kibana** → displays logs with visualization.
    

**Sample logback-spring.xml:**

```xml
<appender name="LOGSTASH" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
  <destination>localhost:5000</destination>
  <encoder class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder"/>
</appender>
```

---

### 62. How do you perform logging in a distributed Microservices system?

- Use **JSON-based structured logging** (Logback or Log4j2).
    
- Include **traceId** and **spanId** in every log.
    
- Send logs to **Logstash** for centralized storage.
    

_Example Log Output:_

```
{"timestamp":"2025-10-28T12:10","level":"INFO","trace":"a1b2c3","service":"order-service","message":"Order created"}
```

---

### 63. What is chaos engineering and how is it applied?

- **Chaos Engineering** involves intentionally introducing failures to test system resilience.
    
- Tools like **Chaos Monkey** or **Gremlin** simulate outages or latency.
    
- Helps ensure your system can recover gracefully.
    

_Example:_  
Use Chaos Monkey for Spring Boot to randomly stop instances — verifying if load balancer redirects traffic properly.

**Maven Dependency:**

```xml
<dependency>
  <groupId>de.codecentric</groupId>
  <artifactId>chaos-monkey-spring-boot</artifactId>
</dependency>
```
