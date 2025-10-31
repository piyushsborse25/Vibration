### **29. What is an object-oriented paradigm?**

An **object-oriented paradigm** is a programming model based on the concept of **objects**, which contain both **data (fields)** and **behavior (methods)**.  
It focuses on modeling real-world entities into software objects.

**Key principle:** _Data and behavior should be bundled together._

**Example:**

```java
class Car {
    String color;
    void start() { System.out.println("Car started"); }
}
```

---

### **30. What are the main concepts of OOPs in Java?**

1. **Encapsulation** – Binding data and methods into a single unit (class).
    
2. **Abstraction** – Hiding internal implementation details and showing only functionality.
    
3. **Inheritance** – Acquiring properties and behaviors of another class.
    
4. **Polymorphism** – One interface, many implementations (method overloading & overriding).
    

---

### **31. What is the difference between an object-oriented programming language and an object-based programming language?**

|Aspect|Object-Oriented|Object-Based|
|---|---|---|
|**Supports OOP Principles**|All (Encapsulation, Inheritance, Polymorphism, Abstraction)|All except Inheritance|
|**Examples**|Java, C++, Python|JavaScript (before ES6), VBScript|
|**Extensibility**|Fully extensible via classes|Limited functionality|

---

### **32. What are Classes in Java?**

A **class** is a **blueprint** or **template** for creating objects.  
It defines variables (fields) and methods that describe the behavior of the object.

**Example:**

```java
class Student {
    int id;
    String name;
    void display() { System.out.println(id + " " + name); }
}
```

**Object Creation:**

```java
Student s1 = new Student();
```

---

### **33. What is the difference between a static (class) method and an instance method?**

|Feature|Static Method|Instance Method|
|---|---|---|
|**Belongs To**|Class|Object|
|**Accessed Using**|Class name|Object reference|
|**Can Access**|Only static data|Both static & instance data|
|**Memory**|Loaded once|Each object has its own copy|

**Example:**

```java
class Demo {
    static void showStatic() {}
    void showInstance() {}
}
```

---

### **34. Explain the concept of inheritance in Java.**

**Inheritance** allows one class to **acquire** properties and behavior of another class.

**Syntax:**

```java
class Parent { }
class Child extends Parent { }
```

**Benefits:**

- Code reuse
    
- Extensibility
    
- Method overriding for runtime polymorphism
    

---

### **35. What are the different types of inheritance in Java?**

1. **Single Inheritance** – One class inherits another.
    
2. **Multilevel Inheritance** – A → B → C
    
3. **Hierarchical Inheritance** – One parent, multiple children.
    
4. **Multiple Inheritance (via interfaces only)** – A class can implement multiple interfaces.
    

**Note:**  
Java doesn’t support multiple inheritance with classes to avoid ambiguity (Diamond Problem).

---

### **36. What is multiple inheritance? Is it supported by Java?**

- **Multiple inheritance:** When one class inherits from more than one parent class.
    
- **Not supported in Java** (using classes) to prevent ambiguity.
    
- **Supported via interfaces.**
    

**Example:**

```java
interface A { void show(); }
interface B { void show(); }
class C implements A, B {
    public void show() { System.out.println("Hello"); }
}
```

---

### **37. How is inheritance in C++ different from Java?**

|Aspect|Java|C++|
|---|---|---|
|**Multiple Inheritance**|Not allowed (via classes)|Allowed|
|**Root Class**|Every class inherits from `Object`|No universal root class|
|**Access Specifiers**|public, protected, private|public, protected, private, friend|
|**Virtual Keyword**|Not used|Required for polymorphism|
|**Constructors**|No explicit call to base constructor unless specified|Can call explicitly|

---

### **38. What is Polymorphism?**

Polymorphism means **many forms** — same method behaves differently based on context.

**Types:**

1. **Compile-time (Static):** Method Overloading
    
2. **Runtime (Dynamic):** Method Overriding
    

**Example:**

```java
class Shape {
    void draw() { System.out.println("Drawing shape"); }
}
class Circle extends Shape {
    void draw() { System.out.println("Drawing circle"); }
}
```

---

### **39. What is method overloading?**

**Method Overloading** → Multiple methods with the **same name but different parameters** (type, number, or order).

**Example:**

```java
class MathUtil {
    int add(int a, int b) { return a + b; }
    double add(double a, double b) { return a + b; }
}
```

Resolved **at compile time**.

---

### **40. What is method overriding?**

**Method Overriding** → Subclass provides a specific implementation of a superclass method.

**Rules:**

- Same method name, parameters, and return type.
    
- Must be in a subclass.
    
- Access modifier can’t be more restrictive.
    

**Example:**

```java
class Parent {
    void show() { System.out.println("Parent"); }
}
class Child extends Parent {
    void show() { System.out.println("Child"); }
}
```

Resolved **at runtime**.

---

### **41. What is Abstraction?**

Abstraction hides implementation details and exposes only functionality.

**Example:**  
You use a car’s steering without knowing its internal working.

**In Java:**

- Using **abstract classes** or **interfaces**.
    

---

### **42. What is an abstract class?**

A class declared with `abstract` keyword.  
It **cannot be instantiated** and can contain **abstract methods** (no body).

**Example:**

```java
abstract class Shape {
    abstract void draw();
    void info() { System.out.println("Shape info"); }
}
```

**Used when:**  
You want to provide **partial implementation** and leave some behavior to subclasses.

---

### **43. What is an interface?**

An **interface** is a blueprint of a class containing only **abstract methods** (till Java 7), and **default/static methods** (from Java 8).

**Syntax:**

```java
interface Drawable {
    void draw();
}
class Circle implements Drawable {
    public void draw() { System.out.println("Circle drawn"); }
}
```

**Key Points:**

- All methods are **public** and **abstract** by default.
    
- Variables are **public static final**.
    
- Supports **multiple inheritance**.
    

---

### **44. What are the differences between abstract class and interface?**

|Feature|Abstract Class|Interface|
|---|---|---|
|**Keyword**|`abstract`|`interface`|
|**Methods**|Can have abstract & concrete|Only abstract (till Java 7)|
|**Variables**|Can be any type|Always `public static final`|
|**Inheritance**|Single inheritance|Multiple inheritance|
|**Constructor**|Can have one|Cannot have one|
|**Use Case**|When classes share behavior|When defining contracts|

---

### **45. What do you mean by data encapsulation?**

**Encapsulation** = Wrapping data (variables) and methods into a single unit (class).  
It restricts direct access to data, protecting it from unintended changes.

**Example:**

```java
class Account {
    private double balance;
    public double getBalance() { return balance; }
    public void deposit(double amount) { balance += amount; }
}
```

---

### **46. What are the advantages of Encapsulation in Java?**

1. **Data Hiding** – Restricts unauthorized access.
    
2. **Security** – Protects object integrity.
    
3. **Flexibility** – Changes can be made internally without affecting other code.
    
4. **Maintainability** – Easier debugging and updates.
    
5. **Modularity** – Each class acts as an independent module.
    