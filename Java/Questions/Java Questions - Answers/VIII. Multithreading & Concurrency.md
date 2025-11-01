### **111. What is Multithreading in Java?**

- **Definition:** It allows concurrent execution of two or more threads.
    
- **Goal:** Achieve better CPU utilization and performance.
    
- **Threads share:** Common memory but execute independently.
    
- **Benefits:** Faster execution, non-blocking UI, better resource use.
    
- **Implementation:**
    
    1. Extend `Thread` class.
        
    2. Implement `Runnable` interface.
        

---

### **112. What is the difference between `Runnable` and `Thread`?**

|Aspect|`Runnable`|`Thread`|
|---|---|---|
|Type|Interface|Class|
|Inheritance|Allows extending other classes|Doesn’t allow multiple inheritance|
|Object Sharing|Same object can be shared by multiple threads|Each thread needs its own instance|
|Recommended|✅ Yes (more flexible)|❌ Less flexible|

---

### **113. What is a synchronized block in Java?**

- A **synchronized block** ensures only one thread executes a specific section of code at a time.
    
- Prevents **race conditions** and ensures thread safety.
    
- Example:
    
    ```java
    synchronized(this) {
        // critical section
    }
    ```
    
- Lock is acquired on the specified object (`this`).
    

---

### **114. What are deadlocks in multithreading?**

- A **deadlock** occurs when two or more threads are waiting indefinitely for each other’s lock.
    
- Example:
    
    - Thread 1 holds Lock A, waits for Lock B.
        
    - Thread 2 holds Lock B, waits for Lock A.
        
- System halts as both threads keep waiting.
    

---

### **115. What are the differences between `sleep()` and `wait()` methods?**

|Feature|`sleep()`|`wait()`|
|---|---|---|
|Class|`Thread`|`Object`|
|Lock Release|❌ Does not release lock|✅ Releases lock|
|Wake Mechanism|Automatically after time|Via `notify()` / `notifyAll()`|
|Purpose|Pause execution|Thread communication|

---

### **116. What is a daemon thread?**

- A **daemon thread** runs in the background (e.g., Garbage Collector).
    
- JVM exits when only daemon threads remain.
    
- Example:
    
    ```java
    thread.setDaemon(true);
    ```
    
- Used for background services and low-priority tasks.
    

---

### **117. What are the different types of thread priorities in Java?**

- Priority range: **1 (MIN_PRIORITY)** to **10 (MAX_PRIORITY)**.
    
- Default: **5 (NORM_PRIORITY)**.
    
- Higher priority threads get preference in scheduling, but not guaranteed.
    

---

### **118. What is the `ThreadLocal` class in Java?**

- Provides **thread-specific variables**.
    
- Each thread has its **own isolated copy**.
    
- Used to prevent shared state in concurrent code.
    
    ```java
    ThreadLocal<Integer> local = ThreadLocal.withInitial(() -> 0);
    ```
    

---

### **119. What is a ConcurrentHashMap in Java?**

- A **thread-safe Map** from `java.util.concurrent`.
    
- Achieves concurrency using internal segment-level locking (no global lock).
    
- Allows concurrent read/write by multiple threads.
    
- Doesn’t allow null keys or values.
    

---

### **120. What are Reentrant Locks in Java?**

- Part of `java.util.concurrent.locks`.
    
- A thread can **re-acquire the same lock** it already holds.
    
- More control than `synchronized`:
    
    - Try-lock
        
    - Timeout
        
    - Fairness policy
        
- Example:
    
    ```java
    ReentrantLock lock = new ReentrantLock();
    lock.lock();
    try { /* critical section */ } finally { lock.unlock(); }
    ```
    

---

### **121. What is the Fork/Join Framework in Java?**

- Introduced in **Java 7** for **parallel task execution**.
    
- Splits tasks into smaller **subtasks (fork)** and combines results (join).
    
- Uses **work-stealing algorithm** for efficiency.
    
- Example:
    
    ```java
    ForkJoinPool pool = new ForkJoinPool();
    pool.invoke(new MyRecursiveTask());
    ```
    

---

### **122. What is the ExecutorService Framework?**

- Manages a **pool of worker threads**.
    
- Handles **task submission**, **thread lifecycle**, and **scheduling**.
    
- Example:
    
    ```java
    ExecutorService executor = Executors.newFixedThreadPool(3);
    executor.submit(() -> System.out.println("Task running"));
    executor.shutdown();
    ```
    

---

### **123. What is the role of `Semaphore` in multithreading?**

- Controls the **number of threads** that can access a resource simultaneously.
    
- Uses **permits** to manage concurrency.
    
- Example:
    
    ```java
    Semaphore sem = new Semaphore(2);
    sem.acquire();
    // critical section
    sem.release();
    ```
    
- Useful for resource management.
    

---

### **124. What are `CountDownLatch` and `CyclicBarrier`?**

|Feature|`CountDownLatch`|`CyclicBarrier`|
|---|---|---|
|Purpose|Waits for N threads to finish before continuing|Waits for all threads to reach a common point|
|Reusability|One-time use|Reusable|
|Example Use|Wait for multiple services to initialize|All threads start together after setup|

---

### **125. What are CompletableFutures in Java?**

- Introduced in **Java 8** for **asynchronous programming**.
    
- Allows chaining, combining, and async callbacks.
    
- Example:
    
    ```java
    CompletableFuture.supplyAsync(() -> "Task")
                     .thenApply(r -> r + " done")
                     .thenAccept(System.out::println);
    ```
    
- Supports **non-blocking** and **reactive** style programming.
    