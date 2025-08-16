## 1.1 Introduction

Every system design interview — whether you are asked to build a URL shortener, an e-commerce platform, or a notification service — begins with fundamentals. These fundamentals are not about picking a specific database or deciding whether Kafka or RabbitMQ is better; instead, they are about how you think about a system in the first place.

Interviewers expect you to demonstrate structured thinking: first clarifying what the system needs to do, then discussing what scale it must operate at, and finally considering the qualities that make the system reliable, secure, and maintainable.

In this chapter, we will cover the foundation stones of system design:

- The difference between **High-Level Design (HLD)** and **Low-Level Design (LLD)**.
    
- Understanding **Functional** and **Non-functional Requirements**.
    
- The principles of **Scalability**, including vertical and horizontal scaling.
    
- The trade-off between **Latency** and **Throughput**.
    
- How to perform quick **Load Estimations** to validate your design choices.
    
- The role of **SLAs, SLOs, and SLIs** in defining service reliability.
    

By the end of this chapter, you should not only understand the concepts but also know how to articulate them in an interview in a way that convinces the interviewer that you can think like an architect, not just a coder.

---

## 1.2 High-Level Design vs Low-Level Design

### High-Level Design (HLD)

High-Level Design is the **architectural overview** of a system. At this stage, we are not concerned with the exact table schema or class names but rather with how the major components fit together. Think of HLD as a map of a city: it shows where the residential areas, commercial zones, highways, and power stations are, but it does not tell you the floor plan of each house.

When you are asked to design an e-commerce platform in an interview, the HLD should capture components such as:

- A **frontend application** (web or mobile).
    
- A **backend API layer** that serves user requests.
    
- A **database** that persists data such as orders, users, and payments.
    
- A **cache** to speed up frequent reads.
    
- A **message broker** (like Kafka) to enable asynchronous processing of events such as sending notifications.
    
- A **load balancer** to distribute traffic across multiple servers.
    

The important thing in HLD is to show you understand **separation of concerns**. For example, an `OrderService` should handle order creation and persistence, while a `NotificationService` should only deal with sending emails or SMS updates. If you start mixing these responsibilities, the system becomes harder to scale and maintain.

In an interview, presenting an HLD demonstrates that you can structure systems at a macro level. Interviewers usually spend the first 10–15 minutes here, probing whether you can identify the right components and how they interact.

---

### Low-Level Design (LLD)

Low-Level Design is the **detailed blueprint** of how each component is implemented. If HLD is the city map, LLD is the architectural drawing of a specific building: it shows the layout of each room, the wiring, the plumbing, and the precise measurements.

In system design, LLD might include:

- **API definitions**: What endpoints exist, what are their request/response structures, and what HTTP methods are used.
    
- **Database schema**: What tables exist, what are the primary and foreign keys, what indexes are created, and how normalization or denormalization is handled.
    
- **Class diagrams and methods** if the interviewer wants you to go closer to code.
    
- **Sequence diagrams** showing step-by-step flows, such as how an order is created, validated, stored, and acknowledged.
    

For example, in a URL shortener system, the LLD might specify that there will be a table named `urls` with columns `short_code`, `long_url`, and `created_at`. The `short_code` is generated using Base62 encoding of an auto-incremented ID, ensuring uniqueness. To improve performance, Redis might cache frequently accessed short codes with a TTL of seven days.

---

### HLD vs LLD in Interviews

One of the most common mistakes candidates make is jumping directly into LLD — talking about schemas or classes — before even confirming the functional requirements with the interviewer. This gives the impression of someone who codes without thinking about the larger picture.

The golden rule in interviews:

- **Start with HLD.**
    
- **Seek confirmation.** ("Does this high-level structure make sense?")
    
- **Move into LLD only if asked.**
    

This demonstrates maturity and the ability to work at the right level of abstraction depending on the discussion.

---

## 1.3 Functional vs Non-functional Requirements

### Functional Requirements

Functional requirements define **what the system must do**. These are the actual features and behaviors the system must support. They answer the question: _What should the system allow the user to accomplish?_

For example, in an e-commerce platform:

- A user should be able to browse products.
    
- A user should be able to add items to a shopping cart.
    
- The system should allow users to place orders and make payments.
    
- The system should notify the user when an order is shipped.
    

