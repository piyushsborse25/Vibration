In modern large-scale systems, **caching** is one of the most powerful techniques to improve performance, reduce latency, and cut infrastructure costs. Almost every big tech system—whether it’s YouTube, Amazon, or Facebook—relies heavily on caching layers. However, caching is also **deceptively tricky**. A poorly designed cache can cause inconsistencies, stale data, or even outages.

This chapter focuses on **cache design principles, strategies, pitfalls, and real-world scenarios** you may face in an interview.

---

## **5.1 Why Caching Matters**

- Databases are slower compared to memory. Reading data from **RAM** (nanoseconds) is orders of magnitude faster than fetching from a **disk-based database** (milliseconds).
    
- Without caching, every user request would hit the primary database, leading to:
    
    - Higher **latency** (slow responses).
        
    - Higher **infrastructure cost** (need bigger DB clusters).
        
    - Greater chance of **DB bottlenecks** (leading to cascading failures).
        
- With caching, frequently accessed data (hot data) can be **served from memory** instead of recomputed or re-fetched.
    

👉 Example: When you open Instagram, your feed isn’t fetched fresh from the DB every time. Instead, a **cache layer** like Redis or Memcached serves pre-computed timelines.

---

## **5.2 Cache Writing Strategies**

1. **Write-Through**
    
    - Data is written to both the **cache** and the **database** simultaneously.
        
    - Pros: Cache is always consistent with DB.
        
    - Cons: Higher write latency since two writes happen.
        
    
    **Use case**: Financial systems where **consistency > speed**.
    

---

2. **Write-Back (Write-Behind)**
    
    - Data is first written to the **cache**. Cache updates the database asynchronously.
        
    - Pros: Very fast writes.
        
    - Cons: Risk of data loss if cache fails before syncing with DB.
        
    
    **Use case**: Logging, analytics, or high-write systems where **performance > durability**.
    

---

3. **Write-Around**
    
    - Writes go directly to the **database**, skipping the cache. Cache is updated only on **read miss**.
        
    - Pros: Cache doesn’t get polluted with infrequently accessed data.
        
    - Cons: Higher chance of **cache misses**.
        
    
    **Use case**: Systems with **write-heavy workloads** and less repeated reads.
    

---

## **5.3 Cache Invalidation Strategies**

One of the hardest problems in computer science is **cache invalidation**—deciding when to evict or update cached data.

- **Time-to-Live (TTL)**
    
    - Data automatically expires after a fixed time.
        
    - Example: User profile cache refreshed every 30 minutes.
        
    - Pitfall: Too short → frequent DB hits; too long → stale data.
        
- **Write Invalidate**
    
    - On update, the cache entry is removed, forcing a fresh DB read next time.
        
- **Update Propagation**
    
    - On DB update, cache is also updated.
        

👉 **Real Interview Trap**: If you cache sensitive data like **user sessions** or **payment tokens** without a TTL, you risk stale/expired sessions staying active.

---

## **5.4 Content Delivery Networks (CDNs)**

A **CDN** is essentially a distributed caching system optimized for static/dynamic content.

- Servers (called edge servers) are deployed worldwide.
    
- When a user requests data (like a YouTube video thumbnail), the nearest CDN edge serves it instead of the origin server.
    

Benefits:

- Lower **latency** (user gets data from nearby).
    
- Reduced **server load** (origin handles fewer requests).
    
- Increased **fault tolerance** (if one region fails, another CDN node serves content).
    

👉 Example: **Netflix** uses its own CDN (Open Connect) to cache movies closer to users.

---

## **5.5 Hot Key Problem**

A **hot key** is when one cache entry gets too much traffic.

- Example: Everyone checks the same viral tweet → one Redis key overloaded → that Redis shard becomes a bottleneck.
    

**Solutions**:

- **Key Sharding**: Split the value across multiple keys.
    
- **Request Coalescing**: Batch requests so only one hits the DB.
    
- **Load-Aware Sharding**: Distribute load dynamically.
    

---

## **5.6 Cache Stampede Problem**

A **cache stampede** happens when a popular key expires and thousands of requests hit the database simultaneously. This can bring down the DB.

**Solutions**:

- **Locking**: Only one request recomputes the value; others wait.
    
- **Request Coalescing**: Aggregate multiple requests for the same key.
    
- **Early Refresh**: Refresh cache before expiry proactively.
    
- **Randomized TTL**: Add jitter to expiry times so keys don’t expire at once.
    

---

## **5.7 Pitfalls in Caching**

- **Caching sensitive data without TTL**: Can cause stale or insecure sessions.
    
- **Over-caching**: Cache layer becomes a bottleneck if used everywhere.
    
- **Cache inconsistency**: Hard to maintain strong consistency in distributed caches.
    
- **Wrong granularity**: Caching too fine-grained or too coarse can hurt performance.
    

---

## **5.8 Real-World Example (Interview-Ready)**

**Scenario**: You are designing a newsfeed system (like Facebook).

- **Problem**: Billions of users, some posts are viral. Database can’t handle direct requests.
    
- **Solution**:
    
    - Cache user timelines in Redis with TTL.
        
    - Use **write-through** for new posts (so they immediately show up in cached timelines).
        
    - Add **request coalescing** for viral posts to avoid DB overload.
        
    - Distribute CDN nodes globally for images/videos.
        

👉 Interviewer will likely ask:

- _How do you keep cache consistent with DB?_
    
- _What happens if a cache node fails?_
    
- _How do you prevent stampede on a hot key?_
    