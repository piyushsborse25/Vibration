### **126. What is Garbage Collection in Java?**

- **Garbage Collection (GC)** is the process of automatically reclaiming memory used by objects that are **no longer reachable** in the program.
    
- Java removes the need for explicit memory management (`free()` / `delete`).
    
- Managed by the **JVM**, not the developer.
    
- Helps prevent memory leaks and `OutOfMemoryError`.
    

---

### **127. How does the `finalize()` method work?**

- `finalize()` is a method in the `Object` class.
    
- Called by the **Garbage Collector** before reclaiming an object’s memory.
    
- Used for cleanup activities like closing files or releasing resources.
    
- Syntax:
    
    ```java
    @Override
    protected void finalize() throws Throwable {
        System.out.println("Object is garbage collected");
    }
    ```
    
- **Note:** Deprecated in Java 9; use `try-with-resources` or `Cleaner` instead.
    

---

### **128. How is Java memory managed?**

Java memory is divided into several areas managed by the JVM:

1. **Heap:** Stores objects and instance variables.
    
2. **Stack:** Stores method calls and local variables.
    
3. **Metaspace (or Method Area):** Stores class metadata, static variables, and method info.
    
4. **PC Register:** Tracks current instruction execution.
    
5. **Native Method Stack:** Used for native (non-Java) methods.
    

The **Garbage Collector** manages object lifecycle in the **Heap**.

---

### **129. What are the differences between Heap and Stack memory?**

|Aspect|Heap Memory|Stack Memory|
|---|---|---|
|Stores|Objects and instance variables|Method calls and local variables|
|Lifetime|Managed by GC|Created/destroyed with method calls|
|Thread Scope|Shared among threads|Each thread has its own stack|
|Speed|Slower (heap access)|Faster (stack operations)|
|Size|Larger|Smaller|

---

### **130. Why is Garbage Collection necessary in Java?**

- To **automatically free memory** occupied by unused objects.
    
- Prevents **manual deallocation errors** (like dangling pointers).
    
- Avoids **memory leaks** and improves overall stability.
    
- Ensures optimal memory utilization and performance.
    

---

### **131. What is the difference between minor, major, and full garbage collection?**

|Type|Region|Frequency|Description|
|---|---|---|---|
|**Minor GC**|Young Generation|Frequent|Cleans short-lived objects.|
|**Major GC**|Old Generation|Less frequent|Cleans long-lived objects.|
|**Full GC**|Entire Heap|Rare|Cleans both Young & Old generations; most expensive.|

---

### **132. What is a memory leak?**

- Occurs when objects **are no longer used** but still **referenced**, preventing GC.
    
- Causes heap to fill up → `OutOfMemoryError`.
    
- Example:
    
    ```java
    List<Object> list = new ArrayList<>();
    while(true) {
        list.add(new Object()); // keeps growing
    }
    ```
    
- Common causes:
    
    - Static references to large objects
        
    - Improper collection handling
        
    - Listeners not deregistered
        

---

### **133. What are soft, weak, and phantom references in Java?**

|Type|Collected When|Use Case|
|---|---|---|
|**SoftReference**|JVM needs memory|Memory-sensitive caching|
|**WeakReference**|Object is weakly reachable|Maps with auto-cleanup (WeakHashMap)|
|**PhantomReference**|After GC but before memory reclaim|Post-cleanup tracking|

---

### **134. How does Java handle memory leaks?**

- Java prevents most leaks via **automatic GC**, but developer must manage references properly.
    
- Techniques to avoid leaks:
    
    - Use **WeakReference** / **SoftReference** when appropriate.
        
    - Remove **event listeners** and **observers**.
        
    - Use **try-with-resources** for closing streams.
        
    - Use tools like **VisualVM**, **Eclipse MAT**, or **jconsole** to monitor heap usage.
        