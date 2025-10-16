### ✅ **Thread Creation by Implementing `Runnable`**

#### 🧠 Scenario:

Each chef (thread) prepares a dish. Instead of extending `Thread`, we implement `Runnable`.

---

```java
class ChefTask implements Runnable {
    private final String dishName;

    public ChefTask(String dishName) {
        this.dishName = dishName;
    }

    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName() + " started preparing " + dishName);
        try {
            Thread.sleep(2000); // Simulate cooking time
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(Thread.currentThread().getName() + " finished preparing " + dishName);
    }
}

public class RunnableExample {
    public static void main(String[] args) {
        Thread chef1 = new Thread(new ChefTask("Burger"));
        Thread chef2 = new Thread(new ChefTask("Pasta"));

        chef1.start();
        chef2.start();

        System.out.println("Main thread: Waiting for chefs to finish...");
    }
}
```

---

#### 🧾 **Sample Output**

```
Main thread: Waiting for chefs to finish...
Thread-0 started preparing Burger
Thread-1 started preparing Pasta
Thread-0 finished preparing Burger
Thread-1 finished preparing Pasta
```

---

✅ **Key difference:**

- `Thread` approach → not reusable if you already extend another class.
    
- `Runnable` approach → preferred, since it allows you to extend other classes and separate **task logic** from **thread management**.
    