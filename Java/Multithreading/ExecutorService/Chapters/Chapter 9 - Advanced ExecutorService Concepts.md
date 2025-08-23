## 9.1 ThreadFactory – Custom Thread Creation

By default, executors create threads with generic names like `pool-1-thread-1`.  
But in **real-world applications**, you may want:

- Meaningful thread names for logging/debugging.
    
- Setting thread **priority** (e.g., background vs. high-priority).
    
- Deciding whether threads are **daemon** or **non-daemon**.
    

👉 Example: Custom Thread Naming

```java
import java.util.concurrent.*;

public class CustomThreadFactoryExample {
    public static void main(String[] args) {
        ThreadFactory namedThreadFactory = runnable -> {
            Thread t = new Thread(runnable);
            t.setName("Worker-" + t.getId());
            t.setDaemon(false);
            return t;
        };

        ExecutorService executor = Executors.newFixedThreadPool(2, namedThreadFactory);

        for (int i = 0; i < 4; i++) {
            executor.submit(() -> {
                System.out.println("Running in: " + Thread.currentThread().getName());
            });
        }

        executor.shutdown();
    }
}
```

✅ Output:

```
Running in: Worker-12  
Running in: Worker-13  
Running in: Worker-12  
Running in: Worker-13  
```

---

## 9.2 RejectedExecutionHandler – Handling Rejected Tasks

When the **task queue is full** and no more threads are available, tasks can’t be accepted.  
The **RejectedExecutionHandler** decides what happens next.

Common handlers:

- `AbortPolicy` (default) → throws `RejectedExecutionException`.
    
- `DiscardPolicy` → silently discards the task.
    
- `DiscardOldestPolicy` → discards oldest task in queue, adds new one.
    
- `CallerRunsPolicy` → runs the task in the calling thread.
    

👉 Example:

```java
import java.util.concurrent.*;

public class RejectionHandlerExample {
    public static void main(String[] args) {
        RejectedExecutionHandler handler = (r, executor) -> {
            System.out.println("Task rejected: " + r.toString());
        };

        ThreadPoolExecutor executor = new ThreadPoolExecutor(
                1, // core pool
                1, // max pool
                0L, TimeUnit.MILLISECONDS,
                new ArrayBlockingQueue<>(1), // queue size = 1
                handler // custom rejection
        );

        executor.execute(() -> sleepTask("Task 1"));
        executor.execute(() -> sleepTask("Task 2"));
        executor.execute(() -> sleepTask("Task 3")); // will be rejected

        executor.shutdown();
    }

    private static void sleepTask(String name) {
        System.out.println(name + " started");
        try { Thread.sleep(2000); } catch (InterruptedException ignored) {}
        System.out.println(name + " finished");
    }
}
```

✅ Output:

```
Task 1 started
Task 2 started
Task rejected: java.util.concurrent.FutureTask@...
```

---

## 9.3 Work-Stealing Pool

Java 8 introduced **work-stealing pools** with `Executors.newWorkStealingPool()`.

- Designed for **parallelism** on multi-core systems.
    
- Uses a **ForkJoinPool** internally.
    
- Tasks can "steal" work from other queues to avoid idle threads.
    

👉 Example:

```java
import java.util.concurrent.*;

public class WorkStealingExample {
    public static void main(String[] args) throws InterruptedException {
        ExecutorService workStealingPool = Executors.newWorkStealingPool();

        for (int i = 0; i < 10; i++) {
            int taskId = i;
            workStealingPool.submit(() -> {
                System.out.println("Task " + taskId + " running in " + Thread.currentThread().getName());
                try { Thread.sleep(1000); } catch (InterruptedException ignored) {}
            });
        }

        Thread.sleep(4000); // wait for tasks to finish
    }
}
```

---

## 9.4 Priority-Based Task Execution

By default, executors use **FIFO** queues.  
But with **PriorityBlockingQueue**, you can define custom priority rules.

👉 Example:

