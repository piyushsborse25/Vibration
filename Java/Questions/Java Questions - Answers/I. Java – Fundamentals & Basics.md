### **1. What are memory storages available with JVM?**

JVM divides its memory into several runtime areas:

1. **Method Area**
    
    - Stores class-level data: class names, method info, static variables, runtime constant pool, etc.
        
    - Shared among all threads.
        
    - Also known as _Metaspace_ (from Java 8 onward).
        
2. **Heap Area**
    
    - Stores all Java objects and their instance variables.
        
    - Divided into:
        
        - **Young Generation** (Eden + Survivor spaces)
            
        - **Old Generation**
            
    - Garbage Collector works mainly here.
        
3. **Stack Area**
    
    - Each thread has its own stack.
        
    - Stores method frames → local variables, partial results, and return addresses.
        
    - Memory is freed automatically after method execution.
        
4. **PC (Program Counter) Register**
    
    - Holds the address of the currently executing JVM instruction for each thread.
        
5. **Native Method Stack**
    
    - Used for native (non-Java) methods, typically written in C/C++.
        

---

### **2. What is a ClassLoader?**

A **ClassLoader** is a part of JVM responsible for loading Java classes into memory dynamically at runtime.  
It loads `.class` files and converts bytecode into `Class` objects.

**Types:**

1. **Bootstrap ClassLoader** → Loads core Java classes from `rt.jar` (like `java.lang`, `java.util`).
    
2. **Extension (Platform) ClassLoader** → Loads classes from `ext` folder.
    
3. **Application (System) ClassLoader** → Loads classes from the classpath defined by the user.
    

**Example:**

```java
ClassLoader loader = String.class.getClassLoader();  // returns null → loaded by Bootstrap
```

**Concept:**  
Follows **parent delegation model** → Each ClassLoader first delegates the loading request to its parent before trying itself.

---

### **3. Is Java Platform Independent? If yes, how?**

Yes. Java achieves platform independence through **bytecode** and **JVM**.

**Explanation:**

- Source Code → compiled by `javac` → `.class` bytecode file.
    
- Bytecode is a platform-neutral intermediate code.
    
- Any JVM (Windows/Linux/Mac) can execute this same bytecode.
    

**Tagline:** _“Write Once, Run Anywhere.”_

---

### **4. What are the top Java Features?**

|Feature|Description|
|---|---|
|**Simple**|Easy syntax; no pointers or header files.|
|**Object-Oriented**|Everything is an object (except primitives).|
|**Platform Independent**|Bytecode runs on any JVM.|
|**Secure**|No explicit memory access; uses bytecode verifier and Security Manager.|
|**Robust**|Strong memory management and exception handling.|
|**Multithreaded**|Built-in thread support (`Thread` class, `Runnable`).|
|**Portable**|Same output across OS; architecture-neutral.|
|**High Performance**|Uses Just-In-Time (JIT) compiler.|
|**Distributed**|Supports RMI and EJB for networked applications.|

---

### **5. What is JVM?**

**Java Virtual Machine (JVM)** is an abstract machine that executes Java bytecode.  
It provides the **runtime environment** and handles:

- Memory management (heap, stack)
    
- Garbage collection
    
- Bytecode interpretation or JIT compilation
    
- Thread management
    
- Exception handling
    

**Flow:**  
`.java` → compiled by `javac` → `.class` → executed by **JVM**

---

### **6. What is JDK?**

**JDK (Java Development Kit)** = JRE + development tools.

**Includes:**

- Compiler (`javac`)
    
- Debugger
    
- JavaDoc tool
    
- JAR creator
    
- Libraries and JVM
    

It’s required to **develop, compile, and run** Java programs.

---

### **7. Differences between JVM, JRE, and JDK**

|Component|Description|Contains|
|---|---|---|
|**JVM**|Executes bytecode; provides runtime environment.|Part of JRE|
|**JRE**|Environment to run Java programs.|JVM + Libraries|
|**JDK**|Full suite for development.|JRE + Development Tools|

**Analogy:**

> JDK = JRE + tools,  
> JRE = JVM + libraries.

---

### **8. Differences between Java and C++**

|Aspect|Java|C++|
|---|---|---|
|Platform Dependency|Platform-independent|Platform-dependent|
|Memory Management|Automatic (Garbage Collector)|Manual (delete, free)|
|Multiple Inheritance|Not supported (only via interfaces)|Supported|
|Pointers|Not exposed to developers|Explicitly used|
|Compilation|Compiles to bytecode|Compiles to native machine code|
|Exception Handling|Mandatory for checked exceptions|Optional|
|Architecture|Runs on JVM|Runs directly on OS|

---

### **9. Explain `public static void main(String args[])` in Java**

This is the **entry point** of any Java program.

- **public** → JVM needs to access it from outside the class.
    
- **static** → Can be called without creating an object.
    
- **void** → No return value expected.
    
- **main** → Standard method name recognized by JVM.
    
- **String[] args** → Stores command-line arguments.
    

**Example:**

```java
public static void main(String[] args) {
    System.out.println("Hello, Java!");
}
```

---

### **10. What is Java String Pool?**

A **String Pool** (or String Intern Pool) is a special memory region in the heap where **string literals** are stored.

If two string literals are identical, they point to the same memory reference to save space.

**Example:**

```java
String s1 = "Java";
String s2 = "Java";
System.out.println(s1 == s2); // true → same reference
```

**Note:** Strings created with `new String("Java")` are stored in heap (not pool).

---

### **11. What if the main method is not static?**

If `main()` is not static, the JVM cannot call it without creating an object, which is not possible before program start.

**Result:**  
`Error: NoSuchMethodError: main`

---

### **12. What are Packages in Java?**

Packages are **namespaces** that group related classes and interfaces.  
They help organize code like folders in a directory.

**Example:**

```java
package com.example.utils;
public class Calculator { }
```

You can import it using:

```java
import com.example.utils.Calculator;
```

---

### **13. Why are Packages used?**

- To **avoid naming conflicts** (e.g., same class names in different packages).
    
- To **organize** classes logically.
    
- To **control access** (via `public`, `protected`).
    
- To **reuse code** efficiently.
    

---

### **14. Advantages of Packages**

1. Code reusability
    
2. Namespace management (avoids class name collisions)
    
3. Access protection using access modifiers
    
4. Easier project modularization
    
5. Improves maintainability
    

---

### **15. Types of Packages**

1. **Built-in Packages:**
    
    - Predefined Java packages (e.g., `java.lang`, `java.util`, `java.io`, `java.sql`).
        
    - Example:
        
        ```java
        import java.util.List;
        ```
        
2. **User-defined Packages:**
    
    - Created by developers for project structure.
        
    - Example:
        
        ```java
        package com.myapp.service;
        ```
        