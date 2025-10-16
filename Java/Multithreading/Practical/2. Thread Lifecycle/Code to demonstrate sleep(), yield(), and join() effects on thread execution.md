### ✅ **Example: Demonstrating sleep(), yield(), and join()**

#### 🧠 Scenario:

Two players (threads) take turns playing rounds.

- `sleep()` → simulates rest between rounds.
    
- `yield()` → gives other thread a chance to execute.
    
- `join()` → main waits for player to finish.
    

---

```java
class Player extends Thread {
    public Player(String name) {
        super(name);
    }

    @Override
    public void run() {
        for (int round = 1; round <= 3; round++) {
            System.out.println(getName() + " is playing round " + round);

            if (round == 2) {
                System.out.println(getName() + " yields control...");
                Thread.yield(); // Suggest scheduler to switch threads
            }

            try {
                Thread.sleep(500); // Simulate rest time
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class ThreadMethodsDemo {
    public static void main(String[] args) throws InterruptedException {
        Player p1 = new Player("Player-1");
        Player p2 = new Player("Player-2");

        p1.start();
        p2.start();

        // Wait for p1 to finish before main continues
        p1.join();

        System.out.println("Main thread resumes after Player-1 finishes.");
    }
}
```

---

### 🧾 **Sample Output (Typical)**

```
Player-1 is playing round 1
Player-2 is playing round 1
Player-1 is playing round 2
Player-1 yields control...
Player-2 is playing round 2
Player-2 yields control...
Player-1 is playing round 3
Player-2 is playing round 3
Main thread resumes after Player-1 finishes.
```

---

### 🧠 **Concept Recap**

|Method|Purpose|Effect|
|---|---|---|
|`sleep(ms)`|Pause current thread for `ms`|Moves to **TIMED_WAITING** state|
|`yield()`|Hint scheduler to switch threads|May give other threads a chance|
|`join()`|Wait for another thread to finish|Causes **WAITING** state in caller|
