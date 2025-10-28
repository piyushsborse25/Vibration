### 64. What is the use of Kubernetes?

**Kubernetes (K8s)** is an open-source platform for **automating deployment, scaling, and management** of containerized applications (like Docker containers).

**Key uses:**

- **Container Orchestration:** Automatically schedules and runs containers.
    
- **Scaling:** Increases or decreases replicas based on load.
    
- **Self-Healing:** Restarts crashed containers automatically.
    
- **Load Balancing:** Distributes traffic between multiple service instances.
    
- **Rolling Updates:** Deploy new versions without downtime.
    

**Real Example:**  
Your Spring Boot microservices (`user-service`, `order-service`, `inventory-service`) are deployed in Kubernetes as pods. If `order-service` fails, Kubernetes automatically spins up a new pod.

**Sample Deployment YAML:**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: order-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: order-service
  template:
    metadata:
      labels:
        app: order-service
    spec:
      containers:
        - name: order-service
          image: order-service:latest
          ports:
            - containerPort: 8080
```

---

### 65. How do you design for scalability?

Scalability ensures your system handles increased load efficiently.

**Approaches:**

- **Stateless Services:** No session data in memory; use Redis or DB for state.
    
- **Load Balancing:** Distribute requests evenly (e.g., Nginx, AWS ALB).
    
- **Horizontal Scaling:** Add more service instances during high load.
    
- **Asynchronous Processing:** Use message queues (Kafka, RabbitMQ) to decouple services.
    
- **Caching:** Use Redis or Hazelcast to reduce DB load.
    
- **Database Scaling:** Sharding, read replicas, and optimized indexing.
    

**Real Example:**  
During a flash sale, Kubernetes scales `inventory-service` pods from 3 to 10 automatically to handle spike traffic.

**Spring Boot Configuration (Stateless Example):**

```java
@Bean
public WebSessionIdResolver webSessionIdResolver() {
    return new HeaderWebSessionIdResolver(); // makes service stateless
}
```

---

### 66. What are the best practices for deploying Microservices in a production environment?

1. **Containerize** each service using Docker.
    
2. Use **Kubernetes or ECS** for orchestration.
    
3. Implement **CI/CD pipelines** for automated builds, testing, and deployment (Jenkins, GitHub Actions).
    
4. Use **Blue-Green** or **Canary deployments** for zero-downtime updates.
    
5. Enable **Health Checks** (`/actuator/health`) for auto-restarts on failure.
    
6. Implement **centralized logging** and **monitoring** (ELK, Prometheus, Grafana).
    
7. Use **Config Server / Secrets Manager** for managing sensitive configs.
    
8. Apply **security best practices** — HTTPS, API Gateway authentication, role-based access.
    
9. Ensure **database migrations** are automated (Liquibase/Flyway).
    
10. Regularly perform **load testing** (JMeter, Gatling) to validate performance.
    

**Real Example:**  
When deploying a new `payment-service` version, use **Canary deployment** in Kubernetes — roll out to 10% users first, monitor health, then scale to 100% if stable.