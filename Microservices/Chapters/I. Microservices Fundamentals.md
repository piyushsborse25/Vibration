### 1. What are Microservices?

**Explanation:**  
Microservices are an architectural style where an application is divided into small, independent services that each handle a specific business function.  
Each microservice runs in its own process and communicates with others through lightweight mechanisms such as REST APIs or messaging systems like Kafka or RabbitMQ.

**Real-world Example:**  
In an e-commerce system, different services can exist for users, orders, payments, and inventory — all working independently but collaborating through APIs.

**Spring Boot Example:**

```java
@SpringBootApplication
public class OrderServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(OrderServiceApplication.class, args);
    }
}
```

---

### 2. How do Microservices differ from Monolithic Architecture?

|Aspect|Monolithic|Microservices|
|---|---|---|
|Structure|Single deployable unit|Collection of small services|
|Deployment|Redeploy entire app|Deploy only affected service|
|Database|One shared DB|Independent DB per service|
|Scaling|Scale whole app|Scale only required service|
|Fault Isolation|Whole app can fail|One service can fail independently|

**Example:**  
In a monolithic system, a change in the payment module requires full redeployment. In microservices, only the Payment Service is redeployed.

---

### 3. What are the key features of Microservices?

- Independent deployment
    
- Loose coupling and high cohesion
    
- Decentralized data management
    
- Lightweight communication (REST, gRPC, messaging)
    
- Fault isolation and resilience
    
- Technology flexibility
    

**Example:**  
`ProductService` uses MongoDB while `OrderService` uses MySQL — both can run independently.

---

### 4. Name the main components of Microservices.

1. API Gateway
    
2. Service Registry / Discovery
    
3. Config Server
    
4. Load Balancer
    
5. Message Broker (Kafka, RabbitMQ)
    
6. Monitoring and Tracing Tools (Zipkin, ELK Stack)
    

---

### 5. Explain the role of an API Gateway in Microservices.

**Explanation:**  
An API Gateway serves as a single entry point for all client requests.  
It routes requests to the appropriate microservice, handles cross-cutting concerns such as authentication, rate limiting, and logging, and simplifies communication between clients and services.

**Real-world Example:**  
A food delivery app has multiple services like `OrderService`, `RestaurantService`, and `DeliveryService`. The API Gateway decides where to send each incoming request.

**Spring Boot Example:**

```java
@Configuration
public class ApiGatewayConfig {

    @Bean
    public RouteLocator routes(RouteLocatorBuilder builder) {
        return builder.routes()
            .route("order_route", r -> r.path("/orders/**")
                .uri("lb://ORDER-SERVICE"))
            .route("payment_route", r -> r.path("/payments/**")
                .uri("lb://PAYMENT-SERVICE"))
            .build();
    }
}
```

---

### 6. What is Service Discovery in Microservices?

**Explanation:**  
Service Discovery helps microservices find each other dynamically.  
Instead of hardcoding URLs, each service registers itself with a **Service Registry** like **Eureka**. Other services query the registry to locate them at runtime.

**Real-world Example:**  
Like a phone directory that keeps track of all service locations, so `OrderService` can locate `InventoryService` without knowing its exact address.

**Spring Boot Example:**

```java
@EnableEurekaServer
@SpringBootApplication
public class DiscoveryServerApplication { }
```

Each client registers itself:

```java
@EnableEurekaClient
public class OrderServiceApplication { }
```

---

### 7. What is the use of an API Gateway?

**Explanation:**  
The API Gateway handles:

- Routing and load balancing
    
- Authentication and authorization
    
- Centralized logging and monitoring
    
- Rate limiting
    
- Response aggregation
    

**Example:**  
The client calls `/api/orders`, and the API Gateway forwards it to the actual `OrderService` after verifying the JWT token.

---

### 8. What are popular implementations of API Gateway?

- Spring Cloud Gateway
    
- Netflix Zuul
    
- Kong API Gateway
    
- NGINX API Gateway
    
- AWS API Gateway
    

---

### 9. How is authentication managed through API Gateway?

**Explanation:**  
API Gateway validates authentication tokens (like JWT or OAuth2) before routing requests.  
If the token is valid, the request proceeds; otherwise, it is blocked.

**Real-world Example:**  
In a banking app, before accessing `/accounts/**`, the API Gateway checks the JWT token’s validity.

**Spring Boot Example:**

```java
@Bean
public SecurityWebFilterChain securityFilter(ServerHttpSecurity http) {
    return http
        .authorizeExchange()
        .pathMatchers("/public/**").permitAll()
        .anyExchange().authenticated()
        .and()
        .oauth2ResourceServer().jwt()
        .and().build();
}
```

---

### 10. What is a container and why is it used in Microservices?

**Explanation:**  
A container (like Docker) packages an application and all its dependencies, ensuring it runs consistently across different environments.  
Each microservice can run in its own isolated container.

**Real-world Example:**  
A Docker container is like a shipping container that holds everything needed for your app to run — no matter where it’s deployed.

**Docker Example:**

```dockerfile
FROM openjdk:17
COPY target/order-service.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

### 11. Explain the importance of containerization in Microservices.

- Provides environment consistency across dev, test, and prod
    
- Simplifies deployment and scaling (especially with Kubernetes)
    
- Reduces resource conflicts between services
    
- Speeds up CI/CD pipelines
    

**Example:**  
If `OrderService` and `InventoryService` run in separate containers, scaling one service doesn’t affect the other.

---

### 12. What are the main challenges in implementing Microservices?

1. Maintaining data consistency across services
    
2. Complex inter-service communication
    
3. Distributed debugging and tracing
    
4. Security management
    
5. Versioning and backward compatibility
    
6. Complex CI/CD setup
    

**Example:**  
When `OrderService` saves an order, it must also notify `InventoryService` and `PaymentService`, ensuring eventual consistency.

---

### 13. What is an anti-pattern in Microservices?

**Explanation:**  
An anti-pattern is a poor design practice that violates microservice principles and causes long-term problems.

**Common Anti-Patterns:**

- Shared database between services
    
- Too many tiny services (“nano-services”)
    
- Synchronous dependency chains
    
- Centralized data models
    

**Example:**  
If all microservices share a single `user_db`, any schema change can break multiple services.

---

### 14. Scenario-based question on Monolithic Architecture

**Scenario:**  
A company runs a monolithic e-commerce application. When developers modify the payment module, they must rebuild and redeploy the entire application. This increases downtime and deployment risk.

**Problems:**

- Tight coupling between modules
    
- Difficult to scale specific features
    
- Slower development cycle
    

**Microservice Solution:**  
Split the system into smaller services:

- `OrderService`
    
- `PaymentService`
    
- `ProductService`  
    Now, each service can be deployed or updated independently, reducing downtime and improving scalability.