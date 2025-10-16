### **Thread Creation Using Callable and Future**

#### 🧠 Real-life Scenario:

You submit an order for processing, and the system processes it in a separate thread, then returns an **order confirmation ID** once done.

---

```java
import java.util.concurrent.*;

class OrderProcessor implements Callable<String> {
    private final String orderId;

    public OrderProcessor(String orderId) {
        this.orderId = orderId;
    }

    @Override
    public String call() throws Exception {
        System.out.println("Processing order: " + orderId + " by " + Thread.currentThread().getName());
        Thread.sleep(2000); // Simulate time-consuming processing
        return "Order " + orderId + " confirmed ✅";
    }
}

public class CallableFutureExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(2);

        Future<String> result1 = executor.submit(new OrderProcessor("ORD101"));
        Future<String> result2 = executor.submit(new OrderProcessor("ORD102"));

        // Simulate doing other tasks while orders are being processed
        System.out.println("Main thread doing other work...");

        // Get results (blocking until available)
        System.out.println(result1.get());
        System.out.println(result2.get());

        executor.shutdown();
    }
}
```

---

#### **Output (Sample)**

```
Processing order: ORD101 by pool-1-thread-1
Processing order: ORD102 by pool-1-thread-2
Main thread doing other work...
Order ORD101 confirmed ✅
Order ORD102 confirmed ✅
```
