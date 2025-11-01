### **29. What is the difference between stack memory and heap memory? Where are `static` variables stored?**

- **Stack Memory:**
    
    - Stores **method call frames**, **local variables**, and **references** to objects.
        
    - Memory is **LIFO-based** and thread-specific.
        
    - Automatically freed once the method exits.
        
- **Heap Memory:**
    
    - Stores **objects** and **instance variables**.
        
    - Shared among all threads.
        
    - Managed by the **Garbage Collector (GC)**.
        
- **Static Variables:**
    
    - Stored in the **Method Area (part of Metaspace in Java 8+)**.
        
    - Exists for the entire lifetime of the class.
        

**Example:**

```java
class Demo {
    static int s = 10; // Method Area
    int x = 5;         // Heap
    void show() {
        int y = 3;     // Stack
    }
}
```

---

### **30. Explain the lifecycle of an object in the JVM from creation to garbage collection.**

1. **Class Loading:** The class is loaded by the **ClassLoader**.
    
2. **Object Creation:** Memory allocated on the **Heap** using `new`.
    
3. **Reference Assignment:** A reference is stored in **Stack** memory.
    
4. **Usage:** Methods access the object via references.
    
5. **Dereferencing:** Reference goes out of scope or is reassigned.
    
6. **Garbage Collection:** GC detects unreachable objects and frees memory.
    
7. **Finalization (Deprecated):** Earlier used for cleanup before GC; now discouraged.
    

**Example:**

```java
Demo d = new Demo(); // Created
d = null;            // Eligible for GC
```

---

### **31. What is the purpose of the `finalize()` method? Why is it deprecated in Java?**

- The `finalize()` method was designed for **resource cleanup** before object destruction by GC.
    

**Example:**

```java
protected void finalize() throws Throwable {
    System.out.println("Cleanup");
}
```

- **Deprecated since Java 9** because:
    
    - Unpredictable (no guarantee when it runs).
        
    - Can cause memory leaks and performance issues.
        
    - Better alternatives:
        
        - Use `try-with-resources` or
            
        - Implement `AutoCloseable`.
            

---

### **32. Can you prevent an object from being garbage collected? If so, how?**

✅ Yes, indirectly by keeping a **reachable reference** to the object.

**Ways:**

1. **Keep object in a static field:**
    
    ```java
    static Demo obj = new Demo();
    ```
    
2. **Add to a data structure** (like a list or map).
    
3. **Use `ReferenceQueue` and `PhantomReference`** for controlled cleanup.
    

❌ No direct method to permanently prevent GC.

---

### **33. What is a memory leak in Java? Give examples of code that could lead to memory leaks.**

- A **memory leak** occurs when objects are **no longer needed but still referenced**, preventing GC.
    

**Examples:**

1. **Static Collection:**
    
    ```java
    static List<String> list = new ArrayList<>();
    void add() { list.add("data"); } // Never cleared
    ```
    
2. **Unclosed Resources:**
    
    ```java
    FileInputStream fis = new FileInputStream("file.txt");
    // not closed
    ```
    
3. **Listeners or Callbacks:**
    
    ```java
    obj.addListener(this); // Not removed later
    ```
    

✅ Use weak references, remove listeners, and close resources properly.

---

### **34. What is the role of `PermGen` space (pre-Java 8) vs `Metaspace` (Java 8+)? Why was this change introduced?**

|Feature|PermGen (≤ Java 7)|Metaspace (≥ Java 8)|
|---|---|---|
|Location|Java Heap|Native Memory|
|Stores|Class metadata, static variables, interned Strings|Class metadata|
|Size|Fixed, can cause `OutOfMemoryError: PermGen space`|Dynamically resizes|
|Configuration|`-XX:PermSize`|`-XX:MetaspaceSize`|

✅ **Reason for change:** PermGen was prone to memory errors; Metaspace offers **automatic sizing** and **better performance**.

---

### **35. How does the JVM handle method overloading and overriding at runtime?**

- **Overloading (Compile-time Polymorphism):**
    
    - Resolved at **compile time** using **method signature** and **parameter types**.
        
- **Overriding (Runtime Polymorphism):**
    
    - Resolved at **runtime** using the **object’s actual type** (dynamic dispatch).
        

