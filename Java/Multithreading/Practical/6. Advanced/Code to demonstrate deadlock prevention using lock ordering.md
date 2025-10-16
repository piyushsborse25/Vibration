### ✅ **Deadlock Prevention Example**

#### 🧠 Scenario:

Two **bank accounts** transfer money between each other.  
If both threads lock accounts in **different order**, a deadlock can occur.  
We fix it by enforcing a **consistent lock ordering** based on account IDs.

---

```java
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class BankAccount {
    private int id;
    private int balance;
    private final Lock lock = new ReentrantLock();

    public BankAccount(int id, int balance) {
        this.id = id;
        this.balance = balance;
    }

    public int getId() { return id; }
    public Lock getLock() { return lock; }

    public void withdraw(int amount) { balance -= amount; }
    public void deposit(int amount) { balance += amount; }

    public int getBalance() { return balance; }
}

public class DeadlockPreventionExample {

    public static void transferMoney(BankAccount from, BankAccount to, int amount) {
        BankAccount first = from.getId() < to.getId() ? from : to;
        BankAccount second = from.getId() < to.getId() ? to : from;

        // consistent lock ordering to prevent deadlock
        first.getLock().lock();
        try {
            second.getLock().lock();
            try {
                from.withdraw(amount);
                to.deposit(amount);
                System.out.println(Thread.currentThread().getName() + 
                        " transferred " + amount + " from Account-" + from.getId() + 
                        " to Account-" + to.getId());
            } finally {
                second.getLock().unlock();
            }
        } finally {
            first.getLock().unlock();
        }
    }

    public static void main(String[] args) {
        BankAccount acc1 = new BankAccount(1, 1000);
        BankAccount acc2 = new BankAccount(2, 1000);

        Thread t1 = new Thread(() -> transferMoney(acc1, acc2, 100), "T1");
        Thread t2 = new Thread(() -> transferMoney(acc2, acc1, 200), "T2");

        t1.start();
        t2.start();
    }
}
```

---

### 🧾 **Sample Output**

```
T1 transferred 100 from Account-1 to Account-2
T2 transferred 200 from Account-2 to Account-1
```

---

### 🧠 **Key Points**

- Both threads acquire locks **in the same order** → avoids circular waiting.
    
- No deadlock occurs even with **mutual transfers**.
    
- This technique is widely used in **financial systems, booking systems, and database transactions**.
    