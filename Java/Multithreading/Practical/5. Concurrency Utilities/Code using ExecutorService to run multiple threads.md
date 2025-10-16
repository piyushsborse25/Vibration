### ✅ **ExecutorService Example**

#### 🧠 Scenario:

A **restaurant kitchen** has multiple chefs preparing dishes **concurrently** using a thread pool.

---

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class ChefTask implements Runnable {
    private final String dishName;

    public ChefTask(String dishName) {
        this.dishName = dishName;
    }

    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName() + " started preparing " + dishName);
        try {
            Thread.sleep(2000); // simulate cooking time
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(Thread.currentThread().getName() + " finished preparing " + dishName);
    }
}

public class ExecutorServiceExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(3); // 3 chefs

        String[] dishes = {"Pasta", "Pizza", "Burger", "Salad", "Soup"};

        for (String dish : dishes) {
            executor.submit(new ChefTask(dish));
        }

        executor.shutdown(); // no more tasks accepted
    }
}
```

---

### 🧾 **Sample Output (Typical)**

```
pool-1-thread-1 started preparing Pasta
pool-1-thread-2 started preparing Pizza
pool-1-thread-3 started preparing Burger
pool-1-thread-1 finished preparing Pasta
pool-1-thread-1 started preparing Salad
pool-1-thread-2 finished preparing Pizza
pool-1-thread-2 started preparing Soup
pool-1-thread-3 finished preparing Burger
pool-1-thread-1 finished preparing Salad
pool-1-thread-2 finished preparing Soup
```

---

### 🧠 **Key Points**

- `ExecutorService` manages a **thread pool**.
    
- Submit multiple tasks without creating threads manually.
    
- `shutdown()` stops accepting new tasks but completes existing ones.
    