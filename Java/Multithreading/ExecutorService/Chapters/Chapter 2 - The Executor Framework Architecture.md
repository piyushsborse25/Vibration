The **Executor Framework** (introduced in Java 5 under `java.util.concurrent`) was created to decouple **task submission** from **task execution**. Before its existence, developers had to manually create and manage threads, which led to complexity, resource leaks, and poor scalability.

Executor framework abstracts away thread management, giving you a **high-level API** to manage concurrency.

---

## **2.1 Core Idea: Decoupling Tasks and Threads**

- **Before Executor Framework:**
    
    ```java
    Thread t = new Thread(() -> {
        System.out.println("Running in thread: " + Thread.currentThread().getName());
    });
    t.start();
    ```
    
    Problems:
    
    - Manual thread lifecycle management (`start`, `join`, etc.).
        
    - Too many threads → resource exhaustion.
        
    - Hard to reuse threads → poor performance.
        
- **With Executor Framework:**
    
    ```java
    ExecutorService executor = Executors.newFixedThreadPool(2);
    executor.submit(() -> {
        System.out.println("Running in thread: " + Thread.currentThread().getName());
    });
    executor.shutdown();
    ```
    
    Benefits:
    
    - You **submit tasks**; framework decides how/when to execute.
        
    - Threads are **pooled and reused**.
        
    - Cleaner, scalable code.
        

---

## **2.2 Key Interfaces**

At the heart of the framework are **three main interfaces**:

1. **Executor**
    
    - Base interface (super simple).
        
    - Has only one method:
        
        ```java
        void execute(Runnable command);
        ```
        
    - Example:
        
        ```java
        Executor executor = command -> new Thread(command).start();
        executor.execute(() -> System.out.println("Hello from Executor!"));
        ```
        
2. **ExecutorService** (extends Executor)
    
    - Provides richer lifecycle and task management:
        
        - `submit()` (with `Runnable` or `Callable`).
            
        - `invokeAll()`, `invokeAny()`.
            
        - `shutdown()` and `awaitTermination()`.
            
3. **ScheduledExecutorService** (extends ExecutorService)
    
    - Adds scheduling support for tasks (delayed or periodic execution).
        
    - Similar to a `Timer`, but more powerful and flexible.
        

---

## **2.3 The Executors Factory Class**

Java provides the `Executors` utility class to **easily create thread pools**:

- **Fixed thread pool**
    
    ```java
    ExecutorService fixedPool = Executors.newFixedThreadPool(5);
    ```
    
    → At most 5 threads, reused for all tasks.
    
- **Cached thread pool**
    
    ```java
    ExecutorService cachedPool = Executors.newCachedThreadPool();
    ```
    
    → Creates new threads as needed, reuses idle ones. Good for short-lived tasks.
    
- **Single thread executor**
    
    ```java
    ExecutorService singleThread = Executors.newSingleThreadExecutor();
    ```
    
    → All tasks executed sequentially in one thread.
    
- **Scheduled thread pool**
    
    ```java
    ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(3);
    ```
    
    → Runs tasks after delays or periodically.
    

---

## **2.4 Thread Pooling**

**Why thread pools?**

- Creating threads is expensive (memory + OS context switching).
    
- Thread pools **reuse threads**, improving performance.
    
- Pool size controls **parallelism** and **resource usage**.
    

### Example: Without pooling

```java
for (int i = 0; i < 10; i++) {
    new Thread(() -> {
        System.out.println("Task by " + Thread.currentThread().getName());
    }).start();
}
```

→ Creates 10 new threads every time.

### Example: With pooling

```java
ExecutorService pool = Executors.newFixedThreadPool(3);

for (int i = 0; i < 10; i++) {
    pool.execute(() -> {
        System.out.println("Task by " + Thread.currentThread().getName());
    });
}
pool.shutdown();
```

→ At most 3 threads reused for 10 tasks.

---

## **2.5 Executor vs ExecutorService**

|Feature|Executor|ExecutorService|
|---|---|---|
|Introduced in|Java 5|Java 5|
|Methods|`execute(Runnable)`|`submit()`, `invokeAll()`, `shutdown()`, etc.|
|Return value|`void`|`Future<?>` (when using `submit`)|
|Lifecycle management|No|Yes (`shutdown`, `awaitTermination`)|
|Task types supported|Only `Runnable`|`Runnable` + `Callable`|

---

## **2.6 Executors vs Thread Pools**

⚠️ Important Note:  
`Executors` factory methods (like `newFixedThreadPool`) are very convenient but can be dangerous in **production systems** because:

- `newCachedThreadPool()` → unbounded number of threads → OutOfMemoryError.
    
- `newFixedThreadPool()` → unbounded task queue → memory leaks if too many tasks pile up.
    

💡 Best practice:  
Use **`ThreadPoolExecutor`** directly with **explicit configuration**.

Example:

```java
ExecutorService customPool = new ThreadPoolExecutor(
    2,               // core pool size
    4,               // max pool size
    60L,             // idle thread timeout
    TimeUnit.SECONDS,
    new ArrayBlockingQueue<>(10)   // bounded task queue
);
```

---

## **2.7 Real-Life Analogy**

Think of an **ExecutorService** like a **restaurant kitchen**:

- You (the client) place **orders** (tasks).
    
- The **chefs** (threads in pool) cook them.
    
- The **manager** (ExecutorService) decides which chef does what and in what order.
    
- If too many orders come in:
    
    - Some wait in a **queue**.
        
    - If queue is full, orders may be **rejected** (Rejection Policy).
        

---

## **2.8 Code Practical: Comparing Executors**

### Example 1 – Fixed Thread Pool

```java
ExecutorService pool = Executors.newFixedThreadPool(2);

for (int i = 1; i <= 5; i++) {
    int taskId = i;
    pool.submit(() -> {
        System.out.println("Task " + taskId + " by " + Thread.currentThread().getName());
    });
}
pool.shutdown();
```

🔎 Output: Only **2 threads** work, tasks are queued.

---

### Example 2 – Cached Thread Pool

```java
ExecutorService pool = Executors.newCachedThreadPool();

for (int i = 1; i <= 5; i++) {
    int taskId = i;
    pool.submit(() -> {
        System.out.println("Task " + taskId + " by " + Thread.currentThread().getName());
    });
}
pool.shutdown();
```

🔎 Output: May create 5 threads instantly since tasks are bursty.

---

### Example 3 – Single Thread Executor

```java
ExecutorService pool = Executors.newSingleThreadExecutor();

for (int i = 1; i <= 5; i++) {
    int taskId = i;
    pool.submit(() -> {
        System.out.println("Task " + taskId + " by " + Thread.currentThread().getName());
    });
}
pool.shutdown();
```

🔎 Output: Always executed **sequentially** in one thread.

---

✅ **Summary of Chapter 2**

- Executor Framework decouples **task submission** from **execution**.
    
- Main interfaces: **Executor**, **ExecutorService**, **ScheduledExecutorService**.
    
- Factory methods in `Executors` help create thread pools.
    
- Thread pooling avoids expensive thread creation.
    
- For real production use: prefer **ThreadPoolExecutor** with bounded queues.
    