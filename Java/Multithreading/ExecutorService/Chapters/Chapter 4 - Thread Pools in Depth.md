## 4.1 What is a Thread Pool?

A **thread pool** is a group of worker threads that are **created once and reused** to execute multiple tasks.  
Instead of creating a new thread for every task (which is expensive), we submit tasks to the pool, and the pool assigns them to available threads.

✅ Advantages:

- **Performance**: reduces thread creation overhead.
    
- **Resource control**: prevents system from creating too many threads.
    
- **Scalability**: manages workloads in high-concurrency environments.
    
- **Flexibility**: configurable behavior (queue size, rejection policy, etc.).
    

---

## 4.2 How Thread Pools Work Internally

When you submit a task to an `ExecutorService` (which internally uses a `ThreadPoolExecutor`):

1. If **fewer than `corePoolSize` threads** are running → new thread is created.
    
2. If **core threads are busy**, the task goes into a **queue**.
    
3. If the queue is full and fewer than `maximumPoolSize` threads exist → new thread is created.
    
4. If max threads are also busy → task is handled by a **rejection policy**.
    

📌 Internally managed by `ThreadPoolExecutor`.

---

## 4.3 Types of Thread Pools (via `Executors`)

### 1. **FixedThreadPool**

```java
ExecutorService pool = Executors.newFixedThreadPool(3);
```

- Always has **N fixed threads**.
    
- Tasks are queued if all threads are busy.
    
- Best for: **CPU-bound tasks**.
    

Example:

```java
ExecutorService pool = Executors.newFixedThreadPool(2);

for (int i = 1; i <= 5; i++) {
    int taskId = i;
    pool.submit(() -> {
        System.out.println("Task " + taskId + " running on " + Thread.currentThread().getName());
        try { Thread.sleep(1000); } catch (InterruptedException e) {}
    });
}
pool.shutdown();
```

---

### 2. **CachedThreadPool**

```java
ExecutorService pool = Executors.newCachedThreadPool();
```

- Creates new threads as needed.
    
- Idle threads are **reused** if available.
    
- Threads idle for 60s are terminated.
    
- Best for: **short-lived, lightweight tasks** (e.g., handling web requests).
    

---

### 3. **SingleThreadExecutor**

```java
ExecutorService pool = Executors.newSingleThreadExecutor();
```

- Only **one thread** executes tasks sequentially.
    
- Ensures **order of execution** is preserved.
    
- Useful for: tasks that must **not run in parallel**.
    

---

### 4. **ScheduledThreadPool**

```java
ScheduledExecutorService pool = Executors.newScheduledThreadPool(2);
```

- Executes tasks **after a delay** or **periodically**.
    
- Similar to `Timer`, but with multiple threads and better handling of exceptions.
    

Example:

```java
ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

scheduler.scheduleAtFixedRate(
    () -> System.out.println("Running every 2 seconds on " + Thread.currentThread().getName()),
    1, 2, TimeUnit.SECONDS);
```

---

### 5. **WorkStealingPool** (Java 8+)

```java
ExecutorService pool = Executors.newWorkStealingPool();
```

- Uses **ForkJoinPool** under the hood.
    
- Threads can "steal" tasks from others to balance load.
    
- Best for: **large number of independent tasks**.
    

---

## 4.4 Custom Thread Pools with `ThreadPoolExecutor`

For maximum control, use `ThreadPoolExecutor` directly.

```java
ThreadPoolExecutor pool = new ThreadPoolExecutor(
    2,                  // corePoolSize
    4,                  // maximumPoolSize
    30, TimeUnit.SECONDS, // keepAliveTime
    new ArrayBlockingQueue<>(2), // work queue
    Executors.defaultThreadFactory(),
    new ThreadPoolExecutor.AbortPolicy() // rejection policy
);
```

---

## 4.5 Rejection Policies

When the queue is full and the pool is at max capacity, tasks are rejected.  
Options (`RejectedExecutionHandler`):

1. **AbortPolicy** (default) → throws `RejectedExecutionException`.
    
2. **CallerRunsPolicy** → executes task in calling thread.
    
3. **DiscardPolicy** → silently drops the task.
    
4. **DiscardOldestPolicy** → drops oldest queued task, adds new one.
    

---

## 4.6 Best Practices with Thread Pools

- **Right size pool**:
    
    - CPU-bound → `#cores + 1`
        
    - IO-bound → `#cores * 2` (or higher)
        
- Use **bounded queues** to avoid OutOfMemory errors.
    
- Always **shutdown the pool** (`shutdown()` or `shutdownNow()`).
    
- Use **custom thread factory** to name threads (helps debugging).
    
- Prefer `ScheduledThreadPool` over `Timer` for reliability.
    

---

✅ **Quick Demo – Custom Rejection Handling**

```java
ThreadPoolExecutor pool = new ThreadPoolExecutor(
    1, 1, 0L, TimeUnit.MILLISECONDS,
    new ArrayBlockingQueue<>(1),
    new ThreadPoolExecutor.CallerRunsPolicy() // rejection handler
);

for (int i = 1; i <= 5; i++) {
    int taskId = i;
    pool.submit(() -> {
        System.out.println("Task " + taskId + " running in " + Thread.currentThread().getName());
        try { Thread.sleep(500); } catch (InterruptedException e) {}
    });
}

pool.shutdown();
```

Here, when the queue is full, tasks will run in the **calling thread** instead of being rejected.

---

🔑 **Summary of Chapter 4**

- Thread pools **reuse threads**, improving performance.
    
- Various prebuilt pools exist (`Fixed`, `Cached`, `Single`, `Scheduled`, `WorkStealing`).
    
- `ThreadPoolExecutor` offers **fine-grained control** (core size, max size, queue, rejection policy).
    
- Right pool choice depends on workload (CPU-bound vs IO-bound).
    