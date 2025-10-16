### ✅ **Livelock Example**

#### 🧠 Scenario:

Two polite people trying to pass each other in a narrow corridor.  
They keep stepping aside simultaneously, so **both are active but never make progress**.

---

```java
class PolitePerson {
    private final String name;
    private boolean sideStep = true;

    public PolitePerson(String name) {
        this.name = name;
    }

    public void pass(PolitePerson other) {
        while (true) {
            if (!other.isSideStep()) {
                System.out.println(name + " passes successfully!");
                break;
            }
            System.out.println(name + " waits politely...");
            sideStep = !sideStep; // keep switching side
            try {
                Thread.sleep(100); // simulate delay
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean isSideStep() { return sideStep; }
}

public class LivelockExample {
    public static void main(String[] args) {
        PolitePerson person1 = new PolitePerson("Alice");
        PolitePerson person2 = new PolitePerson("Bob");

        Thread t1 = new Thread(() -> person1.pass(person2));
        Thread t2 = new Thread(() -> person2.pass(person1));

        t1.start();
        t2.start();
    }
}
```

---

### 🧾 **Sample Output (Illustrative)**

```
Alice waits politely...
Bob waits politely...
Alice waits politely...
Bob waits politely...
Alice waits politely...
Bob waits politely...
...
```

> Both threads are active, but **no one progresses** — that’s livelock.

---

### 🧠 **Key Points**

- Livelock: threads **keep running** but **cannot make progress**.
    
- Usually caused by **overly “polite” coordination**, e.g., repeatedly yielding or stepping aside.
    
- Unlike deadlock, **threads are not blocked**, they just loop endlessly.
    