### **1. Can you override a private or static method in Java?**

- **Private methods:**
    
    - Not inherited by subclasses → cannot be overridden.
        
    - Defining a same-named method in subclass simply hides it.
        
- **Static methods:**
    
    - Belong to the **class**, not the instance.
        
    - Resolved at **compile time** → not subject to runtime polymorphism.
        
    - Redefining them in subclass is called **method hiding**, not overriding.
        

**Example:**

```java
class Parent {
    private void msg() { System.out.println("Parent"); }
    static void greet() { System.out.println("Static Parent"); }
}
class Child extends Parent {
    private void msg() { System.out.println("Child"); }
    static void greet() { System.out.println("Static Child"); }
}
```

✅ **Static or private methods cannot be overridden.**

---

### **2. What is the diamond problem in inheritance, and how does Java resolve it with interfaces?**

- The **diamond problem** arises in **multiple inheritance** when a class inherits the same method from multiple paths, creating ambiguity.
    
- Java **avoids** it for classes (single inheritance only).
    
- With **interfaces**, if two interfaces define the same **default method**, the implementing class must **override** it explicitly to resolve the conflict.
    

**Example:**

```java
interface A { default void hello() { System.out.println("A"); } }
interface B { default void hello() { System.out.println("B"); } }

class C implements A, B {
    public void hello() { A.super.hello(); } // explicitly resolved
}
```

✅ Prevents ambiguity while allowing flexible multiple inheritance via interfaces.

---

### **3. Explain the difference between IS-A and HAS-A relationships in Java.**

- **IS-A (Inheritance):** Defines a _“type of”_ relationship using `extends` or `implements`.
    
    ```java
    class Vehicle { }
    class Car extends Vehicle { } // Car IS-A Vehicle
    ```
    
    Promotes **code reuse** and **polymorphism**.
    
- **HAS-A (Composition/Aggregation):** Defines a _“has or uses”_ relationship by including another object.
    
    ```java
    class Engine { }
    class Car { private Engine engine = new Engine(); } // Car HAS-A Engine
    ```
    

|Aspect|IS-A|HAS-A|
|---|---|---|
|Implementation|Inheritance|Composition|
|Coupling|Tight|Loose|
|Polymorphism|Supported|Not applicable|
|Flexibility|Less|More|

✅ Prefer **composition over inheritance** for maintainable designs.

---

### **4. What happens if a constructor throws an exception? Does the object get created?**

- If a **constructor throws an exception**, the **object is not created**.
    
- The partially initialized object is discarded, and its memory is reclaimed by JVM.
    
- The thrown exception propagates to the caller.
    

**Example:**

```java
class Demo {
    Demo() throws Exception {
        System.out.println("Init...");
        throw new Exception("Constructor failed");
    }
    public static void main(String[] args) {
        try { new Demo(); } 
        catch (Exception e) { System.out.println(e.getMessage()); }
    }
}
```

**Output:**

```
Init...
Constructor failed
```

✅ Ensures object integrity — partially constructed objects never exist.

---

### **5. Can you call a constructor of a class multiple times for the same object?**

- ❌ **No**, constructors are called only **once** during object creation.
    
- You cannot re-invoke the constructor manually for the same object.
    
- Use **`this()`** or **`super()`** inside constructors to chain initialization, but only once and as the **first statement**.
    

**Example:**

```java
class Demo {
    Demo() { System.out.println("Default"); }
    Demo(int x) { this(); System.out.println("Param: " + x); }
}
```

✅ For reinitialization, use separate methods like `init()` or setters.

---

### **6. What happens if a subclass has a method with the same name as a private method in the superclass?**

- The subclass method is treated as a **completely new method**, not an override.
    
- Private methods are **not visible** to subclasses → no polymorphism.
    
- The two methods belong to different method tables in JVM.
    

**Example:**

```java
class Parent {
    private void show() { System.out.println("Parent show"); }
}
class Child extends Parent {
    void show() { System.out.println("Child show"); } // new method
}
```

✅ Calling `new Child().show()` calls child’s version only.

---

### **7. Can you declare an abstract class without any abstract methods? Why would you do that?**

- ✅ Yes, an **abstract class can have no abstract methods**.
    
- It cannot be instantiated but can provide **base implementation**, **common logic**, or **partial abstraction**.
    
