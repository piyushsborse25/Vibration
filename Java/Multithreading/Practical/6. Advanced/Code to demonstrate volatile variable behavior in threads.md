### ✅ **Volatile Example**

#### 🧠 Scenario:

A **traffic signal controller** updates a shared flag (`signalGreen`) that all cars check.

- `volatile` ensures **visibility** of changes across threads immediately.
    

---

```java
public class VolatileExample {
    private static volatile boolean signalGreen = false; // shared flag

    public static void main(String[] args) {
        Thread trafficController = new Thread(() -> {
            try {
                Thread.sleep(2000); // simulate signal change after 2s
                System.out.println("Traffic Controller: Turning signal GREEN!");
                signalGreen = true; // visible immediately to all threads
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        Thread car = new Thread(() -> {
            System.out.println("Car waiting for green signal...");
            while (!signalGreen) {
                // busy waiting — without volatile, might loop forever
            }
            System.out.println("Car: Signal is GREEN! Driving ahead 🚗💨");
        });

        car.start();
        trafficController.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Car waiting for green signal...
Traffic Controller: Turning signal GREEN!
Car: Signal is GREEN! Driving ahead 🚗💨
```

---

### 🧠 **Key Points**

- `volatile` guarantees **visibility**, not **atomicity**.
    
- Without `volatile`, car thread may never see the updated flag due to caching.
    
- Use for **status flags**, **stop signals**, and **configuration updates** shared between threads.
    