### **15. What happens if a `finally` block contains a `return` statement? Does it override exceptions thrown in the `try` block?**

- If a `finally` block has a `return` statement, it **overrides any exception or return** from the `try` or `catch` block.
    
- This means the exception will be **suppressed**, and control returns from `finally`.
    

**Example:**

```java
public int test() {
    try {
        throw new RuntimeException("Error");
    } finally {
        return 10;
    }
}
```

**Output:** `10`  
✅ The exception is **not propagated** — the `return` in `finally` **suppresses** it.  
❌ Best practice: **Avoid `return` in `finally`** since it hides exceptions.

---

### **16. Explain the difference between `throw` and `throws`. Can you use `throws` with a `RuntimeException`?**

|Keyword|Purpose|Example|
|---|---|---|
|`throw`|Used **inside a method** to actually throw an exception.|`throw new IOException("error");`|
|`throws`|Declares that a method **may throw** certain exceptions.|`void read() throws IOException`|

✅ You **can** declare `throws RuntimeException`, but it’s optional since unchecked exceptions don’t require declaration.

---

### **17. Can you catch an exception thrown in the `static` block of a class? Why or why not?**

- Yes, but **only inside the static block itself**.
    
- If not caught, it gets wrapped in an `ExceptionInInitializerError`.
    

**Example:**

```java
class Test {
    static {
        try {
            int a = 10 / 0;
        } catch (Exception e) {
            System.out.println("Handled inside static block");
        }
    }
}
```

✅ Static blocks run **once during class loading**.  
❌ If the exception isn’t caught there, the class fails to load.

---

### **18. What happens if an exception is thrown in the `catch` block? Does the `finally` block execute?**

- Yes, the `finally` block **always executes**, even if the `catch` block throws an exception.
    

**Example:**

```java
try {
    int x = 10 / 0;
} catch (ArithmeticException e) {
    throw new NullPointerException();
} finally {
    System.out.println("Finally executes");
}
```

✅ Output: `"Finally executes"`  
❌ Then the `NullPointerException` is propagated.

---

### **19. Can a `try` block exist without a `catch` block? What is the purpose of such a construct?**

- Yes, but it **must have a `finally` block**.
    

**Example:**

```java
try {
    int x = 5 / 0;
} finally {
    System.out.println("Cleanup done");
}
```

✅ Purpose: To **ensure cleanup** (like closing files or DB connections) even if no exception handling is required.

---

### **20. Can you catch multiple exceptions in a single `catch` block? How is this implemented?**

- Yes, since Java 7 using the **multi-catch** feature with the `|` operator.
    

**Example:**

```java
try {
    // code
} catch (IOException | SQLException e) {
    System.out.println("Handled multiple");
}
```

✅ Saves code duplication.  
❌ You **cannot** reassign `e` inside the block (it’s implicitly `final`).

---

### **21. What happens if an exception is thrown in a constructor? Will the object still be partially constructed?**

- If an exception occurs **before** the constructor finishes, the object is **not created**.
    

**Example:**

```java
class A {
    A() {
        int x = 5 / 0;
    }
}
```

✅ The reference is never created.  
❌ The object is **not partially initialized**.

---

### **22. Explain how exception chaining works in Java and why you would use it.**

- **Exception chaining** links one exception to another — helpful for debugging cause of failure.
    

**Syntax:**

```java
throw new IOException("File error", new NullPointerException("Root cause"));
```

- Retrieve cause using `getCause()`.  
    ✅ Used in frameworks (e.g., JDBC, Spring) to wrap low-level exceptions into custom domain exceptions.
    

---

### **23. Is it possible to have multiple `finally` blocks in a `try` statement?**

- ❌ No, a single `try` can have **only one `finally`**.
    
- However, nested try-finally blocks are allowed.
    

**Example:**

```java
try {
    try {
        // inner try
    } finally {
        System.out.println("Inner finally");
    }
} finally {
    System.out.println("Outer finally");
}
```

✅ Both finally blocks execute in sequence.

---

### **24. Can you declare a `throws` clause for a method that doesn't throw any exceptions? Why?**

- ✅ Yes, it compiles fine.
    
- Used for **interface consistency** or **future extensibility**.
    

**Example:**

```java
void process() throws IOException { }
```

✅ Useful if you expect checked exceptions to be added later.

---

### **25. What happens if you call `throw null` in Java? Will it compile and execute?**

- ✅ Compiles fine.
    
- ❌ At runtime, throws a **`NullPointerException`** automatically.
    

**Example:**

```java
throw null;
```

**Output:** `NullPointerException`

---

### **26. Is it possible for a `catch` block to handle multiple unrelated exception types?**

- ✅ Yes, using **multi-catch** (`|` operator) as long as exceptions are **not in the same inheritance chain**.
    

**Example:**

```java
catch (IOException | NullPointerException e) { }
```

❌ Invalid: `catch (IOException | Exception e)` — `Exception` is a superclass.

---

### **27. Can you define an exception class without extending `Throwable`? What happens?**

- ❌ No. Only subclasses of `Throwable` can be thrown or caught.
    

**Example:**

```java
class MyError { }
throw new MyError(); // Compile-time error
```

✅ Must extend `Exception` or `Error`.

---

### **28. What happens if you catch `Error` or `Throwable` instead of specific exceptions?**

- Technically allowed, but **not recommended**.
    
- `Error` and `Throwable` include **severe system issues** (like `OutOfMemoryError`).
    

**Example:**

```java
catch (Throwable t) { System.out.println("Caught all"); }
```

✅ Works, but  
❌ Breaks good practice — can hide serious JVM problems and make recovery impossible.