### ✅ **ThreadLocal Example**

#### 🧠 Scenario:

Each **customer thread** in a bank has its **own transaction ID**.

- ThreadLocal ensures that **each thread has its own copy** of the variable.
    

---

```java
class BankTransaction {
    private static ThreadLocal<String> transactionId = new ThreadLocal<>();

    public static void setTransactionId(String id) {
        transactionId.set(id);
    }

    public static String getTransactionId() {
        return transactionId.get();
    }
}

public class ThreadLocalExample {
    public static void main(String[] args) {
        Runnable task = () -> {
            String threadName = Thread.currentThread().getName();
            BankTransaction.setTransactionId("TXN-" + threadName);
            System.out.println(threadName + " started with Transaction ID: " + BankTransaction.getTransactionId());

            try { Thread.sleep(500); } catch (InterruptedException ignored) {}

            System.out.println(threadName + " ends with Transaction ID: " + BankTransaction.getTransactionId());
        };

        Thread t1 = new Thread(task, "Customer-1");
        Thread t2 = new Thread(task, "Customer-2");

        t1.start();
        t2.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Customer-1 started with Transaction ID: TXN-Customer-1
Customer-2 started with Transaction ID: TXN-Customer-2
Customer-1 ends with Transaction ID: TXN-Customer-1
Customer-2 ends with Transaction ID: TXN-Customer-2
```

---

### 🧠 **Key Points**

- `ThreadLocal` provides **thread-confined variables**.
    
- Each thread accesses **its own independent copy**.
    
- Useful for storing **per-thread data** like transactions, user sessions, or DB connections.
    