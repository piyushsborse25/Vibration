### 1. **Core Concepts**
- **Client-Server Model**: A communication model where a client (user) makes requests to a server, which processes them and returns a response. The client and server are separate entities, often on different machines.
  
- **Latency vs Throughput**: 
  - **Latency**: The time it takes for a request to travel from the client to the server and back.
  - **Throughput**: The rate at which data is processed or transferred over a network.
  
- **Stateless vs Stateful Systems**: 
  - **Stateless**: No information is stored about previous requests (e.g., RESTful APIs).
  - **Stateful**: Information is stored and retained across requests (e.g., sessions in web applications).
  
- **RESTful API Design (REST)**: A design pattern for building web APIs that is stateless, uses standard HTTP methods, and operates over resources represented by URLs. It emphasizes simplicity, scalability, and performance.

- **HTTP Methods and Status Codes**: HTTP methods define the actions on resources, e.g., `GET`, `POST`, `PUT`, `DELETE`. HTTP status codes indicate the result of the request, e.g., `200 OK`, `404 Not Found`, `500 Internal Server Error`.

- **HTTP Headers and Caching (ETag, Cache-Control)**:
  - **ETag**: A header used to validate if the resource has changed.
  - **Cache-Control**: Directs caching behaviors in the browser or server.

- **Idempotency and Retry Strategies**: Idempotent operations produce the same result regardless of how many times they are executed (e.g., `GET`, `PUT`). Retry strategies are used when a request fails, ensuring the system can recover from temporary issues without creating duplicate operations.

- **Rate Limiting and Throttling**: Techniques used to control the amount of requests a client can make to a server, ensuring the system isn’t overloaded and preventing abuse.

- **Webhooks**: User-defined HTTP callbacks that notify external systems of certain events, often used for real-time updates.

- **API Gateway**: A server that acts as an entry point for client requests, managing API traffic, and handling concerns like security, load balancing, and rate limiting.

- **Load Balancer vs API Gateway**:
  - **Load Balancer**: Distributes incoming network traffic across multiple servers to ensure no single server is overwhelmed.
  - **API Gateway**: Serves as a reverse proxy to route requests to the appropriate backend services and can include functionalities like rate limiting, authentication, etc.

- **Forward Proxy and Reverse Proxy**:
  - **Forward Proxy**: Acts on behalf of the client to forward requests to the server.
  - **Reverse Proxy**: Acts on behalf of the server to forward requests from clients, often used to improve security and load balancing.

- **Load Balancing Algorithms (RR, LC, IP Hash, etc.)**: Methods to distribute client requests across servers:
  - **RR (Round Robin)**: Distributes requests evenly across servers.
  - **LC (Least Connections)**: Routes traffic to the server with the least active connections.
  - **IP Hash**: Routes traffic based on the client's IP address.

### 2. **Scalability and Architectural Patterns**
- **Scaling Strategies**: 
  - **Vertical Scaling**: Increasing resources (CPU, RAM) on a single server.
  - **Horizontal Scaling**: Adding more servers to distribute the load.
  - **Scale Cube - X/Y/Z**: A model for scaling by adding more copies of the service (X), splitting functionality (Y), and isolating data (Z).

- **Database Sharding**: Splitting a large database into smaller, more manageable pieces, called "shards," to improve performance and scalability.

- **Consistent Hashing**: A technique to distribute requests evenly across a distributed system and minimize the need to reassign data when nodes are added or removed.

- **Database Partitioning**: Dividing a database into segments for better performance. Types include:
  - **Range**: Partitioning based on a range of values (e.g., dates).
  - **Hash**: Partitioning based on a hash of the key.
  - **Composite**: Combining multiple partitioning strategies.

- **Caching Strategies (LRU, LFU, TTL)**: Techniques to store frequently accessed data for faster retrieval:
  - **LRU (Least Recently Used)**: Removes the least recently used items.
  - **LFU (Least Frequently Used)**: Removes the least frequently accessed items.
  - **TTL (Time to Live)**: Caches data for a specific period.

- **Distributed Caching**: Caching that spans multiple nodes to improve availability and scalability.

- **Data Replication**: Creating copies of data across different locations to ensure redundancy and improve read performance.

