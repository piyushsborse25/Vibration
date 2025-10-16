### ✅ **Synchronized Block Example**

#### 🧠 Scenario:

Multiple users try booking tickets.  
Instead of synchronizing the whole method, we synchronize **only the critical section** where the shared resource (`availableTickets`) is updated.

---

```java
class TicketCounter {
    private int availableTickets = 2;

    public void bookTicket(String user) {
        System.out.println(user + " is attempting to book a ticket...");

        // only this block is synchronized
        synchronized (this) {
            if (availableTickets > 0) {
                try {
                    Thread.sleep(1000); // simulate booking delay
                    availableTickets--;
                    System.out.println(user + " successfully booked! Remaining: " + availableTickets);
                } catch (InterruptedException e) {
                    System.out.println(user + " booking interrupted!");
                }
            } else {
                System.out.println(user + " tried booking but tickets are SOLD OUT!");
            }
        }
    }
}

class UserThread extends Thread {
    private final TicketCounter counter;
    private final String userName;

    public UserThread(TicketCounter counter, String userName) {
        this.counter = counter;
        this.userName = userName;
    }

    @Override
    public void run() {
        counter.bookTicket(userName);
    }
}

public class SynchronizedBlockExample {
    public static void main(String[] args) {
        TicketCounter counter = new TicketCounter();

        UserThread u1 = new UserThread(counter, "Alice");
        UserThread u2 = new UserThread(counter, "Bob");
        UserThread u3 = new UserThread(counter, "Charlie");

        u1.start();
        u2.start();
        u3.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Alice is attempting to book a ticket...
Bob is attempting to book a ticket...
Charlie is attempting to book a ticket...
Alice successfully booked! Remaining: 1
Bob successfully booked! Remaining: 0
Charlie tried booking but tickets are SOLD OUT!
```

---

### 🧠 **Key Points**

- Only the **critical section** (updating `availableTickets`) is synchronized.
    
- This improves **concurrency** because threads can execute non-critical code (like printing/logging) outside the lock.
    
- Protects shared data while allowing better performance than synchronizing the entire method.
    