### ✅ **Synchronized Method Example**

#### 🧠 Scenario:

Multiple users are booking movie tickets at the same time.  
The `bookTicket()` method must be synchronized to avoid overselling seats.

---

```java
class TicketCounter {
    private int availableTickets = 2;

    public synchronized void bookTicket(String user) {
        if (availableTickets > 0) {
            System.out.println(user + " is booking a ticket...");
            try {
                // simulate potential exception during booking
                Thread.sleep(1000); 
                // you can uncomment to test exception handling
                // if(user.equals("Bob")) throw new RuntimeException("Payment failed!");
                
                // decrement only after successful booking
                availableTickets--;
                System.out.println(user + " successfully booked!");
            } catch (InterruptedException e) {
                System.out.println(user + " booking interrupted!");
            } catch (Exception e) {
                System.out.println(user + " booking failed: " + e.getMessage());
            }
        } else {
            System.out.println(user + " tried booking but tickets are SOLD OUT!");
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

public class SynchronizedMethodExample {
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
Alice is booking a ticket...
Alice successfully booked! Remaining: 1
Bob is booking a ticket...
Bob successfully booked! Remaining: 0
Charlie tried booking but tickets are SOLD OUT!
```

---

### 🧠 **Key Point**

`synchronized` ensures **only one thread executes the method at a time**, protecting shared data (`availableTickets`) from race conditions.