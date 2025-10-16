### ✅ **Deadlock Example**

#### 🧠 Scenario:

Two friends trying to **transfer money between accounts** simultaneously.  
Each thread locks one account first, then tries to lock the second — causing a deadlock.

---

```java
class Account {
    private int balance = 1000;
    private final String name;

    public Account(String name) {
        this.name = name;
    }

    public String getName() { return name; }

    public void withdraw(int amount) { balance -= amount; }

    public void deposit(int amount) { balance += amount; }

    public int getBalance() { return balance; }
}

public class DeadlockExample {
    public static void main(String[] args) {
        Account acc1 = new Account("AliceAccount");
        Account acc2 = new Account("BobAccount");

        Thread t1 = new Thread(() -> transfer(acc1, acc2, 100), "T1");
        Thread t2 = new Thread(() -> transfer(acc2, acc1, 200), "T2");

        t1.start();
        t2.start();
    }

    public static void transfer(Account from, Account to, int amount) {
        synchronized (from) {
            System.out.println(Thread.currentThread().getName() + " locked " + from.getName());
            try { Thread.sleep(100); } catch (InterruptedException ignored) {}

            synchronized (to) {
                System.out.println(Thread.currentThread().getName() + " locked " + to.getName());
                from.withdraw(amount);
                to.deposit(amount);
                System.out.println(Thread.currentThread().getName() + " completed transfer of " + amount);
            }
        }
    }
}
```

---

### 🧾 **Sample Output (Deadlock Happens)**

```
T1 locked AliceAccount
T2 locked BobAccount
// Both threads now waiting for the other account lock indefinitely
```

---

### 🧠 **Explanation**

- `T1` locks **AliceAccount**, tries to lock **BobAccount**.
    
- `T2` locks **BobAccount**, tries to lock **AliceAccount**.
    
- Both threads are **waiting for each other forever** → deadlock.
    

✅ **Key point:**  
Deadlocks occur when threads acquire **multiple locks in different orders**.