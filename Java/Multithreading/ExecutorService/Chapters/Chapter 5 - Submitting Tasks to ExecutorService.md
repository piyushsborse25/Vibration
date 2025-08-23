Up to now, we know how to create and manage an `ExecutorService`. But the real value comes from **submitting tasks** and letting the service manage execution. In this chapter, we’ll cover every detail about **task submission** — from simple `Runnable` to advanced `Callable` with results.

---

## 5.1 The `submit()` Method

Unlike `execute()` (which accepts only `Runnable` and returns nothing), the `submit()` method is more powerful.

### Key Points:

- Can accept **Runnable** or **Callable**.
    
- Always returns a **`Future` object**.
    
- Gives control over **results, cancellation, and exception handling**.
    

---

## 5.2 Submitting a `Runnable`

`Runnable` tasks don’t return a result, but `submit()` still provides a `Future<?>` object.  
The `Future.get()` will return **null** when the task finishes.

### Example:

```java
import java.util.concurrent.*;

public class SubmitRunnableExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        Runnable task = () -> {
            System.out.println("Executing runnable task in: " + Thread.currentThread().getName());
        };

        Future<?> future = executor.submit(task);

        // Wait for completion
        Object result = future.get(); // will always be null
        System.out.println("Task completed, result = " + result);

        executor.shutdown();
    }
}
```

✅ Useful when you care about **completion** but not the result.

---

## 5.3 Submitting a `Callable`

`Callable<T>` is like `Runnable`, but it **returns a value** (or throws an exception).

- The generic type `<T>` defines the return type.
    
- The result is retrieved with `Future.get()`.
    

### Example:

```java
import java.util.concurrent.*;

public class SubmitCallableExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(2);

        Callable<Integer> task = () -> {
            System.out.println("Calculating sum in " + Thread.currentThread().getName());
            int sum = 0;
            for (int i = 1; i <= 10; i++) {
                sum += i;
            }
            return sum;
        };

        Future<Integer> future = executor.submit(task);

        // Block until result is ready
        Integer result = future.get();
        System.out.println("Result = " + result); // 55

        executor.shutdown();
    }
}
```

✅ Useful for **background computations**.

---

## 5.4 Submitting Multiple Tasks

You can submit multiple tasks to the same ExecutorService. Each will return its own `Future`.

```java
ExecutorService executor = Executors.newFixedThreadPool(3);

Callable<String> task1 = () -> "Result from task1";
Callable<String> task2 = () -> "Result from task2";

Future<String> f1 = executor.submit(task1);
Future<String> f2 = executor.submit(task2);

System.out.println(f1.get()); // "Result from task1"
System.out.println(f2.get()); // "Result from task2"

executor.shutdown();
```

---

## 5.5 Submitting Collections of Tasks

Sometimes, you need to run **many tasks at once** and collect results. ExecutorService provides special methods:

### 1. `invokeAll()`

- Runs all tasks.
    
- Returns a list of `Future`s.
    
- Blocks until all are done.
    

```java
List<Callable<String>> tasks = Arrays.asList(
    () -> "Task 1",
    () -> "Task 2",
    () -> "Task 3"
);

ExecutorService executor = Executors.newFixedThreadPool(3);
List<Future<String>> results = executor.invokeAll(tasks);

for (Future<String> f : results) {
    System.out.println(f.get());
}
executor.shutdown();
```

### 2. `invokeAny()`

- Runs all tasks.
    
- Returns the **first successful result**.
    
- Cancels others once one finishes.
    

```java
String result = executor.invokeAny(tasks);
System.out.println("First result: " + result);
```

✅ Great for **racing tasks** (e.g., calling multiple APIs and taking the fastest response).

---

## 5.6 When to Use What

- `execute(Runnable task)` → Fire and forget (no return, no control).
    
- `submit(Runnable task)` → When you want to know completion, but no result.
    
- `submit(Callable<T> task)` → When you need a result or exception handling.
    
- `invokeAll(tasks)` → When all results are required.
    
- `invokeAny(tasks)` → When **one result** is enough.
    

---

## 5.7 Practical Example – Web Scraping

Imagine we want to fetch data from multiple URLs and take whichever returns first.

```java
import java.util.concurrent.*;
import java.util.*;

public class WebScraperExample {
    public static void main(String[] args) throws Exception {
        ExecutorService executor = Executors.newCachedThreadPool();

        List<Callable<String>> tasks = Arrays.asList(
            () -> { Thread.sleep(2000); return "Data from Site A"; },
            () -> { Thread.sleep(1000); return "Data from Site B"; },
            () -> { Thread.sleep(3000); return "Data from Site C"; }
        );

        String firstResult = executor.invokeAny(tasks);
        System.out.println("Fastest response: " + firstResult);

        executor.shutdown();
    }
}
```

---

## 5.8 Best Practices

1. **Prefer `Callable` over `Runnable`** if you need results or exception handling.
    
2. **Avoid blocking on `Future.get()`** unless necessary → consider `CompletableFuture` (later chapter).
    
3. **Choose the right pool size** depending on CPU vs I/O tasks.
    
4. **Use `invokeAll()` or `invokeAny()`** for bulk task management.
    

---

✅ **Summary:**  
In this chapter, we saw how tasks are submitted to an `ExecutorService` using `submit()`, `invokeAll()`, and `invokeAny()`. We also learned the key differences between `Runnable` and `Callable`, and how `Future` gives us control over task results and exceptions.
