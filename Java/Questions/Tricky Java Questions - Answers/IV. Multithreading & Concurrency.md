### **44. What is the difference between a `synchronized` block and a `synchronized` method? Which is more efficient?**

- **Synchronized Method:**
    
    - Locks the **entire method**.
        
    - Lock is acquired on the **current object** (`this`) for instance methods or on the **class object** for static methods.
        
    - Example:
        
        ```java
        synchronized void increment() {
            count++;
        }
        ```
        
- **Synchronized Block:**
    
    - Locks only a **specific section** of code using a chosen **lock object**.
        
    - Offers **finer control** and reduces contention.
        
    - Example:
        
        ```java
        void increment() {
            synchronized (this) {
                count++;
            }
        }
        ```
        
- **Efficiency:**  
    A **synchronized block** is generally more efficient since it synchronizes only the required portion of code.
    

---

### **45. How does the `volatile` keyword ensure thread safety? Does it guarantee atomicity?**

- The `volatile` keyword ensures **visibility**, not **atomicity**.
    
- It guarantees that a variable is always **read and written directly from main memory**, avoiding thread-local caching.
    
- Example:
    
    ```java
    volatile boolean flag = true;
    ```
    
- When one thread updates `flag`, the change becomes **immediately visible** to others.
    
- However, operations like `count++` are **not atomic** — they involve multiple steps (read → modify → write).
    
- For atomicity, use **`AtomicInteger`** or **synchronized blocks**.
    

---

### **46. Explain the difference between `wait()`, `notify()`, and `notifyAll()`. Why are they part of `Object` and not `Thread`?**

- **`wait()`** → Puts the current thread in a **waiting state** and **releases the object’s monitor** until notified.
    
- **`notify()`** → Wakes up **one waiting thread** on the same object’s monitor.
    
- **`notifyAll()`** → Wakes up **all waiting threads** on the same monitor; they compete for the lock.
    
- **Why in `Object` and not `Thread`:**
    
    - Because threads **synchronize on objects**, not on other threads.
        
    - Every object can serve as a **monitor**, hence these methods belong to `Object`.
        

Example:

```java
synchronized (shared) {
    while (!condition) {
        shared.wait();
    }
    shared.notifyAll();
}
```

---

### **47. What is a "race condition"? How can it be avoided in Java?**

- A **race condition** occurs when multiple threads access shared data simultaneously, and the **final result depends on timing**.
    
- Example:
    
    ```java
    class Counter {
        int count = 0;
        void increment() { count++; } // Not thread-safe
    }
    ```
    
- **Avoidance:**
    
    - Use **`synchronized`** methods or blocks.
        
    - Use **`AtomicInteger`** for atomic updates.
        
    - Use **`Lock`** objects.
        
    - Use **concurrent collections** like `ConcurrentHashMap`.
        

---

### **48. Can a `Thread` start twice? What happens if you call `start()` on a thread that has already started?**

- A thread can **only be started once**.
    
- If `start()` is called on a thread that has already been started or terminated, it throws an **`IllegalThreadStateException`**.
    
- Example:
    
    ```java
    Thread t = new Thread();
    t.start();
    t.start(); // ❌ Exception thrown
    ```
    

---

### **49. How does the Java Memory Model (JMM) ensure visibility and ordering of shared variables?**

- **JMM** defines how threads interact through memory and ensures **visibility** and **ordering** of operations.
    
- The **“happens-before”** relationship ensures:
    
    - If one action happens-before another, then the first is visible and ordered before the second.
        
- **Visibility is ensured by:**
    
    - `synchronized` blocks (monitor enter/exit).
        
    - `volatile` variables.
        
    - Thread start/join.
        
- Example:
    
    ```java
    synchronized void write() { x = 1; }
    synchronized void read() { System.out.println(x); }
    ```
    

---

### **50. What are the differences between `synchronized` and `Lock` from `java.util.concurrent.locks`?**

|Feature|`synchronized`|`Lock`|
|---|---|---|
|Type|Keyword|Interface|
|Reentrancy|Yes|Yes (ReentrantLock)|
|Fairness|Not configurable|Can be fair/unfair|
|Try lock|No|Yes (`tryLock()`)|
|Interruptible|No|Yes (`lockInterruptibly()`)|
|Release|Automatic on exit|Must release manually|
|Performance|Easier, less flexible|More flexible and scalable|

Example:

```java
Lock lock = new ReentrantLock();
lock.lock();
try {
    // critical section
} finally {
    lock.unlock();
}
```

---

