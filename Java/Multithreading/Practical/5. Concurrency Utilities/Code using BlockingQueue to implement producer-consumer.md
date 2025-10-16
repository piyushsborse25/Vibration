### ✅ **BlockingQueue Example**

#### 🧠 Scenario:

A **bakery** with **multiple bakers (producers)** and **multiple customers (consumers)**.

- `BlockingQueue` ensures **thread-safe production and consumption** without explicit `wait()`/`notify()`.
    

---

```java
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

class Baker implements Runnable {
    private final BlockingQueue<String> queue;

    public Baker(BlockingQueue<String> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        String[] cakes = {"Chocolate", "Vanilla", "Strawberry"};
        for (String cake : cakes) {
            try {
                queue.put(cake); // blocks if queue full
                System.out.println(Thread.currentThread().getName() + " baked: " + cake);
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

class Customer implements Runnable {
    private final BlockingQueue<String> queue;

    public Customer(BlockingQueue<String> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        for (int i = 0; i < 3; i++) {
            try {
                String cake = queue.take(); // blocks if queue empty
                System.out.println(Thread.currentThread().getName() + " ate: " + cake);
                Thread.sleep(700);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class BlockingQueueExample {
    public static void main(String[] args) {
        BlockingQueue<String> bakeryQueue = new ArrayBlockingQueue<>(2); // max 2 cakes at a time

        Thread baker = new Thread(new Baker(bakeryQueue), "Baker");
        Thread customer = new Thread(new Customer(bakeryQueue), "Customer");

        baker.start();
        customer.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Baker baked: Chocolate
Customer ate: Chocolate
Baker baked: Vanilla
Customer ate: Vanilla
Baker baked: Strawberry
Customer ate: Strawberry
```

---

### 🧠 **Key Points**

- `BlockingQueue.put()` → blocks if queue full.
    
- `BlockingQueue.take()` → blocks if queue empty.
    
- Eliminates need for explicit `wait()`/`notify()`.
    
- Perfect for **multi-producer, multi-consumer** scenarios.
    