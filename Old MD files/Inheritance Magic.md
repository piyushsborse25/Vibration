### **1. Order of Initialization (Static vs Instance Blocks)**  
```java
class Parent {
    static {
        System.out.println("Parent static block");
    }

    {
        System.out.println("Parent instance block");
    }

    Parent() {
        System.out.println("Parent constructor");
    }
}

class Child extends Parent {
    static {
        System.out.println("Child static block");
    }

    {
        System.out.println("Child instance block");
    }

    Child() {
        System.out.println("Child constructor");
    }
}

public class Main {
    public static void main(String[] args) {
        new Child();
    }
}
```

**Output**:
```
Parent static block
Child static block
Parent instance block
Parent constructor
Child instance block
Child constructor
```

**Explanation**:
- **Static blocks** are executed first, but only once per class (from parent to child).
- Then **instance blocks** and constructors are executed for the parent, followed by the child.

---

### **2. Covariant Return Types**
```java
class Parent {
    Parent getInstance() {
        return this;
    }
}

class Child extends Parent {
    @Override
    Child getInstance() {
        return this;
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        System.out.println(p.getInstance().getClass().getSimpleName()); // Output: Child
    }
}
```

**Explanation**:
- Java supports **covariant return types**, meaning an overridden method can return a subtype of the original return type.

---

### **3. Calling `super` and Overridden Methods**
```java
class Parent {
    void method() {
        System.out.println("Parent method");
    }
}

class Child extends Parent {
    @Override
    void method() {
        System.out.println("Child method");
        super.method();
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        p.method(); 
        // Output:
        // Child method
        // Parent method
    }
}
```

**Explanation**:
- You can use `super.method

()` in the child class to explicitly call the parent class's version of an overridden method, even if runtime polymorphism directs calls to the child’s method.

---

### **4. Deadly Diamond Problem (Interface Default Methods)**

```java
interface A {
    default void method() {
        System.out.println("A's method");
    }
}

interface B extends A {
    @Override
    default void method() {
        System.out.println("B's method");
    }
}

interface C extends A {
    @Override
    default void method() {
        System.out.println("C's method");
    }
}

class D implements B, C {
    @Override
    public void method() {
        B.super.method(); // Resolving ambiguity by choosing B's method
        C.super.method(); // Also calling C's method explicitly
    }
}

public class Main {
    public static void main(String[] args) {
        D obj = new D();
        obj.method();
        // Output:
        // B's method
        // C's method
    }
}
```

**Explanation**:
- When a class implements multiple interfaces with conflicting default methods, the implementing class must **override and resolve the ambiguity** explicitly using `InterfaceName.super.method()`.

---

### **5. Final Variables in Constructors**
```java
class Parent {
    final int x;

    Parent(int x) {
        this.x = x;
    }
}

class Child extends Parent {
    Child() {
        super(42);
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        System.out.println(p.x); // Output: 42
    }
}
```

**Explanation**:
- A `final` variable must be initialized at declaration or in the constructor. It cannot be modified after being initialized.

---

### **6. Exception Handling with Overridden Methods**
```java
class Parent {
    void method() throws Exception {
        System.out.println("Parent method");
    }
}

class Child extends Parent {
    @Override
    void method() {
        System.out.println("Child method");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent p = new Child();
        try {
            p.method(); // Output: Child method
        } catch (Exception e) {
            System.out.println("Exception handled");
        }
    }
}
```

**Explanation**:
- A child class can override a method but **cannot declare broader or new checked exceptions** than the parent method. In this case, `Child` removes the exception completely, which is valid.

---

### **7. Inner Class Quirks**
```java
class Outer {
    class Inner {
        void innerMethod() {
            System.out.println("Inner method");
        }
    }
}

public class Main {
    public static void main(String[] args) {
        Outer outer = new Outer();
        Outer.Inner inner = outer.new Inner();
        inner.innerMethod(); // Output: Inner method
    }
}
```

**Explanation**:
- Non-static inner classes are tied to an instance of the outer class, so you need an outer class instance to create the inner class object.

---

### **8. Constructor Chaining**
```java
class Parent {
    Parent() {
        this(42);
        System.out.println("Parent no-arg constructor");
    }

    Parent(int x) {
        System.out.println("Parent constructor with arg: " + x);
    }
}

class Child extends Parent {
    Child() {
        super();
        System.out.println("Child no-arg constructor");
    }
}

public class Main {
    public static void main(String[] args) {
        new Child();
        // Output:
        // Parent constructor with arg: 42
        // Parent no-arg constructor
        // Child no-arg constructor
    }
}
```

**Explanation**:
- Constructors can call each other using `this()` or `super()`, but the `this()` call must be the first statement in a constructor. Here, `Parent` chains its constructors before `Child` completes its own constructor.

---

### **9. Generic Type Erasure**
```java
class Generic<T> {
    T obj;

    void set(T obj) {
        this.obj = obj;
    }

    T get() {
        return obj;
    }
}

public class Main {
    public static void main(String[] args) {
        Generic<String> g = new Generic<>();
        g.set("Hello");
        System.out.println(g.get()); // Output: Hello

        // Reflection and type erasure quirk
        Generic raw = g; // Raw type
        raw.set(42); // Compiles fine, but unsafe
        System.out.println(g.get()); // Runtime exception: ClassCastException
    }
}
```

**Explanation**:
- Generics are implemented using **type erasure** at runtime, meaning the type parameter (`T`) is replaced with `Object`. This is why raw types can lead to runtime errors.

---

### **10. Immutable Objects**
```java
final class Immutable {
    private final int x;

    Immutable(int x) {
        this.x = x;
    }

    public int getX() {
        return x;
    }
}

public class Main {
    public static void main(String[] args) {
        Immutable obj = new Immutable(42);
        System.out.println(obj.getX()); // Output: 42
    }
}
```

**Trick**:
Even though `Immutable` is immutable, it can still contain mutable objects, making it *not truly immutable*:

```java
final class NotReallyImmutable {
    private final int[] arr;

    NotReallyImmutable(int[] arr) {
        this.arr = arr;
    }

    public int[] getArray() {
        return arr;
    }
}

public class Main {
    public static void main(String[] args) {
        int[] data = {1, 2, 3};
        NotReallyImmutable obj = new NotReallyImmutable(data);

        data[0] = 99; // Mutates the "immutable" object
        System.out.println(obj.getArray()[0]); // Output: 99
    }
}
```