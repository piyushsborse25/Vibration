So far, we have learned about executing tasks immediately with `ExecutorService`. But what if you want to **schedule tasks with delays** or run them **periodically** (like a cron job)? That’s where **`ScheduledExecutorService`** comes in.

---

## 7.1 What is `ScheduledExecutorService`?

- It’s a **subinterface** of `ExecutorService`.
    
- Provides methods to **schedule commands**:
    
    - **Delayed execution** (run once after a delay).
        
    - **Periodic execution** (repeat at fixed intervals).
        
- Replaces the old `java.util.Timer` & `TimerTask` with a more **robust, thread-pool-based** approach.
    
- Prevents single-task failure from killing the whole scheduler (which was a Timer problem).
    

👉 Think of it as a **smarter, multi-threaded cron system inside Java**.

---

## 7.2 Creating a Scheduled Executor

```java
ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);
```

- `newScheduledThreadPool(int corePoolSize)` → creates a pool of threads to schedule tasks.
    
- Threads can handle **multiple scheduled tasks concurrently**.
    

---

## 7.3 Core Scheduling Methods

### 1. **schedule()**

Run a task **once** after a given delay.

```java
scheduler.schedule(() -> {
    System.out.println("Run after 5 seconds: " + Thread.currentThread().getName());
}, 5, TimeUnit.SECONDS);
```

---

### 2. **scheduleAtFixedRate()**

Run a task **repeatedly** at a fixed rate.

- Delay is measured **between start times**, not completion times.
    

```java
scheduler.scheduleAtFixedRate(() -> {
    System.out.println("Fixed rate: " + System.currentTimeMillis());
}, 0, 3, TimeUnit.SECONDS);
```

If a task takes longer than the rate, executions may **overlap or get queued**.

---

### 3. **scheduleWithFixedDelay()**

Run a task **repeatedly** with a fixed delay **after completion**.

- Delay is measured **between task end and next start**.
    

```java
scheduler.scheduleWithFixedDelay(() -> {
    System.out.println("Fixed delay: " + System.currentTimeMillis());
    try { Thread.sleep(2000); } catch (InterruptedException ignored) {}
}, 0, 3, TimeUnit.SECONDS);
```

If this task takes 2s, and the delay is 3s → next execution starts 5s after the previous start.

---

## 7.4 Choosing Between `scheduleAtFixedRate` vs `scheduleWithFixedDelay`

- **Fixed Rate** → Use when **time-based scheduling is critical** (e.g., heartbeat every 5 seconds).
    
- **Fixed Delay** → Use when you want a **pause between tasks** (e.g., retrying network requests with a gap).
    

---

## 7.5 Cancelling Scheduled Tasks

You can cancel using the `ScheduledFuture`.

```java
ScheduledFuture<?> future = scheduler.scheduleAtFixedRate(() -> {
    System.out.println("Repeating task...");
}, 0, 1, TimeUnit.SECONDS);

Thread.sleep(5000);  // Let it run a few times
future.cancel(true); // Stops further execution
```

---

## 7.6 Real-World Scenarios

### ✅ Scenario 1: Heartbeat Monitor

- A server sends a **heartbeat** to check health every 10 seconds.
    
- Use `scheduleAtFixedRate`.
    

### ✅ Scenario 2: Retry with Delay

- A system tries to reconnect to a service after failure with a **5-second delay** each attempt.
    
- Use `scheduleWithFixedDelay`.
    

### ✅ Scenario 3: Delayed Notifications

- Send an email reminder **2 hours later** after a booking.
    
- Use `schedule()`.
    

---

## 7.7 Best Practices

1. Always **shutdown the scheduler**:
    
    ```java
    scheduler.shutdown();
    ```
    
2. Prefer `ScheduledExecutorService` over `Timer` — better handling of concurrency & exceptions.
    
3. Use **separate pools** for long-running and short periodic tasks.
    
4. Monitor task failures — exceptions thrown inside scheduled tasks can silently kill them.
    
5. Combine with `Future` for result tracking.
    