- Useful for **template patterns** or **restricted inheritance**.
    

**Example:**

```java
abstract class Shape {
    void draw() { System.out.println("Drawing..."); }
}
```

✅ Common base class behavior without direct instantiation.

---

### **8. How does Java achieve runtime polymorphism? Can method overloading achieve the same?**

- Java achieves **runtime polymorphism** through **method overriding**.
    
- Decision of which method to execute occurs at **runtime** based on the actual object’s type, not reference type.
    
- Implemented via **dynamic dispatch**.
    

**Example:**

```java
class Animal { void sound() { System.out.println("Animal"); } }
class Dog extends Animal { void sound() { System.out.println("Dog"); } }

Animal a = new Dog();
a.sound(); // Dog
```

- **Overloading** is **compile-time polymorphism** — resolved by method signatures at compile time.  
    ✅ Only **overriding** provides true runtime polymorphism.
    

---

### **9. If a class implements two interfaces with the same default method, how does Java resolve the conflict?**

- If two interfaces provide the **same default method**, the implementing class must **override it** to avoid ambiguity.
    
- You can invoke a specific interface’s method using `InterfaceName.super.method()`.
    

**Example:**

```java
interface A { default void log() { System.out.println("A"); } }
interface B { default void log() { System.out.println("B"); } }

class C implements A, B {
    public void log() { A.super.log(); } // choose A
}
```

✅ Explicit override ensures predictable behavior.

---

### **10. What happens if a superclass constructor calls an overridden method in a subclass? What are the risks?**

- When a superclass constructor calls an **overridden method**, the **subclass’s version** executes.
    
- But since subclass fields aren’t yet initialized, this can cause **NullPointerException** or **inconsistent state**.
    

**Example:**

```java
class Parent {
    Parent() { show(); } // calls overridden method
    void show() { System.out.println("Parent show"); }
}
class Child extends Parent {
    String name = "Tom";
    void show() { System.out.println(name.length()); } // risky
}
```

✅ _Risk:_ Avoid calling overridable methods inside constructors.

---

### **11. Can you have a class that is both `final` and `abstract`? Why or why not?**

- ❌ **No**, a class cannot be both `final` and `abstract`.
    
- `final` → class **cannot be extended**.
    
- `abstract` → class **must be extended** to provide implementation.
    
- Both contradict each other.
    

✅ Example:

```java
final abstract class Test { } // Compilation error
```

---

### **12. Is it possible to cast an object of one type to another unrelated type? Under what conditions?**

- ❌ You cannot directly cast **unrelated types** — it throws `ClassCastException`.
    
- Only allowed if the objects are part of the **same inheritance hierarchy**.
    
- However, **interfaces** can sometimes enable casting if implemented by both classes.
    

**Example:**

```java
Object o = "Hello";
String s = (String) o;  // valid
Integer i = (Integer) o; // ClassCastException
```

✅ Always use `instanceof` before casting to ensure type safety.

---

### **13. What is the difference between composition and inheritance? Why prefer composition over inheritance?**

- **Inheritance (IS-A):**
    
    - Subclass inherits behavior and structure of superclass.
        
    - Tight coupling — subclass depends heavily on superclass.
        
- **Composition (HAS-A):**
    
    - Class contains objects of other classes and delegates behavior.
        
    - More flexible — behavior can be changed at runtime.
        

**Example:**

```java
class Engine { void start() { System.out.println("Engine on"); } }
class Car { 
    private Engine engine = new Engine(); 
    void start() { engine.start(); } 
}
```

✅ Prefer **composition over inheritance** for modularity, testability, and reusability.

---

### **14. Can you create an instance of an abstract class in Java? If yes, how?**

- ❌ You cannot **directly instantiate** an abstract class.
    
- ✅ But you can **create an anonymous subclass** or use **concrete subclass** to instantiate.
    

**Example 1 (Anonymous class):**

```java
abstract class Animal { abstract void sound(); }

Animal dog = new Animal() {
    void sound() { System.out.println("Bark"); }
};
dog.sound();
```

**Example 2 (Concrete subclass):**

```java
class Dog extends Animal { void sound() { System.out.println("Bark"); } }
Animal a = new Dog(); // valid
```

✅ Abstract classes act as **blueprints**, not complete objects.