These requirements are often captured in the form of **user stories**: _“As a customer, I want to receive an email when my order is shipped so that I can track it.”_

In interviews, functional requirements are relatively easy to identify, and candidates usually handle them well.

---

### Non-functional Requirements

Non-functional requirements (NFRs), on the other hand, describe **how the system should behave** under certain conditions. They are not about features but about qualities such as performance, scalability, reliability, security, and maintainability.

Examples of NFRs include:

- The system should handle up to 10,000 concurrent users.
    
- API response times must be below 200 milliseconds for 95% of requests.
    
- The service should have an uptime of 99.99% per month.
    
- All data at rest should be encrypted with AES-256.
    

NFRs are critical because most system failures in the real world are not about missing functionality. A system that cannot scale, is insecure, or crashes under load is unusable, even if it functionally does everything required.

---

### Why Interviewers Care

In interviews, asking about NFRs distinguishes an average developer from a strong system designer. If you only focus on features, your design will collapse when the interviewer pushes you on scale or availability.

Example: Twitter’s early version allowed users to post tweets (functional requirement), but as the user base grew, the system repeatedly failed under load, showing the infamous “Fail Whale.” The missing piece was designing with NFRs like scalability and availability in mind.

---

### Interview Tip

Always clarify both functional and non-functional requirements before designing. You can phrase it like this:

- “Before I dive into the design, could you clarify the scale we need to support? Are we talking about thousands of users or millions?”
    
- “Do we have strict latency requirements, like sub-second responses, or is some delay acceptable?”
    

This makes the conversation collaborative and shows that you design based on requirements rather than assumptions.

---

## 1.4 Scalability Basics (Vertical vs Horizontal Scaling)

### Vertical Scaling (Scaling Up)

Vertical scaling means improving the performance of a single machine by adding more resources such as CPU, RAM, or faster storage. It is often the first strategy teams use because it requires minimal architectural changes.

For example, if your database is running on a server with 8 GB RAM and is struggling, upgrading the server to 64 GB RAM may immediately solve performance issues.

**Advantages of vertical scaling:**

- Simplicity: No changes needed to application code.
    
- Works well for small to medium systems.
    
- Easier to manage fewer servers.
    

**Disadvantages:**

- Hardware limits: Eventually, you cannot add more RAM or CPUs.
    
- Cost: High-end servers are disproportionately expensive.
    
- Single point of failure: If the server crashes, the system goes down.
    

---

### Horizontal Scaling (Scaling Out)

Horizontal scaling means adding more machines and distributing the load across them. Instead of one powerful machine, you use many average machines working together.

For example, instead of one massive database, you shard data across ten smaller databases. Instead of one Kafka broker, you run a cluster with fifty brokers, each responsible for a subset of partitions.

**Advantages of horizontal scaling:**

- Practically unlimited scaling by adding more machines.
    
- Fault tolerance: If one machine goes down, others can continue.
    
- Cost efficiency: Commodity hardware is cheaper.
    

**Disadvantages:**

- Increased complexity in code and operations.
    
- Requires distributed coordination (consensus protocols, leader election).
    
- Consistency issues can arise (CAP theorem trade-offs).
    

---

### Real-World Example

Amazon during Prime Day cannot simply add more RAM to one server to handle billions of requests. They rely heavily on horizontal scaling, distributing traffic across thousands of machines across multiple regions.

In contrast, a small startup building a prototype may find vertical scaling sufficient and simpler.

---

### Interview Framing

When asked about scaling in interviews:

- For a **prototype or small system**, say you would start with vertical scaling because it is simpler.
    
- For a **production-scale system**, explain how you would design for horizontal scaling.
    

This demonstrates that you understand trade-offs and don’t blindly jump to microservices or distributed systems when they aren’t needed.

---

## 1.5 Latency vs Throughput

Latency and throughput are two fundamental performance metrics, and they often come into conflict.

- **Latency** is the time it takes to process a single request from start to finish. If you send an HTTP request to an API and it takes 250 milliseconds to respond, that is latency.
    
- **Throughput** is the number of requests the system can handle in a given unit of time. For example, a system may process 10,000 requests per second.
    

---

### The Trade-off

Improving throughput often increases latency. For instance, batch processing many requests at once increases total system throughput but delays individual requests, leading to higher latency.

Conversely, optimizing for low latency may reduce throughput. If a system handles every request immediately without batching, it may not utilize resources efficiently, reducing total throughput.

