So far, we’ve seen how to **create executors** and manage their lifecycle. But the **real work** lies in **submitting tasks** and handling their results effectively. This chapter explores **how tasks are submitted, executed, and how results (or exceptions) are retrieved and handled**.

---

## 6.1 Submitting Tasks to ExecutorService

There are **two main methods** of submitting tasks:

### 1. `execute(Runnable command)`

- From `Executor` interface.
    
- Fire-and-forget (no result).
    
- Used when you don’t need the task result.
    

```java
ExecutorService executor = Executors.newFixedThreadPool(2);
executor.execute(() -> System.out.println("Task executed by " + Thread.currentThread().getName()));
```

### 2. `submit()`

- Defined in `ExecutorService`.
    
- Overloaded methods:
    
    - `submit(Runnable task)`
        
    - `submit(Callable<T> task)`
        
    - `submit(Runnable task, T result)`
        
- Always returns a **`Future`**.
    

👉 Example:

```java
ExecutorService executor = Executors.newSingleThreadExecutor();

Future<String> future = executor.submit(() -> {
    Thread.sleep(500);
    return "Hello from Callable!";
});

System.out.println("Result: " + future.get());
executor.shutdown();
```

---

## 6.2 `Runnable` vs `Callable`

- `Runnable`:
    
    - No return value.
        
    - Cannot throw checked exceptions (only unchecked).
        
    - Example:
        
        ```java
        Runnable r = () -> System.out.println("Runnable running!");
        ```
        
- `Callable<V>`:
    
    - Returns a value of type `V`.
        
    - Can throw checked exceptions.
        
    - Example:
        
        ```java
        Callable<Integer> c = () -> {
            Thread.sleep(100);
            return 42;
        };
        ```
        

👉 Use `Callable` when you **need results** or want to **propagate exceptions**.

---

## 6.3 The `Future` Interface

A **`Future`** represents the **result of an asynchronous computation**.

### Key Methods:

- `V get()`: Waits if necessary for the task to complete and returns result.
    
- `V get(long timeout, TimeUnit unit)`: Same as above, but with timeout.
    
- `boolean cancel(boolean mayInterruptIfRunning)`: Attempts to cancel execution.
    
- `boolean isDone()`: Returns `true` if task completed.
    
- `boolean isCancelled()`: Returns `true` if task was cancelled.
    

👉 Example:

```java
ExecutorService executor = Executors.newSingleThreadExecutor();

Future<Integer> future = executor.submit(() -> {
    Thread.sleep(1000);
    return 123;
});

System.out.println("Task submitted...");
System.out.println("Result: " + future.get()); // Blocks until result is ready
executor.shutdown();
```

---

## 6.4 Handling Exceptions from Tasks

- **Runnable**: Exceptions are swallowed unless caught inside.
    
- **Callable**: Exceptions are wrapped in **`ExecutionException`** when calling `future.get()`.
    

👉 Example:

```java
ExecutorService executor = Executors.newSingleThreadExecutor();

Future<Integer> future = executor.submit(() -> {
    throw new RuntimeException("Boom!");
});

try {
    future.get();
} catch (ExecutionException e) {
    System.out.println("Exception: " + e.getCause()); // Prints "Boom!"
}
executor.shutdown();
```

---

## 6.5 Submitting Multiple Tasks

### `invokeAll()`

- Submits a **collection of tasks**.
    
- Returns a `List<Future<T>>`.
    
- Blocks until **all tasks** complete.
    

```java
ExecutorService executor = Executors.newFixedThreadPool(3);

List<Callable<Integer>> tasks = Arrays.asList(
    () -> 1, () -> 2, () -> 3
);

List<Future<Integer>> futures = executor.invokeAll(tasks);
for (Future<Integer> f : futures) {
    System.out.println("Result: " + f.get());
}
executor.shutdown();
```

### `invokeAny()`

- Submits multiple tasks but returns the result of the **first successfully completed task**.
    
- Cancels remaining tasks.
    

```java
ExecutorService executor = Executors.newFixedThreadPool(3);

List<Callable<String>> tasks = Arrays.asList(
    () -> { Thread.sleep(300); return "Task A"; },
    () -> { Thread.sleep(100); return "Task B"; },
    () -> { Thread.sleep(200); return "Task C"; }
);

String result = executor.invokeAny(tasks);
System.out.println("First completed: " + result); // Likely "Task B"
executor.shutdown();
```

---

## 6.6 Best Practices for Task Submission

✅ Prefer `Callable` over `Runnable` when results or exceptions matter.  
✅ Always handle `InterruptedException` properly.  
✅ Use `invokeAll` for **batch execution** where all results are needed.  
✅ Use `invokeAny` for **"first result wins"** scenarios.  
✅ Avoid submitting **long-running blocking tasks** to a small pool.

---

## 6.7 Practical Example: Web Scraper

Let’s simulate a **web scraping executor** where we submit multiple Callable tasks:

