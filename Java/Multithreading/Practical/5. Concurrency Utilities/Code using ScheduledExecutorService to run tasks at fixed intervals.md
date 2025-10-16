### ✅ **ScheduledExecutorService Example**

#### 🧠 Scenario:

A **newsletter service** sends emails to subscribers **every 2 seconds**.

---

```java
import java.util.concurrent.*;

public class ScheduledExecutorExample {
    public static void main(String[] args) {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

        Runnable emailTask = () -> {
            System.out.println("Sending newsletter at " + System.currentTimeMillis() / 1000);
        };

        // Schedule task to run every 2 seconds after initial delay of 1 second
        scheduler.scheduleAtFixedRate(emailTask, 1, 2, TimeUnit.SECONDS);

        // Let it run for 10 seconds for demo
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        scheduler.shutdown();
        System.out.println("Scheduler stopped.");
    }
}
```

---

### 🧾 **Sample Output**

```
Sending newsletter at 1697445001
Sending newsletter at 1697445003
Sending newsletter at 1697445005
Sending newsletter at 1697445007
Sending newsletter at 1697445009
Scheduler stopped.
```

---

### 🧠 **Key Points**

- `scheduleAtFixedRate()` → executes task **at fixed intervals**, regardless of task execution time.
    
- `scheduleWithFixedDelay()` → executes task **after a fixed delay** from the end of the previous execution.
    
- Ideal for **periodic tasks** like polling, monitoring, or sending notifications.
    