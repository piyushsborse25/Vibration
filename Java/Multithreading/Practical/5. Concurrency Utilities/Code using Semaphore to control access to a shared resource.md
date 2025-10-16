### ✅ **Semaphore Example**

#### 🧠 Scenario:

A **parking lot** with only **2 parking spots**. Cars (threads) must **acquire a spot** before parking.

- `Semaphore` controls access to **limited resources**.
    

---

```java
import java.util.concurrent.Semaphore;

class Car implements Runnable {
    private final String name;
    private final Semaphore parking;

    public Car(String name, Semaphore parking) {
        this.name = name;
        this.parking = parking;
    }

    @Override
    public void run() {
        try {
            System.out.println(name + " is trying to park...");
            parking.acquire(); // acquire a spot
            System.out.println(name + " parked!");
            Thread.sleep(2000); // simulate parking duration
            System.out.println(name + " leaving the spot.");
            parking.release(); // release spot
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

public class SemaphoreExample {
    public static void main(String[] args) {
        Semaphore parkingLot = new Semaphore(2); // 2 parking spots

        Thread c1 = new Thread(new Car("Car-1", parkingLot));
        Thread c2 = new Thread(new Car("Car-2", parkingLot));
        Thread c3 = new Thread(new Car("Car-3", parkingLot));
        Thread c4 = new Thread(new Car("Car-4", parkingLot));

        c1.start(); c2.start(); c3.start(); c4.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Car-1 is trying to park...
Car-2 is trying to park...
Car-3 is trying to park...
Car-4 is trying to park...
Car-1 parked!
Car-2 parked!
Car-1 leaving the spot.
Car-3 parked!
Car-2 leaving the spot.
Car-4 parked!
Car-3 leaving the spot.
Car-4 leaving the spot.
```

---

### 🧠 **Key Points**

- `Semaphore(n)` allows **up to n threads** to access a resource concurrently.
    
- `acquire()` → waits if no permits are available.
    
- `release()` → frees a permit.
    
- Useful for **resource pools**, parking slots, database connections, etc.
    