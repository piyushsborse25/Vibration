### ✅ **Producer-Consumer Problem**

#### 🧠 Scenario:

A bakery where a **baker (producer)** bakes cakes, and **customers (consumers)** take cakes.

- The bakery can hold only **one cake at a time** (shared resource).
    

---

```java
class Bakery {
    private String cake;
    private boolean cakeAvailable = false;

    // Producer method
    public synchronized void bake(String cakeName) {
        while (cakeAvailable) { // wait if cake is not yet consumed
            try { wait(); } catch (InterruptedException e) { e.printStackTrace(); }
        }
        this.cake = cakeName;
        System.out.println("Baker baked: " + cake);
        cakeAvailable = true;
        notify(); // notify consumer
    }

    // Consumer method
    public synchronized void eat() {
        while (!cakeAvailable) { // wait if no cake available
            try { wait(); } catch (InterruptedException e) { e.printStackTrace(); }
        }
        System.out.println("Customer ate: " + cake);
        cakeAvailable = false;
        notify(); // notify producer
    }
}

public class ProducerConsumerExample {
    public static void main(String[] args) {
        Bakery bakery = new Bakery();

        Thread baker = new Thread(() -> {
            String[] cakes = {"Chocolate", "Vanilla", "Strawberry"};
            for (String c : cakes) bakery.bake(c);
        });

        Thread customer = new Thread(() -> {
            for (int i = 0; i < 3; i++) bakery.eat();
        });

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

- `wait()` → thread waits and releases lock until notified.
    
- `notify()` → wakes up **one waiting thread**.
    
- Proper synchronization is required to **avoid missed signals** and ensure alternating production/consumption.
    