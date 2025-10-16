### ✅ **CyclicBarrier Example**

#### 🧠 Scenario:

A **team of runners** waits for all members to arrive at the starting line before starting the race.

- `CyclicBarrier` ensures all threads wait until **everyone reaches the barrier**.
    
- Can be reused for multiple barriers.
    

---

```java
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

class Runner implements Runnable {
    private final String name;
    private final CyclicBarrier barrier;

    public Runner(String name, CyclicBarrier barrier) {
        this.name = name;
        this.barrier = barrier;
    }

    @Override
    public void run() {
        System.out.println(name + " is arriving at the start line...");
        try {
            Thread.sleep((long)(Math.random() * 2000)); // simulate arrival time
            System.out.println(name + " is ready.");
            barrier.await(); // wait for other runners
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }
        System.out.println(name + " started running!");
    }
}

public class CyclicBarrierExample {
    public static void main(String[] args) {
        int numRunners = 3;
        CyclicBarrier barrier = new CyclicBarrier(numRunners, 
            () -> System.out.println("All runners are ready. Start the race! 🏁")
        );

        Thread r1 = new Thread(new Runner("Runner-1", barrier));
        Thread r2 = new Thread(new Runner("Runner-2", barrier));
        Thread r3 = new Thread(new Runner("Runner-3", barrier));

        r1.start(); r2.start(); r3.start();
    }
}
```

---

### 🧾 **Sample Output**

```
Runner-1 is arriving at the start line...
Runner-2 is arriving at the start line...
Runner-3 is arriving at the start line...
Runner-2 is ready.
Runner-1 is ready.
Runner-3 is ready.
All runners are ready. Start the race! 🏁
Runner-2 started running!
Runner-1 started running!
Runner-3 started running!
```

---

### 🧠 **Key Points**

- `CyclicBarrier` lets threads **wait for each other** at a barrier point.
    
- The barrier can **execute a Runnable** once all threads reach it.
    
- Reusable for multiple rounds (unlike `CountDownLatch`, which is one-time use).
    