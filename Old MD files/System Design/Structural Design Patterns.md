## ✅ 1. **Adapter Pattern**

### 🧠 Intent:
Convert one interface into another the client expects.

### 📦 Example: Power Plug Adapter

```java
// Target interface
interface EuropeanPlug {
    void power();
}

// Adaptee
class USPlug {
    public void connect() {
        System.out.println("US plug connected.");
    }
}

// Adapter
class PlugAdapter implements EuropeanPlug {
    private USPlug usPlug;

    public PlugAdapter(USPlug usPlug) {
        this.usPlug = usPlug;
    }

    public void power() {
        usPlug.connect();
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        EuropeanPlug plug = new PlugAdapter(new USPlug());
        plug.power(); // US plug connected.
    }
}
```

---

## ✅ 2. **Bridge Pattern**

### 🧠 Intent:
Separate abstraction from implementation so both can vary independently.

### 📦 Example: Remote Control with Devices

```java
// Implementor
interface Device {
    void turnOn();
}

// Concrete Implementors
class TV implements Device {
    public void turnOn() {
        System.out.println("TV turned on");
    }
}

class Radio implements Device {
    public void turnOn() {
        System.out.println("Radio turned on");
    }
}
```

```java
// Abstraction
abstract class Remote {
    protected Device device;

    public Remote(Device device) {
        this.device = device;
    }

    public abstract void pressButton();
}

// Refined Abstraction
class BasicRemote extends Remote {
    public BasicRemote(Device device) {
        super(device);
    }

    public void pressButton() {
        device.turnOn();
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Remote remote = new BasicRemote(new TV());
        remote.pressButton(); // TV turned on
    }
}
```

---

## ✅ 3. **Composite Pattern**

### 🧠 Intent:
Treat individual objects and compositions uniformly.

### 📦 Example: File System (Files and Folders)

```java
interface FileSystem {
    void show();
}

class File implements FileSystem {
    private String name;

    public File(String name) {
        this.name = name;
    }

    public void show() {
        System.out.println("File: " + name);
    }
}
```

```java
class Folder implements FileSystem {
    private String name;
    private List<FileSystem> children = new ArrayList<>();

    public Folder(String name) {
        this.name = name;
    }

    public void add(FileSystem component) {
        children.add(component);
    }

    public void show() {
        System.out.println("Folder: " + name);
        for (FileSystem fs : children) {
            fs.show();
        }
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Folder root = new Folder("Root");
        root.add(new File("file1.txt"));
        root.add(new File("file2.txt"));

        Folder subFolder = new Folder("Sub");
        subFolder.add(new File("file3.txt"));

        root.add(subFolder);
        root.show();
    }
}
```

---

## ✅ 4. **Decorator Pattern**

### 🧠 Intent:
Add responsibilities to an object dynamically.

### 📦 Example: Coffee with Toppings

```java
interface Coffee {
    String make();
}

class SimpleCoffee implements Coffee {
    public String make() {
        return "Plain Coffee";
    }
}
```

```java
abstract class CoffeeDecorator implements Coffee {
    protected Coffee coffee;

    public CoffeeDecorator(Coffee coffee) {
        this.coffee = coffee;
    }
}

class MilkDecorator extends CoffeeDecorator {
    public MilkDecorator(Coffee coffee) {
        super(coffee);
    }

    public String make() {
        return coffee.make() + ", Milk";
    }
}

class SugarDecorator extends CoffeeDecorator {
    public SugarDecorator(Coffee coffee) {
        super(coffee);
    }

    public String make() {
        return coffee.make() + ", Sugar";
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Coffee coffee = new SugarDecorator(new MilkDecorator(new SimpleCoffee()));
        System.out.println(coffee.make()); // Plain Coffee, Milk, Sugar
    }
}
```

---

## ✅ 5. **Facade Pattern**

### 🧠 Intent:
Provide a unified interface to a set of interfaces in a subsystem.

### 📦 Example: Home Theater Facade

```java
class Lights {
    public void dim() {
        System.out.println("Lights dimmed");
    }
}

class Screen {
    public void down() {
        System.out.println("Screen down");
    }
}

class Projector {
    public void on() {
        System.out.println("Projector on");
    }
}
```

```java
class HomeTheaterFacade {
    private Lights lights = new Lights();
    private Screen screen = new Screen();
    private Projector projector = new Projector();

    public void watchMovie() {
        lights.dim();
        screen.down();
        projector.on();
        System.out.println("Movie started");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        HomeTheaterFacade theater = new HomeTheaterFacade();
        theater.watchMovie();
    }
}
```

---

## ✅ 6. **Flyweight Pattern**

### 🧠 Intent:
Minimize memory usage by sharing as much data as possible.

### 📦 Example: Character Formatting

```java
class Character {
    private char symbol;
    private String font;

    public Character(char symbol, String font) {
        this.symbol = symbol;
        this.font = font;
    }

    public void print() {
        System.out.println(symbol + " in " + font);
    }
}
```

```java
class CharacterFactory {
    private static Map<String, Character> pool = new HashMap<>();

    public static Character getCharacter(char symbol, String font) {
        String key = symbol + font;
        pool.putIfAbsent(key, new Character(symbol, font));
        return pool.get(key);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Character c1 = CharacterFactory.getCharacter('a', "Arial");
        Character c2 = CharacterFactory.getCharacter('a', "Arial");

        System.out.println(c1 == c2); // true (shared)
        c1.print(); // a in Arial
    }
}
```

---

## ✅ 7. **Proxy Pattern**

### 🧠 Intent:
Provide a surrogate to control access to another object.

### 📦 Example: Internet Proxy

```java
interface Internet {
    void connectTo(String site);
}

class RealInternet implements Internet {
    public void connectTo(String site) {
        System.out.println("Connecting to " + site);
    }
}
```

```java
class ProxyInternet implements Internet {
    private RealInternet realInternet = new RealInternet();
    private List<String> blockedSites = List.of("facebook.com", "twitter.com");

    public void connectTo(String site) {
        if (blockedSites.contains(site)) {
            System.out.println("Access denied to " + site);
        } else {
            realInternet.connectTo(site);
        }
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Internet internet = new ProxyInternet();
        internet.connectTo("example.com");     // Allowed
        internet.connectTo("facebook.com");    // Blocked
    }
}
```