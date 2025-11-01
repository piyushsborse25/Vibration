### **90. What are the differences between `static` and instance initialization blocks?**

|Feature|`static` block|Instance block|
|---|---|---|
|When executed|Once per class load|Every time an object is created|
|Purpose|Initialize static data|Initialize instance data|
|Access|Can access only static members|Can access both instance and static members|

**Example:**

```java
class Demo {
    static { System.out.println("Static Block"); }
    { System.out.println("Instance Block"); }
}
```

**Output:**

```
Static Block
Instance Block
Instance Block
```

✅ **Static blocks** run once; **instance blocks** run for every object.

---

### **91. What is the order of execution for `static` blocks, instance blocks, and constructors?**

**Order:**

1. Static blocks (once when class loads)
    
2. Instance initialization blocks (per object)
    
3. Constructor (after instance block)
    

**Example:**

```java
class Test {
    static { System.out.println("Static"); }
    { System.out.println("Instance"); }
    Test() { System.out.println("Constructor"); }
    public static void main(String[] args) { new Test(); }
}
```

**Output:**

```
Static
Instance
Constructor
```

✅ The JVM ensures static members initialize before any instance is created.

---

### **92. What are the different types of class loaders in Java? How do they work?**

**Main Types:**

1. **Bootstrap ClassLoader:**
    
    - Loads core Java classes (`java.lang`, `java.util`).
        
    - Implemented in native code (C/C++).
        
2. **Extension (Platform) ClassLoader:**
    
    - Loads classes from `lib/ext` or system extensions.
        
3. **Application (System) ClassLoader:**
    
    - Loads classes from the classpath (user code, libraries).
        

**Example:**

```java
ClassLoader cl = String.class.getClassLoader(); // returns null (Bootstrap)
```

✅ Class loaders form a hierarchy and follow **Parent Delegation Model**.

---

### **93. What happens if a static variable is accessed before the class is loaded?**

- Accessing a static variable **triggers class loading** and **initialization**.
    
- JVM loads class if not already loaded and runs all **static blocks**.
    

**Example:**

```java
class Demo {
    static int x = init();
    static int init() {
        System.out.println("Class Loaded");
        return 5;
    }
}
public class Main {
    public static void main(String[] args) {
        System.out.println(Demo.x); // triggers loading
    }
}
```

✅ JVM guarantees initialization before first active use.

---

### **94. Explain the difference between eager and lazy initialization with examples.**

|Type|Description|Example|
|---|---|---|
|**Eager Initialization**|Object created immediately|`static Singleton s = new Singleton();`|
|**Lazy Initialization**|Object created when first needed|`if (s == null) s = new Singleton();`|

**Example:**

```java
class Singleton {
    private static Singleton instance;
    private Singleton() {}
    public static Singleton getInstance() {
        if (instance == null) instance = new Singleton(); // lazy
        return instance;
    }
}
```

✅ Lazy saves memory; eager ensures thread safety by default.

---

### **95. How does the parent delegation model work in Java class loading? Can it be overridden?**

- **Mechanism:**
    
    1. A class loader delegates loading request to its parent first.
        
    2. If parent fails → child attempts loading.
        
- **Purpose:**  
    Prevents duplicate loading of core classes (e.g., `java.lang.String`).
    
- **Example (simplified):**
    
    ```java
    public Class<?> loadClass(String name) {
        try { return parent.loadClass(name); }
        catch (ClassNotFoundException e) { return findClass(name); }
    }
    ```
    

✅ **Overridable:** Yes, custom class loaders can bypass delegation, but not recommended for core types.

---

### **96. What is the difference between `bootstrap`, `extension`, and `application` class loaders?**

|Loader|Loads From|Parent|Example|
|---|---|---|---|
|**Bootstrap**|`JAVA_HOME/lib`|None|`java.lang.*`|
|**Extension (Platform)**|`JAVA_HOME/lib/ext`|Bootstrap|`javax.*`|
|**Application (System)**|Classpath|Platform|User classes|

**Example:**

```java
System.out.println(ClassLoader.getSystemClassLoader());
```

✅ Each builds upon its parent, ensuring isolation and security.

---

### **97. How would you use a custom class loader to load classes at runtime?**

1. Extend `ClassLoader`.
    
2. Override `findClass()`.
    
3. Use `defineClass()` to convert bytes to `Class<?>`.
    

**Example:**

```java
class MyClassLoader extends ClassLoader {
    protected Class<?> findClass(String name) throws ClassNotFoundException {
        byte[] bytes = loadClassData(name); // custom logic
        return defineClass(name, bytes, 0, bytes.length);
    }
}
```

✅ Enables plugin systems, dynamic modules, and sandboxing.

---

### **98. What happens if two different class loaders load the same class? Are the objects compatible?**

❌ **No.**  
Each class loader defines a **unique namespace**.

**Example:**

```java
Class<?> c1 = loader1.loadClass("com.test.MyClass");
Class<?> c2 = loader2.loadClass("com.test.MyClass");
System.out.println(c1 == c2); // false
```

✅ Even though bytecode is identical, they are **treated as distinct types**.

---

### **99. Can you dynamically reload a class in Java? How?**

✅ **Yes**, using:

- **Custom ClassLoader** that reloads new bytecode versions.
    
- **Frameworks like Spring Boot DevTools or OSGi** that manage reloads.
    

**Approach:**  
Unload old class loader → load new version with a new loader.

⚠️ JVM doesn’t allow unloading individual classes, only entire loaders.

---

### **100. What is the difference between `NoClassDefFoundError` and `ClassNotFoundException`?**

|Exception|Type|Cause|
|---|---|---|
|`ClassNotFoundException`|Checked|Class not found during **dynamic loading** (`Class.forName()`)|
|`NoClassDefFoundError`|Error|Class found at compile-time but **missing at runtime**|

**Example:**

```java
Class.forName("X"); // ClassNotFoundException
new X(); // NoClassDefFoundError
```

✅ One is recoverable (exception), the other is a fatal JVM error.

---

### **101. Can you load a class twice in Java using custom class loaders?**

✅ **Yes**, but only through **different class loader instances**.  
Each loader maintains a separate namespace.

**Example:**

```java
Class<?> c1 = loader1.loadClass("Test");
Class<?> c2 = loader2.loadClass("Test");
System.out.println(c1 == c2); // false
```

✅ Useful for reloading plugins or isolated modules.

---

### **102. What happens if the `main()` method is declared as `private`? Will it execute?**

✅ **Yes.**  
JVM uses **reflection** to invoke `main()` — access modifiers don’t restrict it.

**Example:**

```java
class Test {
    private static void main(String[] args) {
        System.out.println("Runs fine!");
    }
}
```

**Output:**  
`Runs fine!`

✅ JVM looks for signature, not access level.

---

### **103. Can a static block throw exceptions? How does the JVM handle it?**

✅ **Yes**, a static block can throw exceptions, but **only unchecked** ones (e.g., `RuntimeException`).

- Checked exceptions cause a **compilation error**.
    
- If unchecked exception occurs, JVM throws:
    
    ```
    ExceptionInInitializerError
    ```
    

**Example:**

```java
class Test {
    static { int x = 5 / 0; }
    public static void main(String[] args) {}
}
```

**Output:**

```
ExceptionInInitializerError
```

✅ JVM halts class initialization if the static block fails.