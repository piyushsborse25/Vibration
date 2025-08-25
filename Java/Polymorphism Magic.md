### **1. Method Hiding vs Overriding with `static` Methods**
```java
class Parent {
    static void staticMethod() {
        System.out.println("Parent static method");
    }

    void instanceMethod() {
        System.out.println("Parent instance method");
    }
}

class Child extends Parent {
    static void staticMethod() {
        System.out.println("Child static method");
    }

    @Override
    void instanceMethod() {
        System.out.println("Child instance method");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        p.staticMethod();    // Output: Parent static method (method hiding, not polymorphism)
        p.instanceMethod();  // Output: Child instance method (runtime polymorphism)
    }
}
```

**Explanation**:  
- `staticMethod()` is hidden, not overridden, so the method resolution is based on the reference type (`Parent`).
- `instanceMethod()` is overridden, so the runtime object (`Child`) determines the method called.

---

### **2. Fields Are Not Polymorphic**
```java
class Parent {
    String name = "Parent";
}

class Child extends Parent {
    String name = "Child";
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        System.out.println(p.name); // Output: Parent
    }
}
```

**Explanation**:  
Fields in Java are **not polymorphic**, meaning they are resolved based on the reference type (`Parent`), not the runtime object.

---

### **3. Overloaded vs Overridden Methods**
```java
class Parent {
    void method(int x) {
        System.out.println("Parent method with int");
    }
}

class Child extends Parent {
    void method(double x) { // Overloading, not overriding
        System.out.println("Child method with double");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        p.method(10); // Output: Parent method with int
    }
}
```

**Explanation**:  
The method in `Child` takes a `double`, so it **does not override** the `Parent` method. The method call is resolved based on the reference type (`Parent`), and the `Parent` method is executed.

---

### **4. Casting and `instanceof`**
```java
class Parent {
    void method() {
        System.out.println("Parent method");
    }
}

class Child extends Parent {
    void method() {
        System.out.println("Child method");
    }

    void childSpecificMethod() {
        System.out.println("Child-specific method");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        p.method(); // Output: Child method (polymorphism)

        if (p instanceof Child) {
            Child c = (Child) p;
            c.childSpecificMethod(); // Output: Child-specific method
        }

        // Unsafe cast
        Parent anotherParent = new Parent();
        // Child anotherChild = (Child) anotherParent; // Runtime ClassCastException
    }
}
```

**Explanation**:  
- The `instanceof` operator ensures that the cast is safe before attempting to call methods specific to `Child`.
- If you cast a `Parent` object that is not actually a `Child` object, you will get a `ClassCastException`.

---

### **5. Final Methods Can't Be Overridden**
```java
class Parent {
    final void finalMethod() {
        System.out.println("Parent final method");
    }
}

class Child extends Parent {
    // void finalMethod() { // Compile-time error: Cannot override final method
    //     System.out.println("Child final method");
    // }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        p.finalMethod(); // Output: Parent final method
    }
}
```

**Explanation**:  
A `final` method in a class cannot be overridden by subclasses.

---

### **6. Constructors and Polymorphism**
```java
class Parent {
    Parent() {
        System.out.println("Parent constructor");
        overriddenMethod();
    }

    void overriddenMethod() {
        System.out.println("Parent overriddenMethod");
    }
}

class Child extends Parent {
    Child() {
        System.out.println("Child constructor");
    }

    @Override
    void overriddenMethod() {
        System.out.println("Child overriddenMethod");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
    }
}
```

**Output**:
```
Parent constructor
Child overriddenMethod
Child constructor
```

**Explanation**:  
- During the `Parent` constructor call, the `overriddenMethod()` from `Child` is invoked because polymorphism applies even during construction.  
- **Gotcha**: Be cautious with overridden methods in constructors, as the subclass object may not yet be fully initialized.

---

### **7. Interfaces and Default Methods**
```java
interface ParentInterface {
    default void method() {
        System.out.println("ParentInterface method");
    }
}

class Child implements ParentInterface {
    @Override
    public void method() {
        System.out.println("Child method");
    }
}

public class Main {
    public static void main(String[] args) {
        ParentInterface p = new Child();
        p.method(); // Output: Child method
    }
}
```

**Explanation**:  
Default methods in interfaces can be overridden by implementing classes. The runtime object (`Child`) determines the method executed.

---

### **8. Abstract Class vs Interface**
```java
abstract class Parent {
    abstract void abstractMethod();

    void concreteMethod() {
        System.out.println("Parent concrete method");
    }
}

class Child extends Parent {
    @Override
    void abstractMethod() {
        System.out.println("Child abstract method");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        p.abstractMethod();  // Output: Child abstract method
        p.concreteMethod();  // Output: Parent concrete method
    }
}
```

**Explanation**:  
- Abstract methods must be implemented by the subclass.
- Concrete methods in the abstract class can be directly called via the parent reference.\