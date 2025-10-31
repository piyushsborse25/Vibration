### **47. Explain the `this` keyword in Java.**

- The `this` keyword is a **reference variable** that refers to the **current object** in a method or constructor.
    
- **Uses of `this`:**
    
    1. **Differentiate instance variables** from local variables with same names.
        
        ```java
        class Employee {
            int id;
            Employee(int id) { this.id = id; } // 'this.id' refers to instance variable
        }
        ```
        
    2. **Invoke another constructor** in the same class using `this()`.
        
    3. **Pass the current object** as an argument to another method or constructor.
        
    4. **Return the current object** from a method (method chaining).
        

---

### **48. What is the `final` keyword in Java?**

The `final` keyword is used to **restrict modification or inheritance**.

- **final variable:** Value cannot be reassigned after initialization.
    
    ```java
    final int MAX = 100;
    ```
    
- **final method:** Cannot be overridden by subclasses.
    
- **final class:** Cannot be inherited. Example: `String` class.  
    👉 Ensures immutability and prevents alteration in behavior.
    

---

### **49. What is the `super` keyword in Java?**

- `super` is used to refer to the **immediate parent class object**.
    
- **Uses:**
    
    1. **Access parent class variables or methods** hidden by subclass.
        
    2. **Invoke parent class constructor** using `super()`.
        
    3. **Call overridden parent methods**.
        

Example:

```java
class Parent { int x = 10; }
class Child extends Parent {
    int x = 20;
    void show() { System.out.println(super.x); } // prints 10
}
```

---

### **50. What are access modifiers in Java?**

Access modifiers define **visibility or accessibility** of classes, methods, and variables.

|Modifier|Within Class|Within Package|Subclass (Diff. Package)|Outside Package|
|---|---|---|---|---|
|**private**|✅|❌|❌|❌|
|**default** (no keyword)|✅|✅|❌|❌|
|**protected**|✅|✅|✅|❌|
|**public**|✅|✅|✅|✅|

---

### **51. What is covariant return type?**

- It allows an **overridden method** to return a **subtype** of the return type declared in the parent method.
    
- Enhances **type safety** and avoids **explicit casting**.
    

Example:

```java
class A { A get() { return this; } }
class B extends A { B get() { return this; } } // Covariant return
```

---

### **52. What is the transient keyword?**

- Used in **serialization** to mark fields **not to be serialized**.
    
- Transient fields are skipped while writing the object to a stream.
    

Example:

```java
class User implements Serializable {
    transient String password; // Will not be serialized
}
```

✅ Useful for security-sensitive or temporary data.

---

### **53. What are operators?**

Operators are **symbols** that perform operations on variables and values.  
Examples: `+`, `-`, `*`, `/`, `==`, `&&`, `++`, etc.

---

### **54. How many types of operators are available in Java?**

Java has **8 types of operators**:

1. **Arithmetic** → `+`, `-`, `*`, `/`, `%`
    
2. **Unary** → `++`, `--`, `+`, `-`, `!`
    
3. **Assignment** → `=`, `+=`, `-=`, `*=`, `/=`
    
4. **Relational** → `==`, `!=`, `>`, `<`, `>=`, `<=`
    
5. **Logical** → `&&`, `||`, `!`
    
6. **Bitwise** → `&`, `|`, `^`, `~`, `<<`, `>>`, `>>>`
    
7. **Ternary (Conditional)** → `?:`
    
8. **Instanceof** → Checks object type (`obj instanceof ClassName`)
    

---

### **55. Explain the difference between `>>` and `>>>` operators.**

Both are **bitwise right shift** operators.

|Operator|Type|Description|Example (for `int a = -8`)|
|---|---|---|---|
|`>>`|Signed right shift|Preserves the **sign bit** (fills left bits with sign).|`a >> 2` → `-2`|
|`>>>`|Unsigned right shift|Fills left bits with **0**, ignores sign.|`a >>> 2` → `1073741822`|

---

### **56. What is the dot operator?**

- The `.` (dot) operator is used to **access members** of a class (fields, methods) or packages.  
    Examples:
    

```java
object.method();
System.out.println(java.util.List.class);
```

---

### **57. What is the difference between `this()` and `super()` in Java?**

|Feature|`this()`|`super()`|
|---|---|---|
|Purpose|Calls another constructor in the **same class**|Calls parent class constructor|
|Position|Must be the **first statement** in a constructor|Must be the **first statement** in a constructor|
|Access|Refers to **current class**|Refers to **parent class**|
|Example|`this(10);`|`super(10);`|

**Example:**

```java
class A {
    A() { System.out.println("A"); }
}
class B extends A {
    B() { this("Hello"); }
    B(String s) { super(); System.out.println(s); }
}
```

**Output:**

```
A
Hello
```