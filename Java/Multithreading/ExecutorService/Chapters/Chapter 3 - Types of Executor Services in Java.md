## 3.1 Introduction

The `ExecutorService` framework provides several factory methods (via the `Executors` class) that allow you to create different kinds of thread pools. Each pool has different **thread management strategies**, **resource handling policies**, and **use cases**.

In this chapter, we will explore all the types in detail with **theory, diagrams, and code examples**.

---

## 3.2 Key Executor Types

Here’s the list of major `ExecutorService` types:

1. **SingleThreadExecutor**
    
2. **FixedThreadPool**
    
3. **CachedThreadPool**
    
4. **ScheduledThreadPool**
    
5. **WorkStealingPool**
    
6. **Custom ThreadPoolExecutor**
    

We’ll go through each one.

---

## 3.3 SingleThreadExecutor

### Concept

- Executes tasks sequentially in **a single worker thread**.
    
- Ensures that only **one task** is running at a time.
    
- Useful when you need **thread safety without synchronization**.
    

### Characteristics

- **Thread count**: Always 1.
    
- **Queue**: Unbounded.
    
- **Guarantee**: Tasks are executed in the order they were submitted (FIFO).
    

### Example

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class SingleThreadExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        for (int i = 1; i <= 5; i++) {
            final int taskId = i;
            executor.submit(() -> {
                System.out.println("Task " + taskId + " executed by " +
                        Thread.currentThread().getName());
            });
        }

        executor.shutdown();
    }
}
```

### Output (ordered execution)

```
Task 1 executed by pool-1-thread-1
Task 2 executed by pool-1-thread-1
Task 3 executed by pool-1-thread-1
Task 4 executed by pool-1-thread-1
Task 5 executed by pool-1-thread-1
```

✅ Use case: Logging, writing to a single file, background monitoring.

---

## 3.4 FixedThreadPool

### Concept

- Creates a pool with a **fixed number of threads**.
    
- If more tasks are submitted than available threads, tasks are queued.
    
- Prevents resource exhaustion by capping threads.
    

### Characteristics

- **Thread count**: Fixed (e.g., 5).
    
- **Queue**: Unbounded.
    
- Suitable for CPU-bound tasks.
    

### Example

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class FixedThreadPoolExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(3);

        for (int i = 1; i <= 10; i++) {
            final int taskId = i;
            executor.submit(() -> {
                System.out.println("Task " + taskId + " executed by " +
                        Thread.currentThread().getName());
                try { Thread.sleep(1000); } catch (InterruptedException e) { }
            });
        }

        executor.shutdown();
    }
}
```

### Output (parallel execution)

```
Task 1 executed by pool-1-thread-1
Task 2 executed by pool-1-thread-2
Task 3 executed by pool-1-thread-3
Task 4 executed by pool-1-thread-1
...
```

✅ Use case: Server handling a fixed number of client requests.

---

## 3.5 CachedThreadPool

### Concept

- Creates threads dynamically as needed.
    
- Reuses previously constructed threads if available.
    
- Idle threads are terminated after 60 seconds.
    

### Characteristics

- **Thread count**: Unbounded (limited by system resources).
    
- **Queue**: SynchronousQueue (direct handoff, no storage).
    
- Best for I/O-bound tasks.
    

### Example

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CachedThreadPoolExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newCachedThreadPool();

        for (int i = 1; i <= 20; i++) {
            final int taskId = i;
            executor.submit(() -> {
                System.out.println("Task " + taskId + " executed by " +
                        Thread.currentThread().getName());
                try { Thread.sleep(500); } catch (InterruptedException e) { }
            });
        }

        executor.shutdown();
    }
}
```

✅ Use case: Short-lived asynchronous tasks, like handling HTTP requests.

---

## 3.6 ScheduledThreadPool

### Concept

- Executes tasks **after a delay** or **periodically**.
    
- Useful for cron jobs, monitoring, background scheduling.
    

### Characteristics

- **Thread count**: Fixed.
    
- Supports `schedule()`, `scheduleAtFixedRate()`, `scheduleWithFixedDelay()`.
    

### Example

```java
import java.util.concurrent.*;

public class ScheduledThreadPoolExample {
    public static void main(String[] args) {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);

        // Run after 2 seconds
        scheduler.schedule(() ->
            System.out.println("Task executed after 2s delay"), 2, TimeUnit.SECONDS);

        // Run every 3 seconds, starting after 1 second
        scheduler.scheduleAtFixedRate(() ->
            System.out.println("Repeating task"), 1, 3, TimeUnit.SECONDS);

        // Run with 5s delay after previous task finishes
        scheduler.scheduleWithFixedDelay(() ->
            System.out.println("Delayed repeating task"), 1, 5, TimeUnit.SECONDS);
    }
}
```

✅ Use case: Sending reminders, scheduled reports, health checks.

---

## 3.7 WorkStealingPool (Java 8+)

### Concept

- Uses the **ForkJoinPool** internally.
    
- Each worker thread maintains its own queue.
    
- Idle threads “steal” work from others, improving efficiency.
    

### Characteristics

- **Thread count**: Based on available processors.
    
- Balances load automatically.
    

### Example

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class WorkStealingExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newWorkStealingPool();

        for (int i = 1; i <= 10; i++) {
            final int taskId = i;
            executor.submit(() -> {
                System.out.println("Task " + taskId + " executed by " +
                        Thread.currentThread().getName());
                try { Thread.sleep(1000); } catch (InterruptedException e) { }
            });
        }
    }
}
```

✅ Use case: Parallel stream processing, CPU-intensive tasks.

---

## 3.8 Custom ThreadPoolExecutor

### Concept

- The most **flexible and configurable** option.
    
- You define:
    
    - Core threads
        
    - Maximum threads
        
    - Queue type
        
    - Rejection policy
        

### Example

```java
import java.util.concurrent.*;

public class CustomThreadPoolExample {
    public static void main(String[] args) {
        ThreadPoolExecutor executor = new ThreadPoolExecutor(
                2, 4, 60, TimeUnit.SECONDS,
                new LinkedBlockingQueue<>(2),
                Executors.defaultThreadFactory(),
                new ThreadPoolExecutor.CallerRunsPolicy()
        );

        for (int i = 1; i <= 10; i++) {
            final int taskId = i;
            executor.submit(() -> {
                System.out.println("Task " + taskId + " executed by " +
                        Thread.currentThread().getName());
                try { Thread.sleep(2000); } catch (InterruptedException e) { }
            });
        }

        executor.shutdown();
    }
}
```

✅ Use case: High-load enterprise systems with fine-grained control.

---

## 3.9 Summary

- **SingleThreadExecutor** → Sequential execution.
    
- **FixedThreadPool** → Fixed number of workers.
    
- **CachedThreadPool** → Dynamic scaling.
    
- **ScheduledThreadPool** → Delayed/periodic tasks.
    
- **WorkStealingPool** → Parallelism with load balancing.
    
- **Custom ThreadPoolExecutor** → Full control (production-level tuning).
    