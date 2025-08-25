When a constructor throws an exception in Java, **the object does not get fully created**. Here's what happens step-by-step:

---

### **1. Constructor and Exception**
- If an exception is thrown during the execution of a constructor, the object initialization is interrupted.
- Memory is allocated for the object when the `new` keyword is used, but if the constructor fails, the allocated memory is **discarded** and the object is not created.

---

### **2. Key Points**
- The exception propagates to the calling code.
- No reference to the object is returned because the object was never fully initialized.
- Any partially initialized resources in the constructor (like opening files, database connections, etc.) need to be cleaned up manually, as Java does not handle this automatically.

---

### **3. Example**
```java
class MyClass {
    MyClass() throws Exception {
        System.out.println("Constructor started");
        throw new Exception("Something went wrong!");
    }
}

public class Main {
    public static void main(String[] args) {
        try {
            MyClass obj = new MyClass();
        } catch (Exception e) {
            System.out.println("Exception caught: " + e.getMessage());
        }
    }
}
```

**Output**:
```
Constructor started
Exception caught: Something went wrong!
```

**Explanation**:
- The `new MyClass()` call starts the constructor, but the exception interrupts the process, and the object is not created.
- The exception is propagated to the calling code, and `obj` remains uninitialized.

---

### **4. Does the Object Exist?**
No, the object does **not exist** after a constructor throws an exception. If you try to use the object reference, you'll get a **compiler error** because it was never assigned a value.

```java
MyClass obj = null;
try {
    obj = new MyClass(); // Constructor throws an exception
} catch (Exception e) {
    System.out.println("Exception caught");
}

// obj is still null because the constructor failed
System.out.println(obj); // Output: null
```

---

### **5. Special Case: Exception in Parent Class Constructor**
When a child class constructor calls a parent class constructor (via `super()`), and the parent class constructor throws an exception, the child class object will also fail to initialize.

```java
class Parent {
    Parent() throws Exception {
        System.out.println("Parent constructor");
        throw new Exception("Parent exception");
    }
}

class Child extends Parent {
    Child() throws Exception {
        super();
        System.out.println("Child constructor");
    }
}

public class Main {
    public static void main(String[] args) {
        try {
            Child obj = new Child();
        } catch (Exception e) {
            System.out.println("Exception caught: " + e.getMessage());
        }
    }
}
```

**Output**:
```
Parent constructor
Exception caught: Parent exception
```

**Explanation**:
- Since the parent class constructor fails, the child class constructor never executes, and the child object is not created.

---

### **6. Cleaning Up Resources**
If a constructor throws an exception, any partially initialized resources need to be released manually, as Java won't do it for you.

#### Example with Resource Management:
```java
class MyClass {
    MyClass() throws Exception {
        System.out.println("Constructor started");
        try {
            throw new Exception("Something went wrong!");
        } finally {
            System.out.println("Cleaning up resources");
        }
    }
}

public class Main {
    public static void main(String[] args) {
        try {
            MyClass obj = new MyClass();
        } catch (Exception e) {
            System.out.println("Exception caught: " + e.getMessage());
        }
    }
}
```

**Output**:
```
Constructor started
Cleaning up resources
Exception caught: Something went wrong!
```

**Explanation**:
- The `finally` block ensures that cleanup happens, even though the object creation failed.

---

### **7. Best Practices**
- Avoid heavy resource allocation in constructors. Instead, use factory methods or an initialization method to handle this.
- Always clean up resources (e.g., files, sockets) in case of a constructor failure.
- Consider using `try-catch` blocks inside the constructor to handle recoverable errors, or propagate the exception if it makes sense.

---

### **Conclusion**
- If a constructor throws an exception, the object is **not created**, and any reference to it will remain `null`.
- Proper resource management is essential to prevent resource leaks when exceptions occur during object creation.