```java
import java.util.*;
import java.util.concurrent.*;

public class WebScraperDemo {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(3);

        List<Callable<String>> tasks = Arrays.asList(
            () -> fetchPage("https://siteA.com"),
            () -> fetchPage("https://siteB.com"),
            () -> fetchPage("https://siteC.com")
        );

        List<Future<String>> results = executor.invokeAll(tasks);

        for (Future<String> f : results) {
            System.out.println("Page content: " + f.get());
        }

        executor.shutdown();
    }

    static String fetchPage(String url) throws InterruptedException {
        Thread.sleep(500); // Simulate network delay
        return "Content from " + url;
    }
}
```

---

## ✅ Chapter 6 Recap

- Tasks can be submitted using **`execute`** (fire-and-forget) or **`submit`** (with result).
    
- Use **`Runnable`** for tasks without result, **`Callable`** for tasks with result.
    
- **`Future`** helps manage async results, cancellation, and exceptions.
    
- **`invokeAll`** → wait for all tasks, **`invokeAny`** → return first successful result.
    
- Exception handling is critical (via `ExecutionException`).
    

---
# 🌍 Real-World Scenario: Multi-Service Async Aggregator API

Imagine you’re building an **e-commerce backend API**:

- A client sends a request for **Order Details Page**.
    
- To build this page, you need data from **multiple microservices**:
    
    1. **User Service** → fetch user profile.
        
    2. **Order Service** → fetch order details.
        
    3. **Inventory Service** → check item availability.
        
    4. **Payment Service** → fetch last payment status.
        
    5. **Recommendation Service** → get personalized suggestions.
        

Traditionally, if you call these services **sequentially**, total response time = sum of all service latencies (e.g., 300ms + 200ms + 400ms + 500ms = ~1.4s).  
But with **ExecutorService + Future/Callable**, you can **call all services in parallel** and aggregate results once all are done.  
This reduces response time to roughly the **slowest service** (max(300, 200, 400, 500) ≈ 500ms).

---

## 🛠 Implementation with `ExecutorService`

```java
import java.util.*;
import java.util.concurrent.*;

public class AsyncAggregatorAPI {

    private static final ExecutorService executor = Executors.newFixedThreadPool(5);

    public static void main(String[] args) throws Exception {

        // Submit async service calls
        Future<String> userFuture = executor.submit(() -> fetchUser());
        Future<String> orderFuture = executor.submit(() -> fetchOrder());
        Future<String> inventoryFuture = executor.submit(() -> fetchInventory());
        Future<String> paymentFuture = executor.submit(() -> fetchPayment());
        Future<String> recommendationFuture = executor.submit(() -> fetchRecommendations());

        // Collect results (blocking only when needed)
        String user = userFuture.get();
        String order = orderFuture.get();
        String inventory = inventoryFuture.get();
        String payment = paymentFuture.get();
        String recommendation = recommendationFuture.get();

        // Aggregate response
        String aggregatedResponse = String.format("""
            {
              "user": %s,
              "order": %s,
              "inventory": %s,
              "payment": %s,
              "recommendation": %s
            }
        """, user, order, inventory, payment, recommendation);

        System.out.println("Final Aggregated Response: " + aggregatedResponse);

        executor.shutdown();
    }

    // Mock Service Calls (simulate latency with sleep)
    private static String fetchUser() throws InterruptedException {
        Thread.sleep(300); // simulate latency
        return "{id:1, name:'Alice'}";
    }

    private static String fetchOrder() throws InterruptedException {
        Thread.sleep(200);
        return "{orderId:101, item:'Laptop'}";
    }

    private static String fetchInventory() throws InterruptedException {
        Thread.sleep(400);
        return "{item:'Laptop', available:true}";
    }

    private static String fetchPayment() throws InterruptedException {
        Thread.sleep(500);
        return "{status:'Paid'}";
    }

    private static String fetchRecommendations() throws InterruptedException {
        Thread.sleep(250);
        return "[{item:'Mouse'}, {item:'Keyboard'}]";
    }
}
```

---

## 📊 Output (Sample)

```
Final Aggregated Response: {
  "user": {id:1, name:'Alice'},
  "order": {orderId:101, item:'Laptop'},
  "inventory": {item:'Laptop', available:true},
  "payment": {status:'Paid'},
  "recommendation": [{item:'Mouse'}, {item:'Keyboard'}]
}
```

---

## 🔑 Key Learnings (Chapter 6 Applied)

1. **Submit tasks asynchronously** using `submit(Callable)`.
    
2. **Track completion** with `Future`.
    
3. **Parallelize I/O-bound calls** (service-to-service calls) to save time.
    
4. **Aggregate results** once all futures complete.
    
5. **Graceful shutdown** after use (`shutdown()` or `shutdownNow()`).
    

This exact **async aggregator pattern** is common in:

- API Gateways
    
- BFF (Backend-for-Frontend) services
    
- Data enrichment services
    