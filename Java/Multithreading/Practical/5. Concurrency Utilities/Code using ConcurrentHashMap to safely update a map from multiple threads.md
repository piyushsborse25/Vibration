### ✅ **ConcurrentHashMap Example**

#### 🧠 Scenario:

A **library system** where multiple librarians update the **book stock count** concurrently.

- `ConcurrentHashMap` allows **thread-safe updates without explicit synchronization**.
    

---

```java
import java.util.concurrent.ConcurrentHashMap;

public class ConcurrentHashMapExample {
    public static void main(String[] args) {
        ConcurrentHashMap<String, Integer> library = new ConcurrentHashMap<>();

        library.put("Java", 10);
        library.put("Python", 8);
        library.put("C++", 5);

        Runnable librarian1 = () -> {
            library.computeIfPresent("Java", (k, v) -> v + 2);
            System.out.println(Thread.currentThread().getName() + " updated Java books");
        };

        Runnable librarian2 = () -> {
            library.computeIfPresent("Python", (k, v) -> v + 3);
            System.out.println(Thread.currentThread().getName() + " updated Python books");
        };

        Thread t1 = new Thread(librarian1, "Librarian-1");
        Thread t2 = new Thread(librarian2, "Librarian-2");

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Final Library Stock: " + library);
    }
}
```

---

### 🧾 **Sample Output**

```
Librarian-1 updated Java books
Librarian-2 updated Python books
Final Library Stock: {Java=12, Python=11, C++=5}
```

---

### 🧠 **Key Points**

- `ConcurrentHashMap` allows **concurrent reads and updates** without `synchronized`.
    
- Methods like `computeIfPresent`, `putIfAbsent` are **atomic**.
    
- Ideal for **shared maps** accessed by multiple threads.
    