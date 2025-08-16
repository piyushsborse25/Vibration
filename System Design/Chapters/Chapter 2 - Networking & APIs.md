Networking and APIs form the backbone of modern distributed systems. A system design interview almost always includes aspects of service communication, external client interaction, load balancing, or message exchange. A strong foundation in networking and API design ensures that you can reason about **performance, scalability, and reliability trade-offs** when building large-scale systems.

---

## **2.1 REST vs gRPC vs WebSockets**

### **REST (Representational State Transfer)**

- **Principle**: REST is an architectural style, not a protocol. It uses standard HTTP verbs (`GET`, `POST`, `PUT`, `DELETE`) to represent CRUD operations.
    
- **Serialization**: Commonly JSON, but XML or other formats are also possible.
    
- **Characteristics**:
    
    - Stateless: Each request carries all required context.
        
    - Cacheable: HTTP caching can improve performance.
        
    - Human-readable (easy debugging via browser/postman).
        
- **When to Use**:
    
    - Public-facing APIs (e.g., payment gateways, social media APIs).
        
    - When simplicity, readability, and interoperability are important.
        
- **Limitations**:
    
    - Higher overhead due to verbose JSON payloads.
        
    - No native support for streaming or bi-directional communication.
        
- **Interview Insight**: REST is often the default answer for API design unless you need **low latency** or **real-time communication**.
    

---

### **gRPC (Google Remote Procedure Call)**

- **Principle**: Based on HTTP/2, uses Protobuf for compact, strongly-typed binary serialization.
    
- **Characteristics**:
    
    - High performance (smaller payloads, faster serialization).
        
    - Bi-directional streaming supported.
        
    - Contract-first API (using `.proto` files).
        
- **When to Use**:
    
    - Microservices communication within a system (low latency, high throughput).
        
    - Strongly-typed environments (Java, Go, C++) where schema evolution matters.
        
- **Limitations**:
    
    - Harder for browsers/public clients to consume directly.
        
    - Debugging requires additional tools (not as simple as JSON).
        
- **Interview Insight**: Use gRPC for **internal microservice communication** when efficiency and type safety are critical.
    

---

### **WebSockets**

- **Principle**: Provides a persistent, full-duplex connection between client and server.
    
- **Characteristics**:
    
    - Real-time bidirectional communication.
        
    - Lower overhead compared to repeated REST polling.
        
    - Often used with messaging formats like JSON, Protobuf.
        
- **When to Use**:
    
    - Chat applications, multiplayer games, live dashboards.
        
    - Cases where **low-latency push notifications** are essential.
        
- **Limitations**:
    
    - Stateful connections (harder to scale horizontally).
        
    - Requires careful management of connections across distributed systems.
        
- **Interview Insight**: Mention WebSockets when asked about **real-time features** like notifications or collaborative editing.
    

---

### **Comparison**

- REST → Simplicity, human-friendly, universal adoption.
    
- gRPC → Efficiency, internal microservice RPC calls, strong contracts.
    
- WebSockets → Real-time, bidirectional, event-driven communication.
    

---

## **2.2 API Gateway**

An **API Gateway** acts as a single entry point for clients, routing traffic to underlying services. It abstracts complexity and enforces cross-cutting concerns.

- **Responsibilities**:
    
    - **Routing**: Maps external API endpoints to internal microservices.
        
    - **Authentication & Authorization**: Validates tokens (OAuth2, JWT).
        
    - **Rate limiting**: Protects backend from abuse.
        
    - **Logging & Monitoring**: Centralized request/response tracking.
        
    - **Transformation**: Convert external JSON schema to internal Protobuf, etc.
        
- **Examples**: Spring Cloud Gateway, Kong, NGINX, AWS API Gateway.
    
- **Pitfall**: API Gateway can become a **bottleneck** if not scaled properly.
    

**Interview Angle**:  
If asked to design a large-scale API system (e.g., e-commerce), mention **API Gateway for routing, security, and observability**.

---

## **2.3 Rate Limiting & Throttling**

### **Rate Limiting**

- Controls how many requests a client can make in a given time.
    
- Implementations:
    
    - **Token Bucket**: Tokens accumulate at fixed rate; each request consumes one.
        
    - **Leaky Bucket**: Requests processed at a fixed rate; excess requests dropped.
        
    - **Fixed Window**: Allow `N` requests per time window.
        
    - **Sliding Window**: More accurate version of fixed window.
        
- Example: 100 requests per minute per user.
    

### **Throttling**

- Similar to rate limiting, but instead of rejecting requests, it **slows them down**.
    
- Used when fairness is more important than outright rejection.
    

**Interview Angle**:  
Discuss how rate limiting prevents **DDoS attacks, API abuse, and retry storms**.

---

## **2.4 Load Balancing**

Load balancers distribute traffic across multiple servers to ensure **availability, performance, and fault tolerance**.

### **Types**:

1. **DNS Load Balancing**: Multiple IPs for one domain; client chooses randomly.
    
    - Pitfall: DNS caching delays failover.
        
2. **Layer 4 (Transport level)**: Operates on TCP/UDP, forwards packets without looking at content.
    
    - Example: AWS NLB, HAProxy (TCP mode).
        
    - Use case: High performance, simple load balancing.
        
3. **Layer 7 (Application level)**: Understands HTTP/HTTPS, routes based on headers, paths, cookies.
    
    - Example: NGINX, AWS ALB.
        
    - Use case: API routing, content-aware distribution.
        
4. **Reverse Proxy**: Sits between client and backend, adds caching, SSL termination, compression.
    

**Interview Angle**:  
If asked about **high traffic system scaling**, always mention **load balancers (L4 + L7)** and why you'd choose one over another.

---

## **2.5 Pitfalls in Networking & APIs**

1. **Retry Storms**: If all clients retry failed requests simultaneously, it can overwhelm the backend.
    
    - Solution: **Exponential backoff with jitter**.
        
2. **API Versioning Ignored**: Without versioning, breaking changes affect all consumers.
    
    - Solution: `/v1/orders`, `/v2/orders`.
        
3. **Overfetching & Underfetching**: REST sometimes forces extra/unnecessary data retrieval.
    
    - Solution: GraphQL or custom endpoints.
        
4. **Stateful Connections**: WebSockets require sticky sessions if scaled horizontally.
    
    - Solution: Use distributed session stores.
        

---

## **Interview Questions to Expect**

1. How would you design an API for a **ride-hailing app**? REST or gRPC? Why?
    
2. If you have **millions of users** hitting your system, how would you enforce **rate limiting**?
    
3. Difference between **Layer 4 vs Layer 7 load balancer** in a real-world system?
    
4. How to prevent a **retry storm** in an e-commerce checkout service?
    
5. Explain how an **API Gateway** fits into a microservices-based system.
    
