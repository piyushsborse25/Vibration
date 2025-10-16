### ✅ **AtomicInteger Example**

#### 🧠 Scenario:

A **counter for website visits** where multiple users increment the count concurrently.

- `AtomicInteger` ensures **thread-safe increments** without explicit synchronization.
    

---

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicIntegerExample {
    public static void main(String[] args) {
        AtomicInteger visitCounter = new AtomicInteger(0);

        Runnable userVisit = () -> {
            for (int i = 0; i < 5; i++) {
                int count = visitCounter.incrementAndGet(); // atomic increment
                System.out.println(Thread.currentThread().getName() + " visited. Total visits: " + count);
                try {
                    Thread.sleep(200); // simulate delay between visits
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        };

        Thread t1 = new Thread(userVisit, "User-1");
        Thread t2 = new Thread(userVisit, "User-2");

        t1.start();
        t2.start();
    }
}
```

---

### 🧾 **Sample Output (Typical)**

```
User-1 visited. Total visits: 1
User-2 visited. Total visits: 2
User-1 visited. Total visits: 3
User-2 visited. Total visits: 4
...
User-2 visited. Total visits: 10
```

---

### 🧠 **Key Points**

- `AtomicInteger` supports **atomic operations** like `incrementAndGet()`.
    
- No `synchronized` blocks needed for thread-safe counters.
    
- Useful for **shared counters**, **sequence numbers**, or **metrics tracking**.
    