### ✅ **Thread Lifecycle Example**

```java
class Worker extends Thread {
    @Override
    public void run() {
        System.out.println("Inside run(): State = " + Thread.currentThread().getState()); // RUNNABLE
        try {
            Thread.sleep(1000); // TIMED_WAITING
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Worker finished work!");
    }
}

public class ThreadStateDemo {
    public static void main(String[] args) throws InterruptedException {
        Worker worker = new Worker();

        System.out.println("1️⃣ After creation: " + worker.getState()); // NEW

        worker.start();
        System.out.println("2️⃣ After start(): " + worker.getState());  // RUNNABLE

        Thread.sleep(200);
        System.out.println("3️⃣ While sleeping: " + worker.getState()); // TIMED_WAITING (inside sleep)

        worker.join(); // main thread waits until worker finishes
        System.out.println("4️⃣ After completion: " + worker.getState()); // TERMINATED
    }
}
```

---

### 🧾 **Sample Output (Typical)**

```
1️⃣ After creation: NEW
2️⃣ After start(): RUNNABLE
Inside run(): State = RUNNABLE
3️⃣ While sleeping: TIMED_WAITING
Worker finished work!
4️⃣ After completion: TERMINATED
```

---

### 🧠 **Explanation**

|Stage|State|Description|
|---|---|---|
|After creation|**NEW**|Thread object created but not started yet.|
|After start()|**RUNNABLE**|Thread eligible to run, waiting for CPU.|
|During sleep()|**TIMED_WAITING**|Thread sleeping (not running temporarily).|
|After join()|**TERMINATED**|Thread finished execution.|