**Example:**

```java
class A { void show() { System.out.println("A"); } }
class B extends A { void show() { System.out.println("B"); } }

A obj = new B();
obj.show(); // "B" -> resolved at runtime
```

---

### **36. Explain how the `invokedynamic` instruction works and how it improves performance.**

- Introduced in **Java 7** to support **dynamic languages (like Groovy, JRuby)** on JVM.
    
- Uses **method handles** to link calls at runtime instead of compile-time bytecode linking.
    

**Benefits:**

- Reduces overhead of reflection.
    
- Improves dynamic dispatch performance.
    
- Enables efficient lambda and stream operations.
    

**Example:**  
Used internally for lambda expressions:

```java
Runnable r = () -> System.out.println("Hello");
```

→ Compiled into an `invokedynamic` instruction linking the lambda at runtime.

---

### **37. What is escape analysis in JVM, and how does it optimize memory allocation?**

- **Escape Analysis** determines whether an object’s reference **escapes** a method or thread.
    

**Optimizations:**

1. **Stack Allocation:**  
    If object doesn’t escape, allocate on **stack** instead of heap.
    
2. **Lock Elimination:**  
    Remove synchronization when not shared between threads.
    

**Example:**

```java
void process() {
    Point p = new Point(10, 20); // may be stack-allocated
    p.display();
}
```

✅ Improves performance and reduces GC overhead.

---

### **38. What is the significance of the `-XX:+UseG1GC` JVM option? When would you use it?**

- Enables the **Garbage-First (G1) Garbage Collector**.
    
- Designed for **large heaps (multi-GB)** with **low pause time goals**.
    

**Features:**

- Divides heap into **regions** instead of contiguous generations.
    
- Performs **incremental parallel collection**.
    
- Predictable pause times.
    

**Use When:**  
You have large memory, want balanced throughput and low latency (e.g., server applications).

---

### **39. What happens if you dynamically load a class using `Class.forName()` vs static loading?**

|Type|Static Loading|Dynamic Loading|
|---|---|---|
|Trigger|At compile time|At runtime|
|Example|`new MyClass()`|`Class.forName("MyClass")`|
|Purpose|Regular instantiation|Load class dynamically (e.g., JDBC driver)|
|When used|Known at compile time|Unknown until runtime|

**Example:**

```java
Class.forName("com.mysql.jdbc.Driver"); // loads driver dynamically
```

✅ Useful for plugins, reflection, and frameworks.

---

### **40. How does the JVM optimize bytecode during runtime (JIT compilation)?**

- **JIT (Just-In-Time) Compiler** converts **bytecode → native machine code** at runtime.
    

**Phases:**

1. **HotSpot Detection:** Identifies frequently executed code.
    
2. **Compilation:** Converts hot methods to native code.
    
3. **Inlining, loop unrolling, escape analysis, constant folding** optimizations applied.
    

✅ Improves speed by avoiding repeated interpretation.

---

### **41. What is the difference between `Heap` and `Non-Heap` memory in the JVM?**

|Type|Contains|Managed By|
|---|---|---|
|**Heap**|Objects, arrays, instance fields|Garbage Collector|
|**Non-Heap**|Code cache, Metaspace, thread stacks, JNI memory|JVM itself|

✅ Non-heap stores **JIT-compiled code and metadata**, not subject to regular GC.

---

### **42. What is the role of the `Code Cache` area in the JVM?**

- Stores **compiled native code** generated by the **JIT compiler**.
    
- Helps JVM **execute hot methods faster**.
    

**Monitored by:**  
`-XX:ReservedCodeCacheSize` option.

**If full:**  
Performance drops as JVM reverts to **interpreted mode**.

---

### **43. Explain how method inlining works in the JVM and how it improves performance.**

- **Inlining** replaces a method call with the method’s actual body to **reduce call overhead**.
    

**Example:**

```java
void print() { System.out.println("Hi"); }
void test() { print(); } // may get inlined by JIT
```

**Benefits:**

- Removes call overhead.
    
- Enables further optimizations (like constant propagation).
    
- Improves CPU instruction locality.
    

**Controlled by:**  
`-XX:+PrintInlining` to observe and tune JIT behavior.