```java
import java.util.concurrent.*;

public class PriorityExecutorExample {
    public static void main(String[] args) {
        ExecutorService executor = new ThreadPoolExecutor(
                2, 2,
                0L, TimeUnit.MILLISECONDS,
                new PriorityBlockingQueue<>()
        );

        executor.execute(new PriorityTask(3));
        executor.execute(new PriorityTask(1));
        executor.execute(new PriorityTask(2));

        executor.shutdown();
    }

    static class PriorityTask implements Runnable, Comparable<PriorityTask> {
        private final int priority;

        PriorityTask(int priority) {
            this.priority = priority;
        }

        @Override
        public void run() {
            System.out.println("Executing task with priority: " + priority);
        }

        @Override
        public int compareTo(PriorityTask o) {
            return Integer.compare(o.priority, this.priority); // higher first
        }
    }
}
```

✅ Output (priority order):

```
Executing task with priority: 3  
Executing task with priority: 2  
Executing task with priority: 1  
```

---

## 9.5 Monitoring and Tuning Executors

Executors are **not fire-and-forget** — you must monitor them to avoid:

- Thread starvation.
    
- Queue overload.
    
- Memory leaks.
    

### Useful metrics from `ThreadPoolExecutor`:

```java
ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(3);

executor.submit(() -> {
    System.out.println("Task running...");
});

System.out.println("Pool size: " + executor.getPoolSize());
System.out.println("Active threads: " + executor.getActiveCount());
System.out.println("Completed tasks: " + executor.getCompletedTaskCount());
System.out.println("Queued tasks: " + executor.getQueue().size());

executor.shutdown();
```

---

## 9.6 ScheduledExecutorService

For **delayed or periodic tasks**, use `ScheduledExecutorService`.  
Unlike `Timer`, it:

- Handles multiple threads.
    
- Avoids `Timer`’s single-thread limitation.
    
- Recovers from task exceptions.
    

👉 Example: Periodic Task

```java
import java.util.concurrent.*;

public class ScheduledExample {
    public static void main(String[] args) throws InterruptedException {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);

        scheduler.scheduleAtFixedRate(() -> {
            System.out.println("Running at: " + System.currentTimeMillis());
        }, 1, 2, TimeUnit.SECONDS);

        Thread.sleep(7000);
        scheduler.shutdown();
    }
}
```

✅ Runs every **2 seconds** after initial 1-second delay.

---

## 9.7 ForkJoinPool – Special Executor

- Designed for **divide-and-conquer tasks**.
    
- Splits tasks into smaller subtasks (recursive parallelism).
    
- Used by parallel streams internally.
    

👉 Example:

```java
import java.util.concurrent.*;

public class ForkJoinExample extends RecursiveTask<Integer> {
    private final int start, end;

    ForkJoinExample(int start, int end) {
        this.start = start;
        this.end = end;
    }

    @Override
    protected Integer compute() {
        if (end - start <= 5) {
            int sum = 0;
            for (int i = start; i <= end; i++) sum += i;
            return sum;
        } else {
            int mid = (start + end) / 2;
            ForkJoinExample left = new ForkJoinExample(start, mid);
            ForkJoinExample right = new ForkJoinExample(mid + 1, end);

            left.fork();
            return right.compute() + left.join();
        }
    }

    public static void main(String[] args) {
        ForkJoinPool pool = new ForkJoinPool();
        int result = pool.invoke(new ForkJoinExample(1, 20));
        System.out.println("Sum: " + result);
    }
}
```

✅ Output:

```
Sum: 210
```

---

# 🔑 Key Takeaways

- **ThreadFactory** → customize thread creation (names, daemon, priority).
    
- **RejectedExecutionHandler** → handle overload gracefully.
    
- **WorkStealingPool** → optimal for parallel, independent tasks.
    
- **PriorityBlockingQueue** → enable priority task execution.
    
- **ScheduledExecutorService** → periodic/delayed jobs.
    
- **ForkJoinPool** → divide-and-conquer parallelism.
    
- **Monitoring** → always measure pool size, queue depth, and active threads.
    