### **51. Explain the difference between `Thread.yield()`, `Thread.sleep()`, and `Thread.join()`.**

- **`yield()`** → Suggests to the scheduler to give other threads a chance to execute. No guarantee of suspension.
    
- **`sleep(ms)`** → Pauses the current thread for a specific time. Thread remains **alive but not runnable**.
    
- **`join()`** → Causes the calling thread to **wait** until the specified thread completes execution.
    

Example:

```java
t1.start();
t1.join(); // main waits for t1 to finish
```

---

### **52. What happens if a thread calls `wait()` on an object without holding the lock?**

- It throws an **`IllegalMonitorStateException`**.
    
- `wait()`, `notify()`, and `notifyAll()` must be called **inside a synchronized block** that locks the same object.
    
- Example:
    
    ```java
    obj.wait(); // ❌ Throws exception if not synchronized on obj
    ```
    

---

### **53. Can `volatile` variables guarantee thread safety for increment operations? Why or why not?**

- **No**, because increment (`count++`) is a **non-atomic** operation involving:
    
    - Read → Increment → Write.
        
- Two threads might read the same value before writing, leading to data loss.
    
- To ensure thread safety:
    
    - Use `AtomicInteger`, or
        
    - Use synchronization.  
        Example:
        

```java
AtomicInteger count = new AtomicInteger(0);
count.incrementAndGet(); // ✅ Atomic
```

---

### **54. Can a thread acquire multiple locks at the same time? What problems can this lead to?**

- Yes, threads can hold multiple locks simultaneously:
    
    ```java
    synchronized (lock1) {
        synchronized (lock2) {
            // Critical section
        }
    }
    ```
    
- This can lead to **deadlocks** when two threads lock resources in reverse order.
    
    - Thread 1 → locks A, waits for B
        
    - Thread 2 → locks B, waits for A  
        → Both block each other forever.
        

---

### **55. What is the difference between a live lock and a deadlock? Provide examples.**

- **Deadlock:**  
    Threads are **blocked**, each waiting for the other to release locks.  
    Example:
    
    ```java
    // Thread 1: lock(A) then wait(B)
    // Thread 2: lock(B) then wait(A)
    ```
    
- **Livelock:**  
    Threads are **active but not progressing**, repeatedly responding to each other.  
    Example:
    
    ```java
    // Both threads keep releasing and retrying locks endlessly.
    ```
    

**Key Difference:**

- Deadlock → Threads are **stuck**.
    
- Livelock → Threads are **spinning without progress**.
    

---

### **56. Can you implement a thread-safe singleton without using `synchronized`? If so, how?**

Yes — using the **Bill Pugh Singleton Pattern** (Inner Static Class approach):

```java
class Singleton {
    private Singleton() {}

    private static class Holder {
        private static final Singleton INSTANCE = new Singleton();
    }

    public static Singleton getInstance() {
        return Holder.INSTANCE;
    }
}
```

- The instance is created **only when needed**.
    
- Thread-safe due to **class loading mechanism**, no explicit synchronization required.
    

---

### **57. What is the difference between `ThreadLocalRandom` and `Random`?**

|Aspect|`Random`|`ThreadLocalRandom`|
|---|---|---|
|Thread safety|Shared instance (synchronized)|Each thread has its own instance|
|Performance|Slower due to contention|Faster, no contention|
|Use case|Single-threaded|Multi-threaded applications|

Example:

```java
int num = ThreadLocalRandom.current().nextInt(1, 10);
```

---

### **58. Explain the difference between `AtomicInteger` and using `synchronized` for increment operations.**

|Feature|`AtomicInteger`|`synchronized`|
|---|---|---|
|Mechanism|Lock-free (CAS)|Monitor-based (blocking)|
|Performance|Faster, non-blocking|Slower under contention|
|Overhead|Low|Higher|
|Fairness|Not guaranteed|Depends on JVM monitor behavior|

Example:

```java
AtomicInteger counter = new AtomicInteger();
counter.incrementAndGet(); // ✅ Atomic, non-blocking
```

---

### **59. What is the difference between `Object`'s `wait()` method and `Thread.sleep()`?**

|Aspect|`wait()`|`sleep()`|
|---|---|---|
|Class|`Object`|`Thread`|
|Requires lock|Yes|No|
|Releases lock|Yes|No|
|Wakes up by|`notify()` / `notifyAll()`|Timeout or interrupt|
|Purpose|Inter-thread communication|Timed delay|

Example:

```java
synchronized (obj) {
    obj.wait(); // releases the lock
}
Thread.sleep(1000); // holds lock if inside synchronized block
```
