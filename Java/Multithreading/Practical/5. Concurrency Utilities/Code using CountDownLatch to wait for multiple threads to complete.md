### ✅ **CountDownLatch Example**

#### 🧠 Scenario:

A **rocket launch** where multiple **pre-launch checks** must complete before launch.

- Countdown starts at the number of checks.
    
- Rocket waits until all checks are done.
    

---

```java
import java.util.concurrent.CountDownLatch;

class CheckTask implements Runnable {
    private final String name;
    private final CountDownLatch latch;

    public CheckTask(String name, CountDownLatch latch) {
        this.name = name;
        this.latch = latch;
    }

    @Override
    public void run() {
        System.out.println(name + " started.");
        try {
            Thread.sleep((long)(Math.random() * 2000)); // simulate check duration
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(name + " completed.");
        latch.countDown(); // decrement latch
    }
}

public class CountDownLatchExample {
    public static void main(String[] args) throws InterruptedException {
        int numChecks = 3;
        CountDownLatch latch = new CountDownLatch(numChecks);

        Thread t1 = new Thread(new CheckTask("Fuel Check", latch));
        Thread t2 = new Thread(new CheckTask("Engine Check", latch));
        Thread t3 = new Thread(new CheckTask("Navigation Check", latch));

        t1.start(); t2.start(); t3.start();

        System.out.println("Rocket waiting for all pre-launch checks...");
        latch.await(); // wait until count reaches 0

        System.out.println("All checks completed. 🚀 Rocket launched!");
    }
}
```

---

### 🧾 **Sample Output**

```
Rocket waiting for all pre-launch checks...
Fuel Check started.
Engine Check started.
Navigation Check started.
Fuel Check completed.
Navigation Check completed.
Engine Check completed.
All checks completed. 🚀 Rocket launched!
```

---

### 🧠 **Key Points**

- `CountDownLatch` is a **one-time-use synchronization aid**.
    
- Threads can **wait** for a set of operations to complete using `await()`.
    
- Each task calls `countDown()` to decrement the latch.
    