---

### Examples

- A **payment system** must prioritize low latency because the customer is waiting on the screen. Even if throughput is lower, every transaction must complete within seconds.
    
- A **data analytics system** like Google Analytics prioritizes throughput because it processes billions of events. Latency of a few minutes or even hours may be acceptable.
    

---

### Interview Angle

A common trick question is: _“If we increase throughput, does latency always increase?”_  
The answer is no. Sometimes optimizations such as caching or better indexing improve both latency and throughput. But in general, the two are in tension, and you must balance them based on system requirements.

---

## 1.6 Estimating Load

Load estimation is a critical skill in interviews. It shows that you can think quantitatively about system scale and make reasonable assumptions. Interviewers do not care about exact numbers; they want to see structured reasoning.

---

### Example Estimation

Suppose you are asked to design a messaging system with 10 million daily active users. Each user sends 20 messages per day on average.

1. **Requests per second (RPS):**
    
    - Total messages per day = 10M × 20 = 200M.
        
    - Spread evenly, this is about 2,300 messages per second.
        
    - But traffic is not evenly distributed; peak load may be 10× average, so design for 20,000 messages per second.
        
2. **Storage requirements:**
    
    - If each message is 1 KB (text, metadata), then 200M messages/day = 200 GB/day.
        
    - In one year, that is about 73 TB.
        
3. **Cache requirements:**
    
    - If 10% of users are “hot” and actively messaging, then 10% of data may be frequently accessed.
        
    - That’s 20 GB/day worth of hot data — a Redis cluster may be required.
        
4. **Bandwidth:**
    
    - If each message is 1 KB and there are 20,000 messages/second at peak, that’s 20 MB/s, or ~160 Mbps.
        

---

### Why This Matters

By doing these calculations, you demonstrate that you understand scale. You also immediately reveal constraints:

- A single database cannot handle 20,000 writes/second.
    
- You need sharding or a distributed database.
    
- You need a caching layer to avoid hitting the database for every read.
    

---

### Interview Tip

When doing estimations, always say: _“I’m making assumptions here; we can adjust numbers if we have real data.”_ This makes you sound pragmatic and collaborative rather than overconfident.

---

## 1.7 SLA, SLO, and SLI

Modern systems live and die by reliability guarantees. To express these, we use three related concepts: SLA, SLO, and SLI.

- **SLA (Service Level Agreement):** A formal contract with customers specifying the expected reliability. For example, AWS S3 offers an SLA of 99.9% uptime. If it fails, customers may receive service credits.
    
- **SLO (Service Level Objective):** An internal target that the team aims for, often stricter than the SLA. For example, if the SLA is 99.9%, the team may set an SLO of 99.95% to ensure buffer.
    
- **SLI (Service Level Indicator):** The actual measured value of reliability. For example, monitoring might show uptime was 99.92% last month.
    

---

### Why Important in Interviews

If you are designing a notification service and the interviewer asks, “How reliable is it?” you should be able to say:

- “We will set an SLA of 99.9% delivery success. Our internal SLO will be 99.95%. We’ll track SLIs like actual delivery rate and end-to-end latency.”
    

This shows that you are thinking about reliability not as an afterthought but as a first-class concern.

---

## 1.8 Common Pitfalls

- Jumping into microservices without proving that a monolith cannot handle the load.
    
- Ignoring non-functional requirements such as scale and availability.
    
- Assuming vertical scaling will solve all problems without realizing its limits.
    
- Failing to estimate load, leading to under-designed systems.
    
- Confusing latency and throughput or assuming they are always inversely related.
    

---

## 1.9 Summary for Interviews

When facing any system design question:

1. **Clarify functional requirements** — what features are needed.
    
2. **Clarify non-functional requirements** — what scale, performance, and reliability are expected.
    
3. **Propose a high-level design** — main components and their interactions.
    
4. **Dive into low-level design** if asked — schemas, APIs, algorithms.
    
5. **Estimate load and discuss trade-offs** — SQL vs NoSQL, vertical vs horizontal scaling, latency vs throughput.
    
6. **Tie it back to SLAs and reliability** — show that you care about user experience, not just code.
    

If you consistently follow this structure, you will come across as systematic, thoughtful, and pragmatic — exactly what interviewers are looking for in a system design round.

---