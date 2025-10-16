### ✅ **Thread Starvation Example**

#### 🧠 Scenario:

A high-priority thread keeps taking the CPU, while low-priority threads rarely get a chance to run.  
Imagine a **priority printer queue** where urgent jobs starve smaller jobs.

---

```java
public class StarvationExample {
    public static void main(String[] args) {
        Object lock = new Object();

        // Low-priority threads (many small jobs)
        for (int i = 1; i <= 3; i++) {
            Thread low = new Thread(() -> {
                while (true) {
                    synchronized (lock) {
                        System.out.println(Thread.currentThread().getName() + " printing small job...");
                        try { Thread.sleep(200); } catch (InterruptedException ignored) {}
                    }
                }
            }, "Low-" + i);
            low.setPriority(Thread.MIN_PRIORITY);
            low.start();
        }

        // High-priority thread (urgent job)
        Thread high = new Thread(() -> {
            while (true) {
                synchronized (lock) {
                    System.out.println(Thread.currentThread().getName() + " printing urgent job!");
                    try { Thread.sleep(200); } catch (InterruptedException ignored) {}
                }
            }
        }, "High");
        high.setPriority(Thread.MAX_PRIORITY);
        high.start();
    }
}
```

---

### 🧾 **Sample Output (Typical Starvation)**

```
High printing urgent job!
High printing urgent job!
High printing urgent job!
Low-1 printing small job...  // very rarely appears
High printing urgent job!
High printing urgent job!
Low-2 printing small job...  // almost starved
...
```

---

### 🧠 **Key Points**

- High-priority threads can **dominate CPU**, causing low-priority threads to **starve**.
    
- Starvation happens even if threads are runnable — they **rarely get scheduled**.
    
- Solutions: use fair locks (`ReentrantLock(true)`), thread yield, or proper task scheduling.
    