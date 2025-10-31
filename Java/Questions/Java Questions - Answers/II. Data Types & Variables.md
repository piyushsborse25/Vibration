### **16. Explain different data types in Java.**

Java data types are divided into **two categories:**

#### **A. Primitive Data Types** (8 total)

|Type|Size|Range|Default Value|Description|
|---|---|---|---|---|
|**byte**|1 byte|-128 to 127|0|Small integers (used in streams or memory-saving)|
|**short**|2 bytes|-32,768 to 32,767|0|For small integers|
|**int**|4 bytes|-2³¹ to 2³¹-1|0|Commonly used integer type|
|**long**|8 bytes|-2⁶³ to 2⁶³-1|0L|Large integer values|
|**float**|4 bytes|~3.4e–38 to 3.4e+38|0.0f|Single precision decimal|
|**double**|8 bytes|~1.7e–308 to 1.7e+308|0.0d|Double precision decimal|
|**char**|2 bytes|'\u0000' to '\uffff'|'\u0000'|Unicode character|
|**boolean**|1 bit (JVM dependent)|true/false|false|Logical values|

#### **B. Non-Primitive (Reference) Data Types**

Includes:

- **Classes**
    
- **Interfaces**
    
- **Arrays**
    
- **Strings**
    
- **Enums**
    

These store **references (addresses)** to actual objects in memory.

---

### **17. When is the `byte` datatype used?**

`byte` is used when:

- You need to **save memory** (e.g., large arrays).
    
- You work with **binary data**, file I/O, or **streams**.
    
- You represent **raw data** like images, network packets.
    

**Example:**

```java
byte age = 25;
byte[] buffer = new byte[1024]; // for reading file data
```

---

### **18. Can we declare Pointers in Java?**

❌ **No, Java does not support pointers** like C/C++.

- Java uses **references** instead.
    
- Memory access is **managed by JVM**, ensuring safety and security.
    
- Prevents memory corruption and unsafe pointer arithmetic.
    

---

### **19. What is the default value of the `byte` datatype in Java?**

Default value = **0**

**Example:**

```java
class Example {
    byte b;
    void print() { System.out.println(b); } // prints 0
}
```

---

### **20. What is the default value of `float` and `double` datatypes in Java?**

- **float → 0.0f**
    
- **double → 0.0d**
    

**Example:**

```java
float f;
double d;
System.out.println(f); // 0.0
System.out.println(d); // 0.0
```

---

### **21. What is the Wrapper class in Java?**

Wrapper classes are **object representations** of primitive data types.  
Each primitive has a corresponding class in `java.lang`.

|Primitive|Wrapper Class|
|---|---|
|byte|Byte|
|short|Short|
|int|Integer|
|long|Long|
|float|Float|
|double|Double|
|char|Character|
|boolean|Boolean|

**Example:**

```java
int a = 10;
Integer obj = Integer.valueOf(a); // Boxing
int b = obj;                      // Unboxing
```

---

### **22. Why do we need Wrapper classes?**

- For using primitives in **Collections** (`ArrayList`, `HashMap`, etc.) – they store only objects.
    
- For **object manipulation** (e.g., methods in `Integer`, `Double`).
    
- For **type conversion** (`String` ↔ `int`, etc.).
    
- For **Autoboxing/Unboxing** convenience introduced in Java 5.
    

---

### **23. Differentiate between instance and local variables.**

|Feature|Instance Variable|Local Variable|
|---|---|---|
|**Scope**|Belongs to an object|Exists within a method/constructor|
|**Memory**|Stored in Heap|Stored in Stack|
|**Default Value**|Has default value|No default value (must initialize)|
|**Access**|Accessible through object|Accessible only within method|

**Example:**

```java
class Demo {
    int x; // instance variable
    void show() {
        int y = 5; // local variable
    }
}
```

---

### **24. What are the default values assigned to variables and instances in Java?**

Only **instance and static variables** have default values.  
**Local variables** must be explicitly initialized before use.

|Type|Default Value|
|---|---|
|byte, short, int, long|0|
|float, double|0.0f / 0.0d|
|char|'\u0000'|
|boolean|false|
|Object references|null|

---

### **25. What are static methods and variables in Java?**

**Static variables:**

- Shared across all objects.
    
- Belong to the class, not any instance.
    

**Static methods:**

- Can be called without creating an object.
    
- Can access only static data (no instance variables).
    

**Example:**

```java
class Counter {
    static int count = 0;
    Counter() { count++; }
    static void showCount() {
        System.out.println(count);
    }
}
```

---

### **26. What is the default value stored in Local Variables?**

❌ **No default value.**  
Local variables **must be initialized** before use.

**Example:**

```java
void test() {
    int x;
    System.out.println(x); // Compilation error
}
```

---

### **27. Explain the difference between instance variable and class variable.**

|Aspect|Instance Variable|Class (Static) Variable|
|---|---|---|
|**Declaration**|Without `static` keyword|With `static` keyword|
|**Memory Location**|Heap|Method area (class memory)|
|**Belongs To**|Specific object|Entire class|
|**Access**|Through object|Through class name|
|**Copy per Object**|Each object gets its own|Only one shared copy|

**Example:**

```java
class Student {
    int id;            // instance
    static String college = "IIT"; // class variable
}
```

---

### **28. What is a static variable?**

A **static variable** is shared among all instances of a class.

- Declared using the `static` keyword.
    
- Memory allocated once, when the class is loaded.
    
- Useful for constants or counters.
    

**Example:**

```java
class Employee {
    static String company = "Deloitte";
    int id;
}
```

All `Employee` objects share the same `company` name.