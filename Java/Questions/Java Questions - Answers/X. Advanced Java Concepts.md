### **135. What are Functional Interfaces in Java?**

- An interface with **exactly one abstract method**.
    
- Can have **default** and **static** methods too.
    
- Used as the **target type for lambda expressions**.
    
- Annotated with `@FunctionalInterface`.
    
- Examples: `Runnable`, `Callable`, `Comparator`, `Consumer`, `Supplier`.
    
    ```java
    @FunctionalInterface
    interface Calculator {
        int add(int a, int b);
    }
    ```
    

---

### **136. What is a Lambda Expression in Java?**

- A **shorter way to represent anonymous functions** (functions without names).
    
- Introduced in **Java 8**.
    
- Syntax:
    
    ```java
    (parameters) -> expression
    (a, b) -> a + b
    ```
    
- Used to write cleaner and more concise code, especially with **Streams** and **functional interfaces**.
    

---

### **137. Explain Stream API in Java.**

- Introduced in **Java 8** for **functional-style data processing**.
    
- Operates on **collections** and **arrays**.
    
- Supports **filtering, mapping, reducing, sorting** etc.
    
- Two operations:
    
    - **Intermediate:** `filter()`, `map()`, `sorted()`
        
    - **Terminal:** `collect()`, `forEach()`, `count()`
        
    
    ```java
    list.stream()
        .filter(x -> x > 10)
        .map(x -> x * 2)
        .forEach(System.out::println);
    ```
    

---

### **138. What are the differences between Serialization and Deserialization?**

|Process|Description|Method|
|---|---|---|
|**Serialization**|Converting object → byte stream|`ObjectOutputStream.writeObject()`|
|**Deserialization**|Converting byte stream → object|`ObjectInputStream.readObject()`|

- Class must implement `Serializable` interface.
    
- Used to persist or transfer object data.
    

---

### **139. What is Reflection in Java?**

- Mechanism to **inspect and manipulate classes, methods, fields, and constructors** at runtime.
    
- Part of `java.lang.reflect` package.
    
- Example:
    
    ```java
    Class<?> c = Class.forName("MyClass");
    Method m = c.getDeclaredMethod("show");
    m.invoke(c.newInstance());
    ```
    
- Used in frameworks (e.g., Spring, Hibernate) for dependency injection and configuration.
    

---

### **140. What are Annotations in Java?**

- Metadata that provides information to the compiler or runtime.
    
- Does not affect program logic directly.
    
- Built-in: `@Override`, `@Deprecated`, `@SuppressWarnings`.
    
- Custom annotations can be defined using `@interface`.
    
- Used heavily in frameworks (Spring Boot, JUnit, etc.).
    

---

### **141. What is the Singleton Design Pattern?**

- Ensures **only one instance** of a class exists globally.
    
- Provides **global access point** to it.
    
- Implementation:
    
    ```java
    public class Singleton {
        private static Singleton instance;
        private Singleton() {}
        public static synchronized Singleton getInstance() {
            if (instance == null) instance = new Singleton();
            return instance;
        }
    }
    ```
    

---

### **142. Explain Factory Design Pattern.**

- **Creational pattern** that creates objects without exposing creation logic to the client.
    
- Uses a **factory method** to return instances.
    
    ```java
    class ShapeFactory {
        Shape getShape(String type) {
            if(type.equals("CIRCLE")) return new Circle();
            else if(type.equals("SQUARE")) return new Square();
            return null;
        }
    }
    ```
    
- Promotes loose coupling and code reusability.
    

---

### **143. Explain the concept of `volatile` in Java.**

- Declares a variable as **stored in main memory**, not CPU cache.
    
- Ensures **visibility** of changes across threads.
    
- Prevents caching issues in concurrent environments.
    
    ```java
    private volatile boolean flag = true;
    ```
    

---

### **144. What are the types of Class Loaders in Java?**

|Type|Description|
|---|---|
|**Bootstrap ClassLoader**|Loads core Java classes (`java.lang.*`).|
|**Extension ClassLoader**|Loads classes from `jre/lib/ext`.|
|**System/Application ClassLoader**|Loads application classes from classpath.|
|**Custom ClassLoader**|User-defined loader for dynamic loading.|

---

### **145. How does Java `HashMap` work internally?**

- Uses **hashing** to store key-value pairs.
    
- Each entry stored in a **bucket** (array + linked list/tree).
    
- Process:
    
    1. Compute hash code of key → bucket index.
        
    2. If bucket empty → add entry.
        
    3. If collision → use `equals()` to compare keys.
        
    4. From Java 8 → if bucket size > 8 → converts to **balanced tree** (Red-Black Tree) for performance.
        

---

### **146. Explain the difference between `Comparable` and `Comparator`.**

|Aspect|`Comparable`|`Comparator`|
|---|---|---|
|Package|`java.lang`|`java.util`|
|Method|`compareTo()`|`compare()`|
|Sorting Logic|Defined in the same class|Defined externally|
|Used For|Natural order|Custom order|
|Example|`Collections.sort(list)`|`Collections.sort(list, comparator)`|

---

### **147. What is the difference between shallow and deep cloning?**

|Type|Description|
|---|---|
|**Shallow Clone**|Copies object reference only; nested objects share same references.|
|**Deep Clone**|Creates full copy of object and its nested objects.|

- Shallow: `Object.clone()`
    
- Deep: Custom logic or serialization-based cloning.
    

---

### **148. What are the differences between Java 8 and Java 11?**

|Feature|Java 8|Java 11|
|---|---|---|
|LTS|Yes|Yes|
|Key Features|Lambdas, Streams, Optional|HTTP Client API, `var` in lambda, String methods|
|JRE|Present|Removed (merged into JDK)|
|Modules|Absent|Inherited from Java 9|
|Licensing|Free (Oracle & OpenJDK)|Oracle JDK commercial, OpenJDK free|

---

### **149. What is the Module System in Java 9?**

- Known as **Project Jigsaw**.
    
- Introduced modularization of JDK and user apps.
    
- Each module explicitly declares **dependencies** and **exports**.
    
- File: `module-info.java`
    
    ```java
    module com.example.app {
        requires java.sql;
        exports com.example.app.services;
    }
    ```
    
- Improves **security**, **encapsulation**, and **startup performance**.
    

---

### **150. What is the Java Memory Model (JMM)?**

- Defines how **threads interact through memory**.
    
- Specifies **visibility** and **ordering** of variable updates.
    
- Guarantees:
    
    - Changes by one thread are visible to others (via `volatile`, `synchronized`).
        
    - Prevents reordering of operations that can break thread safety.
        
- Crucial for understanding **concurrency**, **locks**, and **atomic operations**.
    