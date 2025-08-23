Up until now, we’ve seen how tasks are submitted and executed using various thread pools. But in **real-world concurrent applications**, problems arise when multiple tasks **access shared data**. This chapter focuses on **thread safety, synchronization, and strategies to avoid concurrency bugs**.

---

## 8.1 What is Thread Safety?

A piece of code is **thread-safe** if it **behaves correctly** when accessed by multiple threads **simultaneously**.

- Correct behavior → no race conditions, no data corruption, predictable output.
    
- Non-thread-safe code can lead to:
    
    - **Race conditions**
        
    - **Deadlocks**
        
    - **Visibility issues** (stale data due to caching in CPU cores)
        
    - **Inconsistent states**
        

---

## 8.2 Common Problems with Shared State

### 1. **Race Condition**

When two or more threads try to update a shared resource simultaneously, and the final result depends on the timing of execution.

Example (NOT thread-safe):

```java
class Counter {
    private int count = 0;

    public void increment() {
        count++; // Race condition here
    }

    public int getCount() {
        return count;
    }
}

public class RaceConditionExample {
    public static void main(String[] args) throws InterruptedException {
        Counter counter = new Counter();
        ExecutorService executor = Executors.newFixedThreadPool(10);

        for (int i = 0; i < 1000; i++) {
            executor.submit(counter::increment);
        }

        executor.shutdown();
        executor.awaitTermination(1, TimeUnit.SECONDS);

        System.out.println("Final count: " + counter.getCount());
    }
}
```

⚠ Expected output = `1000`, but you may see `987`, `994`, etc. → because multiple threads modify `count` at the same time.

---

### 2. **Visibility Issue**

Without proper synchronization, changes made by one thread may **not be visible** to another.

```java
class Flag {
    private boolean running = true;

    public void stop() {
        running = false; // Another thread may not see this change immediately
    }

    public void run() {
        while (running) {
            // busy work
        }
    }
}
```

⚠ Without synchronization, the `while` loop may **never exit**, because the thread keeps reading a stale value of `running`.

---

### 3. **Deadlocks**

Two or more threads wait forever for locks held by each other.

```java
class DeadlockExample {
    private final Object lock1 = new Object();
    private final Object lock2 = new Object();

    public void task1() {
        synchronized (lock1) {
            System.out.println("Task1 got lock1");
            synchronized (lock2) {
                System.out.println("Task1 got lock2");
            }
        }
    }

    public void task2() {
        synchronized (lock2) {
            System.out.println("Task2 got lock2");
            synchronized (lock1) {
                System.out.println("Task2 got lock1");
            }
        }
    }
}
```

⚠ `task1()` and `task2()` may deadlock if both are called concurrently.

---

## 8.3 Making ExecutorService Tasks Thread-Safe

### 1. Use `synchronized` blocks/methods

```java
class SafeCounter {
    private int count = 0;

    public synchronized void increment() {
        count++;
    }

    public synchronized int getCount() {
        return count;
    }
}
```

✅ Prevents race condition, but reduces concurrency (threads block each other).

---

### 2. Use **Atomic Variables**

```java
class AtomicCounter {
    private final AtomicInteger count = new AtomicInteger();

    public void increment() {
        count.incrementAndGet();
    }

    public int getCount() {
        return count.get();
    }
}
```

✅ Lock-free, more performant than `synchronized`.

---

### 3. Use **Concurrent Collections**

Instead of:

```java
Map<String, String> map = new HashMap<>();
```

Use:

```java
Map<String, String> map = new ConcurrentHashMap<>();
```

✅ Thread-safe, high-performance, avoids manual synchronization.

---

### 4. Use **Volatile for Visibility**

```java
class VolatileFlag {
    private volatile boolean running = true;

    public void stop() {
        running = false; // visible immediately to other threads
    }

    public void run() {
        while (running) {
            // loop will exit when running becomes false
        }
    }
}
```

✅ Fixes stale data issue, but **doesn’t solve atomicity problems**.

---

### 5. Avoiding Deadlocks

- Always acquire locks in a **consistent global order**.
    
- Use **tryLock** with timeout (from `ReentrantLock`).
    
- Use higher-level concurrency utilities (`ExecutorService`, `ConcurrentHashMap`, etc.) instead of manual locks whenever possible.
    

---

## 8.4 Practical Example: Thread-Safe Banking System

```java
class BankAccount {
    private final AtomicInteger balance = new AtomicInteger(1000);

    public void deposit(int amount) {
        balance.addAndGet(amount);
    }

    public void withdraw(int amount) {
        balance.addAndGet(-amount);
    }

    public int getBalance() {
        return balance.get();
    }
}

public class BankSystem {
    public static void main(String[] args) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(5);
        BankAccount account = new BankAccount();

        for (int i = 0; i < 10; i++) {
            executor.submit(() -> account.deposit(100));
            executor.submit(() -> account.withdraw(50));
        }

        executor.shutdown();
        executor.awaitTermination(1, TimeUnit.SECONDS);

        System.out.println("Final balance: " + account.getBalance());
    }
}
```

✅ Output is **always consistent** (balance ≥ 1000).

---

## 8.5 Key Takeaways

- **Thread safety is critical** when multiple tasks in ExecutorService share state.
    
- Use `synchronized`, `volatile`, `Atomic` classes, or `Concurrent` collections.
    
- Avoid deadlocks via ordering or non-blocking algorithms.
    
- Strive for **immutability** when possible – immutable objects are inherently thread-safe.
    