- **Distributed Locks**: Mechanisms to coordinate access to shared resources in distributed systems (e.g., Redis' `SETNX` command).

- **CAP Theorem**: States that in a distributed system, it’s impossible to guarantee all three:
  - **Consistency**: All nodes have the same data.
  - **Availability**: Every request gets a response.
  - **Partition Tolerance**: The system still operates even if some nodes are unreachable.

### 3. **Storage Systems**
- **Relational Databases (RDBMS)**: Traditional databases like MySQL and PostgreSQL, which store data in structured tables with relationships.

- **ACID Properties**: Guarantees for database transactions:
  - **Atomicity**: The transaction is all-or-nothing.
  - **Consistency**: The database remains in a valid state before and after the transaction.
  - **Isolation**: Transactions do not affect each other.
  - **Durability**: Changes are permanent once a transaction completes.

- **Key-Value Stores (KVS)**: A type of NoSQL database that stores data as key-value pairs (e.g., Redis, DynamoDB).

- **Distributed File Systems (e.g., HDFS)**: A system designed to store large amounts of data across multiple machines (e.g., Hadoop).

- **Erasure Coding**: A technique for data redundancy, where data is broken into pieces, and encoded with redundant data to protect against failures.

- **Write-Heavy System Design**: A design approach for systems where write operations significantly outweigh read operations (e.g., logging systems).

### 4. **Distributed Systems**
- **Fundamentals of Distributed Systems**: Systems where components are spread across different machines or networks, communicating with each other to achieve a common goal.

- **Leader Election**: A process by which nodes in a distributed system agree on a leader to coordinate tasks.

- **Concurrency and Synchronization**: Techniques to ensure that multiple processes or threads can run in parallel without interfering with each other.

- **Heartbeats and Health Checks**: Mechanisms to monitor the health of services or nodes in a distributed system.

- **Distributed Tracing and Observability**: Tools and methods to track and monitor requests across multiple services in a distributed system.

- **Messaging Queues and Pub/Sub Systems (MQ, Pub/Sub)**: Messaging patterns where systems communicate asynchronously through message queues or publish-subscribe mechanisms (e.g., Kafka, RabbitMQ).

- **Event-Driven Architecture (EDA)**: A design pattern where the flow of data is driven by events, such as changes or actions in the system.

- **Stream Processing**: Real-time processing of data streams, typically for tasks like monitoring or analytics.

- **MapReduce Paradigm**: A programming model for processing and generating large datasets by dividing the task into smaller sub-tasks (map) and combining the results (reduce).

- **Eventual Consistency and Read Repair**: In distributed systems, eventual consistency ensures that data will eventually be consistent, but not immediately, with mechanisms for correcting inconsistencies (e.g., read repair).

- **Backpressure Handling in Streaming**: Techniques used to prevent overwhelming a system by controlling the rate at which data is produced or consumed.

### 5. **Real-World System Design Cases**
- **Timeline/Fanout Architecture**: A system design for handling real-time updates, such as a social media feed or event stream.

- **High-Volume Counters**: Systems designed to efficiently handle high-frequency counts like "likes" or "views" on large platforms.

- **Video Streaming Architecture**: The design of systems that deliver high-quality video content to users, balancing server load, latency, and buffering.

- **WebSocket Communication Model (WS)**: A protocol for establishing two-way communication channels between a client and a server over a persistent connection, often used for real-time applications.

### 6. **Deployment and Reliability**
- **Deployment Strategies (Rolling, Canary, Blue-Green)**:
  - **Rolling**: Updating one server at a time to reduce downtime.
  - **Canary**: Deploying a new version to a small subset of users before a full rollout.
  - **Blue-Green**: Having two identical environments (Blue and Green) to switch between for smooth deployment transitions.

- **Latency Percentiles (P90, P95, P99)**: Metrics to measure the time taken for requests to complete. Percentiles give insight into the performance for a large subset of users.

- **Disaster Recovery (RTO, RPO, Failover)**:
  - **RTO (Recovery Time Objective)**: How quickly a system should be restored after a failure.
  - **RPO (Recovery Point Objective)**: The acceptable amount of data loss in case of failure.
  - **Failover**: Switching to a backup system in case of failure.

- **Monitoring, Logging, and Alerting**: Tools and practices to track the health and performance of a system, log events, and send alerts in case of issues.

### 7. **Optional/Advanced Topics**
- **Time-Series Databases (TSDB)**: Databases optimized for storing time-based data, like metrics or logs (e.g., InfluxDB, Prometheus).

- **Graph Databases**: Databases designed to represent and query relationships between entities (e.g., Neo4j).

- **BLOB Storage (Binary Large Objects)**: Storing large amounts of binary data, like images or videos (e.g., Amazon S3).

- **Bloom Filters**: A probabilistic data structure used to test if an element is a member of a set, with some risk of false positives.

- **HyperLogLog (HLL)**: A probabilistic algorithm used for counting distinct elements in a dataset with low memory usage.

- **Peer-to-Peer Networks (P2P)**: A decentralized network where each participant can act as both a client and a server (e.g., BitTorrent).

- **Content Delivery Networks (CDN)**: Networks of distributed servers designed to deliver content (e.g., images, videos) to users faster by caching content closer to them.

- **Email Protocols and Delivery (SMTP, IMAP)**:
  - **SMTP**: Simple Mail Transfer Protocol for sending emails.
  - **IMAP**: Internet Message Access Protocol for retrieving and storing emails.