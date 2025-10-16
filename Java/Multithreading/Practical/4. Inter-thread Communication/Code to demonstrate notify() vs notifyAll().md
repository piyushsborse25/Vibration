### ✅ **notify() vs notifyAll()**

#### 🧠 Scenario:

Multiple **customers waiting** for cakes in a bakery.

- `notify()` wakes **only one waiting customer**.
    
- `notifyAll()` wakes **all waiting customers**.
    

---

```java
class BakeryNotify {
    private boolean cakeAvailable = false;

    // Customer waits for cake
    public synchronized void waitForCake(String customer) {
        try {
            while (!cakeAvailable) {
                System.out.println(customer + " is waiting for cake...");
                wait(); // releases lock and waits
            }
            System.out.println(customer + " got the cake!");
            cakeAvailable = false;
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    // Baker makes cake
    public synchronized void bakeCake(boolean notifyAllCustomers) {
        cakeAvailable = true;
        System.out.println("Baker baked a cake!");
        if (notifyAllCustomers) notifyAll(); // wake all waiting customers
        else notify(); // wake one waiting customer
    }
}

public class NotifyVsNotifyAllExample {
    public static void main(String[] args) throws InterruptedException {
        BakeryNotify bakery = new BakeryNotify();

        // Multiple customers
        Thread c1 = new Thread(() -> bakery.waitForCake("Alice"));
        Thread c2 = new Thread(() -> bakery.waitForCake("Bob"));
        Thread c3 = new Thread(() -> bakery.waitForCake("Charlie"));

        c1.start(); c2.start(); c3.start();

        Thread.sleep(1000); // let all customers start waiting

        Thread baker = new Thread(() -> bakery.bakeCake(false)); // try with true for notifyAll()
        baker.start();
    }
}
```

---

### 🧾 **Sample Output with `notify()`**

```
Alice is waiting for cake...
Bob is waiting for cake...
Charlie is waiting for cake...
Baker baked a cake!
Alice got the cake!
```

> Only **one customer** (Alice) got the cake. The others continue waiting.

---

### 🧾 **Sample Output with `notifyAll()`**

```
Alice is waiting for cake...
Bob is waiting for cake...
Charlie is waiting for cake...
Baker baked a cake!
Alice got the cake!
Bob got the cake!
Charlie got the cake!
```

> **All waiting customers** are notified and can attempt to acquire the lock.

---

### 🧠 **Key Points**

- `notify()` → wakes **one thread**, others remain waiting.
    
- `notifyAll()` → wakes **all threads**, useful when **multiple consumers** can proceed.
    
- Always use inside **synchronized block/method**.
    