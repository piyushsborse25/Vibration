Now that you know the foundations and practical implementations of `ExecutorService`, let’s discuss **how to use it effectively in production**. Many real-world systems suffer from deadlocks, thread starvation, or resource exhaustion because developers didn’t follow best practices. This chapter is about avoiding those traps.

---

## 10.1 ✅ Best Practices

### 1. **Always Shut Down ExecutorService**

- Executors create **non-daemon threads** that keep running until explicitly terminated.
    
- Always call `shutdown()` or `shutdownNow()` in `finally` blocks or resource management logic.
    

```java
ExecutorService executor = Executors.newFixedThreadPool(3);
try {
    // submit tasks
} finally {
    executor.shutdown(); // graceful shutdown
}
```

---

### 2. **Use Bounded Thread Pools**

- Avoid `newCachedThreadPool()` in high-load systems (can spawn unlimited threads → OOM risk).
    
- Instead, define **maximum thread counts** with `newFixedThreadPool()` or `ThreadPoolExecutor`.
    

👉 Example:

```java
ExecutorService pool = new ThreadPoolExecutor(
    2, 5, 
    60L, TimeUnit.SECONDS,
    new ArrayBlockingQueue<>(100) // bounded queue
);
```

---

### 3. **Choose Thread Pool Type Based on Workload**

- **CPU-bound tasks** → Use `FixedThreadPool` with threads = `# of cores`.
    
- **I/O-bound tasks** → Use more threads (e.g., 2x or 3x cores).
    
- **Event-driven / async pipelines** → Use `CompletableFuture` + async thread pools.
    

---

### 4. **Use Named Thread Factories**

Default threads are often just `"pool-1-thread-1"` which makes debugging painful.

```java
ExecutorService executor = Executors.newFixedThreadPool(3, r -> {
    Thread t = new Thread(r);
    t.setName("OrderService-Worker-" + t.getId());
    return t;
});
```

Now logs will clearly show which service thread executed which task.

---

### 5. **Handle Exceptions in Tasks**

- Uncaught exceptions in `Runnable` **disappear silently**.
    
- Wrap tasks or use `Future.get()` to detect failures.
    

```java
executor.submit(() -> {
    try {
        riskyOperation();
    } catch (Exception e) {
        System.err.println("Task failed: " + e.getMessage());
    }
});
```

---

### 6. **Prefer `CompletableFuture` for Async Composition**

- For chaining multiple async tasks, `CompletableFuture` is cleaner and avoids **callback hell**.
    

```java
CompletableFuture.supplyAsync(() -> fetchUser(), executor)
                 .thenApplyAsync(user -> enrichData(user), executor)
                 .thenAcceptAsync(finalData -> save(finalData), executor);
```

---

## 10.2 ❌ Common Pitfalls

### 1. **Forgetting to shut down executors**

- Leads to **JVM not exiting** because non-daemon worker threads are still alive.
    

### 2. **Using too many threads**

- More threads ≠ better performance.
    
- Excessive threads cause **context switching overhead** and degrade performance.
    

### 3. **Blocking inside thread pools**

- Submitting blocking calls (e.g., `.get()` or `Thread.sleep()`) inside executor tasks reduces throughput.
    
- Consider `CompletableFuture` or async IO instead.
    

### 4. **Unbounded Queues**

- `newFixedThreadPool()` uses an **unbounded queue** by default.
    
- Can cause OOM if tasks are submitted faster than processed.
    

### 5. **Ignoring rejected tasks**

- If a pool is saturated, `RejectedExecutionHandler` decides what happens.
    
- By default → `RejectedExecutionException`.  
    👉 Always configure this explicitly.
    

---

## 10.3 🔧 Advanced Tips

### 1. **Custom RejectedExecutionHandler**

```java
ThreadPoolExecutor executor = new ThreadPoolExecutor(
    2, 4, 30, TimeUnit.SECONDS, new ArrayBlockingQueue<>(10),
    new ThreadPoolExecutor.CallerRunsPolicy() // fallback
);
```

- `AbortPolicy` (default) → Throws exception.
    
- `CallerRunsPolicy` → Runs task in calling thread.
    
- `DiscardPolicy` → Silently drops task.
    
- `DiscardOldestPolicy` → Drops oldest queued task.
    

---

### 2. **Work Stealing Pool for Parallel Tasks**

```java
ExecutorService executor = Executors.newWorkStealingPool();
```

- Uses **ForkJoinPool** under the hood.
    
- Great for divide-and-conquer problems like **sorting, image processing**.
    

---

### 3. **Monitoring Thread Pools**

- Use `ThreadPoolExecutor` methods like:
    
    - `getActiveCount()`
        
    - `getQueue().size()`
        
    - `getCompletedTaskCount()`
        

Example:

```java
ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(3);
executor.submit(() -> doWork());
System.out.println("Active Threads: " + executor.getActiveCount());
```

---

### 4. **Dynamic Scaling**

- You can adjust pool size at runtime:
    

```java
executor.setCorePoolSize(5);
executor.setMaximumPoolSize(10);
```

---

### 5. **Combine Executors + Schedulers**

- Use `ScheduledExecutorService` + `ExecutorService` to schedule recurring async tasks.
    

```java
ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);
scheduler.scheduleAtFixedRate(() -> {
    executor.submit(() -> System.out.println("Processing batch..."));
}, 0, 10, TimeUnit.SECONDS);
```

---

## 10.4 🚀 Real-World Example: Resilient Microservice Executor Setup

Imagine a **PaymentService** that processes incoming payments asynchronously:

```java
ExecutorService paymentExecutor = new ThreadPoolExecutor(
    5, 10,
    60, TimeUnit.SECONDS,
    new ArrayBlockingQueue<>(100),
    r -> {
        Thread t = new Thread(r);
        t.setName("PaymentWorker-" + t.getId());
        return t;
    },
    new ThreadPoolExecutor.CallerRunsPolicy()
);

for (int i = 0; i < 200; i++) {
    paymentExecutor.submit(() -> {
        try {
            processPayment();
        } catch (Exception e) {
            log.error("Payment failed", e);
        }
    });
}
```

- **Core size** = 5 workers.
    
- **Max size** = 10 during peak load.
    
- **Queue size** = 100 → prevents OOM.
    
- **Rejected handler** = Caller thread fallback.
    
- **Named threads** = Easier debugging.
    
- **Graceful shutdown** on service stop.
    

This is a **production-grade setup** you’d see in fintech, e-commerce, or large-scale APIs.

---

✅ **Key Takeaway of Chapter 10**:  
ExecutorService is powerful, but with great power comes responsibility. Use bounded pools, shut them down, handle failures, and monitor performance. Always tune based on **CPU vs I/O workloads** and system throughput needs.