## ✅ 1. **Singleton Pattern**

### 🔹 Intent:  
Ensure a class has **only one instance**, and provide global access to it.

### 📦 Example: Logger

```java
class Logger {
    private static Logger instance = null;

    private Logger() {} // private constructor

    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger(); // lazy init
        }
        return instance;
    }

    public void log(String message) {
        System.out.println("[LOG]: " + message);
    }
}
```

```java
// Client
public class Main {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        logger1.log("First log");

        System.out.println(logger1 == logger2); // true
    }
}
```

---

## ✅ 2. **Factory Method Pattern**

### 🔹 Intent:  
Define an interface for creating an object, but let subclasses decide which class to instantiate.

### 📦 Example: Shape Factory

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    public void draw() {
        System.out.println("Drawing a Circle");
    }
}

class Square implements Shape {
    public void draw() {
        System.out.println("Drawing a Square");
    }
}
```

```java
class ShapeFactory {
    public Shape getShape(String type) {
        if (type.equalsIgnoreCase("circle")) return new Circle();
        if (type.equalsIgnoreCase("square")) return new Square();
        return null;
    }
}
```

```java
// Client
public class Main {
    public static void main(String[] args) {
        ShapeFactory factory = new ShapeFactory();
        Shape shape = factory.getShape("circle");
        shape.draw(); // Output: Drawing a Circle
    }
}
```

---

## ✅ 3. **Abstract Factory Pattern**

### 🔹 Intent:  
Produce families of related objects without specifying their concrete classes.

### 📦 Example: UI Factory for Windows/Mac

```java
interface Button {
    void click();
}

class WinButton implements Button {
    public void click() {
        System.out.println("Windows Button Clicked");
    }
}

class MacButton implements Button {
    public void click() {
        System.out.println("Mac Button Clicked");
    }
}
```

```java
interface GUIFactory {
    Button createButton();
}

class WinFactory implements GUIFactory {
    public Button createButton() {
        return new WinButton();
    }
}

class MacFactory implements GUIFactory {
    public Button createButton() {
        return new MacButton();
    }
}
```

```java
// Client
public class Main {
    public static void main(String[] args) {
        GUIFactory factory = new WinFactory(); // or MacFactory
        Button button = factory.createButton();
        button.click(); // Output: Windows Button Clicked
    }
}
```

---

## ✅ 4. **Builder Pattern**

### 🔹 Intent:  
Separate object construction from its representation.

### 📦 Example: Building a Custom Pizza

```java
class Pizza {
    String dough;
    String cheese;
    String topping;

    public String toString() {
        return dough + ", " + cheese + ", " + topping;
    }
}
```

```java
class PizzaBuilder {
    private Pizza pizza = new Pizza();

    public PizzaBuilder setDough(String dough) {
        pizza.dough = dough;
        return this;
    }

    public PizzaBuilder setCheese(String cheese) {
        pizza.cheese = cheese;
        return this;
    }

    public PizzaBuilder setTopping(String topping) {
        pizza.topping = topping;
        return this;
    }

    public Pizza build() {
        return pizza;
    }
}
```

```java
// Client
public class Main {
    public static void main(String[] args) {
        Pizza pizza = new PizzaBuilder()
                        .setDough("Thin Crust")
                        .setCheese("Mozzarella")
                        .setTopping("Pepperoni")
                        .build();

        System.out.println(pizza); // Thin Crust, Mozzarella, Pepperoni
    }
}
```

---

## ✅ 5. **Prototype Pattern**

### 🔹 Intent:  
Clone objects instead of creating them from scratch.

### 📦 Example: Cloning a Document

```java
class Document implements Cloneable {
    String text;

    public Document(String text) {
        this.text = text;
    }

    public Document clone() {
        try {
            return (Document) super.clone();
        } catch (CloneNotSupportedException e) {
            return null;
        }
    }

    public String toString() {
        return text;
    }
}
```

```java
// Client
public class Main {
    public static void main(String[] args) {
        Document doc1 = new Document("Original");
        Document doc2 = doc1.clone();

        doc2.text = "Copy";

        System.out.println(doc1); // Original
        System.out.println(doc2); // Copy
    }
}
```