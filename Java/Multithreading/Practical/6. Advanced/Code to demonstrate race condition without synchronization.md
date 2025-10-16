### ✅ **Race Condition Example**

#### 🧠 Scenario:

Two **bank tellers** update the same **account balance** simultaneously without synchronization.  
Both try to deposit money — but due to race condition, the **final balance becomes incorrect**.

---

```java
public class RaceConditionExample {
    private static int accountBalance = 100; // shared resource

    public static void main(String[] args) {
        Runnable depositTask = () -> {
            for (int i = 0; i < 5; i++) {
                int currentBalance = accountBalance; // read
                try { Thread.sleep(100); } catch (InterruptedException ignored) {}
                accountBalance = currentBalance + 10; // write
                System.out.println(Thread.currentThread().getName() +
                        " deposited 10. Current Balance: " + accountBalance);
            }
        };

        Thread teller1 = new Thread(depositTask, "Teller-1");
        Thread teller2 = new Thread(depositTask, "Teller-2");

        teller1.start();
        teller2.start();

        try {
            teller1.join();
            teller2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Final Account Balance: " + accountBalance);
    }
}
```

---

### 🧾 **Sample Output (Inconsistent due to race condition)**

```
Teller-1 deposited 10. Current Balance: 110
Teller-2 deposited 10. Current Balance: 110
Teller-1 deposited 10. Current Balance: 120
Teller-2 deposited 10. Current Balance: 120
...
Final Account Balance: 150   // ❌ should be 200
```

---

### 🧠 **Key Points**

- Multiple threads **read and write shared data simultaneously**.
    
- No visibility or atomicity → **incorrect results**.
    
- Fix → use `synchronized`, `ReentrantLock`, or `AtomicInteger`.
    