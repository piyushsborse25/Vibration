 ✅ **ReentrantLock with tryLock() Example**

#### 🧠 Scenario:

Two employees try to access a **shared printer**.  
We use `tryLock()` so that if the printer is **busy**, a thread won’t block — it will just skip or retry later.

---

```java
import java.util.concurrent.locks.ReentrantLock;

public class ReentrantLockExample {
    private static final ReentrantLock printerLock = new ReentrantLock();

    public static void main(String[] args) {
        Runnable printTask = () -> {
            String name = Thread.currentThread().getName();
            System.out.println(name + " trying to access the printer...");

            if (printerLock.tryLock()) { // try to get the lock
                try {
                    System.out.println(name + " got the printer access.");
                    Thread.sleep(2000); // simulate printing time
                    System.out.println(name + " finished printing.");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    printerLock.unlock();
                }
            } else {
                System.out.println(name + " couldn't get the printer. Will try later.");
            }
        };

        Thread emp1 = new Thread(printTask, "Employee-1");
        Thread emp2 = new Thread(printTask, "Employee-2");
        Thread emp3 = new Thread(printTask, "Employee-3");

        emp1.start();
        emp2.start();
        emp3.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Employee-1 trying to access the printer...
Employee-2 trying to access the printer...
Employee-3 trying to access the printer...
Employee-1 got the printer access.
Employee-2 couldn't get the printer. Will try later.
Employee-3 couldn't get the printer. Will try later.
Employee-1 finished printing.
```

---

### 🧠 **Key Points**

- `tryLock()` → **non-blocking**; returns `false` if lock not available.
    
- Prevents **deadlock** or **long waits**.
    
- Useful when a thread can skip or defer work instead of waiting forever.
    