Here are some commonly used **design patterns** along with their definitions and examples in **Java**. Let me know if you need implementations in another language.

---

# **1. Creational Patterns**
### **1.1 Singleton Pattern**
**Definition:** Ensures that a class has only one instance and provides a global access point.

**Example:**
```java
class Singleton {
    private static Singleton instance;

    private Singleton() {} // Private constructor

    public static synchronized Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }

    public void showMessage() {
        System.out.println("Singleton Instance");
    }
}

public class Main {
    public static void main(String[] args) {
        Singleton obj = Singleton.getInstance();
        obj.showMessage();
    }
}
```

---

### **1.2 Factory Method Pattern**
**Definition:** Defines an interface for creating an object but lets subclasses decide which class to instantiate.

**Example:**
```java
abstract class Vehicle {
    abstract void drive();
}

class Car extends Vehicle {
    void drive() {
        System.out.println("Driving a Car");
    }
}

class Bike extends Vehicle {
    void drive() {
        System.out.println("Riding a Bike");
    }
}

class VehicleFactory {
    static Vehicle getVehicle(String type) {
        if (type.equalsIgnoreCase("Car")) return new Car();
        else if (type.equalsIgnoreCase("Bike")) return new Bike();
        return null;
    }
}

public class Main {
    public static void main(String[] args) {
        Vehicle v = VehicleFactory.getVehicle("Car");
        v.drive();
    }
}
```

---

### **1.3 Builder Pattern**
**Definition:** Separates object construction from its representation.

**Example:**
```java
class Computer {
    private String CPU;
    private int RAM;
    private boolean hasGraphicsCard;

    static class Builder {
        private String CPU;
        private int RAM;
        private boolean hasGraphicsCard;

        public Builder setCPU(String CPU) {
            this.CPU = CPU;
            return this;
        }

        public Builder setRAM(int RAM) {
            this.RAM = RAM;
            return this;
        }

        public Builder setGraphicsCard(boolean hasGraphicsCard) {
            this.hasGraphicsCard = hasGraphicsCard;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }

    private Computer(Builder builder) {
        this.CPU = builder.CPU;
        this.RAM = builder.RAM;
        this.hasGraphicsCard = builder.hasGraphicsCard;
    }

    public void showConfig() {
        System.out.println("CPU: " + CPU + ", RAM: " + RAM + "GB, GraphicsCard: " + hasGraphicsCard);
    }
}

public class Main {
    public static void main(String[] args) {
        Computer pc = new Computer.Builder()
                .setCPU("Intel i7")
                .setRAM(16)
                .setGraphicsCard(true)
                .build();
        pc.showConfig();
    }
}
```

---

# **2. Structural Patterns**
### **2.1 Adapter Pattern**
**Definition:** Allows incompatible interfaces to work together.

**Example:**
```java
interface MediaPlayer {
    void play(String fileName);
}

class MP3Player implements MediaPlayer {
    public void play(String fileName) {
        System.out.println("Playing MP3 file: " + fileName);
    }
}

class MP4Player {
    void playMP4(String fileName) {
        System.out.println("Playing MP4 file: " + fileName);
    }
}

// Adapter
class MediaAdapter implements MediaPlayer {
    private MP4Player mp4Player;

    public MediaAdapter() {
        this.mp4Player = new MP4Player();
    }

    public void play(String fileName) {
        mp4Player.playMP4(fileName);
    }
}

public class Main {
    public static void main(String[] args) {
        MediaPlayer player = new MediaAdapter();
        player.play("video.mp4");
    }
}
```

---

### **2.2 Decorator Pattern**
**Definition:** Dynamically adds additional responsibilities to an object.

**Example:**
```java
interface Coffee {
    String getDescription();
    double cost();
}

class SimpleCoffee implements Coffee {
    public String getDescription() {
        return "Simple Coffee";
    }

    public double cost() {
        return 5;
    }
}

class MilkDecorator implements Coffee {
    private Coffee coffee;

    public MilkDecorator(Coffee coffee) {
        this.coffee = coffee;
    }

    public String getDescription() {
        return coffee.getDescription() + ", Milk";
    }

    public double cost() {
        return coffee.cost() + 2;
    }
}

public class Main {
    public static void main(String[] args) {
        Coffee coffee = new MilkDecorator(new SimpleCoffee());
        System.out.println(coffee.getDescription() + " - Cost: $" + coffee.cost());
    }
}
```

---

# **3. Behavioral Patterns**
### **3.1 Observer Pattern**
**Definition:** Defines a dependency between objects so that when one object changes state, all its dependents are notified.

**Example:**
```java
import java.util.ArrayList;
import java.util.List;

interface Observer {
    void update(String message);
}

class Subscriber implements Observer {
    private String name;

    public Subscriber(String name) {
        this.name = name;
    }

    public void update(String message) {
        System.out.println(name + " received update: " + message);
    }
}

class YouTubeChannel {
    private List<Observer> observers = new ArrayList<>();

    public void subscribe(Observer observer) {
        observers.add(observer);
    }

    public void notifySubscribers(String message) {
        for (Observer observer : observers) {
            observer.update(message);
        }
    }
}

public class Main {
    public static void main(String[] args) {
        YouTubeChannel channel = new YouTubeChannel();
        Observer user1 = new Subscriber("Alice");
        Observer user2 = new Subscriber("Bob");

        channel.subscribe(user1);
        channel.subscribe(user2);
        
        channel.notifySubscribers("New Video Uploaded!");
    }
}
```

---

### **3.2 Strategy Pattern**
**Definition:** Defines a family of algorithms and allows them to be interchangeable.

**Example:**
```java
interface PaymentStrategy {
    void pay(int amount);
}

class CreditCardPayment implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using Credit Card.");
    }
}

class PayPalPayment implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using PayPal.");
    }
}

class ShoppingCart {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void checkout(int amount) {
        paymentStrategy.pay(amount);
    }
}

public class Main {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();

        cart.setPaymentStrategy(new CreditCardPayment());
        cart.checkout(500);

        cart.setPaymentStrategy(new PayPalPayment());
        cart.checkout(300);
    }
}
```

---

### **Final Thoughts**
Each of these patterns solves a specific design problem efficiently. The right choice depends on the **project requirements** and **maintainability needs**.

Would you like me to generate UML diagrams or provide implementations in **Python** or **C++**? Let me know how you'd like to proceed! 🚀