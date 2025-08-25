## ✅ 1. **Strategy Pattern**

### 🧠 Intent:
Select an algorithm at runtime.

### 📦 Example: Payment Strategy

```java
interface PaymentStrategy {
    void pay(int amount);
}

class CreditCardPayment implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using Credit Card");
    }
}

class PayPalPayment implements PaymentStrategy {
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using PayPal");
    }
}
```

```java
class PaymentContext {
    private PaymentStrategy strategy;

    public void setStrategy(PaymentStrategy strategy) {
        this.strategy = strategy;
    }

    public void checkout(int amount) {
        strategy.pay(amount);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();
        context.setStrategy(new CreditCardPayment());
        context.checkout(100);
    }
}
```

---

## ✅ 2. **Observer Pattern**

### 🧠 Intent:
Define a one-to-many dependency.

### 📦 Example: News Publisher

```java
interface Observer {
    void update(String news);
}

class Subscriber implements Observer {
    private String name;

    public Subscriber(String name) {
        this.name = name;
    }

    public void update(String news) {
        System.out.println(name + " received: " + news);
    }
}
```

```java
class NewsPublisher {
    private List<Observer> observers = new ArrayList<>();

    public void subscribe(Observer o) {
        observers.add(o);
    }

    public void publish(String news) {
        for (Observer o : observers) {
            o.update(news);
        }
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        NewsPublisher publisher = new NewsPublisher();
        publisher.subscribe(new Subscriber("Alice"));
        publisher.subscribe(new Subscriber("Bob"));
        publisher.publish("New episode released!");
    }
}
```

---

## ✅ 3. **Command Pattern**

### 🧠 Intent:
Encapsulate a request as an object.

### 📦 Example: Remote Control

```java
interface Command {
    void execute();
}

class Light {
    public void on() {
        System.out.println("Light turned ON");
    }
}
```

```java
class LightOnCommand implements Command {
    private Light light;

    public LightOnCommand(Light light) {
        this.light = light;
    }

    public void execute() {
        light.on();
    }
}

class RemoteControl {
    private Command command;

    public void setCommand(Command command) {
        this.command = command;
    }

    public void pressButton() {
        command.execute();
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Light light = new Light();
        Command cmd = new LightOnCommand(light);

        RemoteControl remote = new RemoteControl();
        remote.setCommand(cmd);
        remote.pressButton();
    }
}
```

---

## ✅ 4. **Chain of Responsibility Pattern**

### 🧠 Intent:
Pass a request along a chain of handlers.

### 📦 Example: Support System

```java
abstract class SupportHandler {
    protected SupportHandler next;

    public void setNext(SupportHandler next) {
        this.next = next;
    }

    public abstract void handle(String issue);
}

class LowLevelSupport extends SupportHandler {
    public void handle(String issue) {
        if (issue.equals("low")) {
            System.out.println("Low-level support handled it.");
        } else if (next != null) {
            next.handle(issue);
        }
    }
}
```

```java
class HighLevelSupport extends SupportHandler {
    public void handle(String issue) {
        System.out.println("High-level support handled: " + issue);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        SupportHandler low = new LowLevelSupport();
        SupportHandler high = new HighLevelSupport();

        low.setNext(high);
        low.handle("low");
        low.handle("critical");
    }
}
```

---

## ✅ 5. **State Pattern**

### 🧠 Intent:
Allow an object to alter its behavior when its internal state changes.

### 📦 Example: Fan with States

```java
interface FanState {
    void turnUp(Fan fan);
    void turnDown(Fan fan);
}
```

```java
class LowState implements FanState {
    public void turnUp(Fan fan) {
        fan.setState(new HighState());
        System.out.println("Fan on HIGH");
    }

    public void turnDown(Fan fan) {
        System.out.println("Fan turned OFF");
    }
}

class HighState implements FanState {
    public void turnUp(Fan fan) {
        System.out.println("Already on HIGH");
    }

    public void turnDown(Fan fan) {
        fan.setState(new LowState());
        System.out.println("Fan on LOW");
    }
}
```

```java
class Fan {
    private FanState state = new LowState();

    public void setState(FanState state) {
        this.state = state;
    }

    public void turnUp() {
        state.turnUp(this);
    }

    public void turnDown() {
        state.turnDown(this);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Fan fan = new Fan();
        fan.turnUp();   // Fan on HIGH
        fan.turnUp();   // Already on HIGH
        fan.turnDown(); // Fan on LOW
    }
}
```

---

## ✅ 6. **Template Method Pattern**

### 🧠 Intent:
Define a skeleton of an algorithm, deferring steps to subclasses.

### 📦 Example: Data Parser

```java
abstract class DataParser {
    public void parse() {
        readData();
        processData();
        writeData();
    }

    abstract void readData();
    abstract void processData();
    void writeData() {
        System.out.println("Writing data to file...");
    }
}

class CSVParser extends DataParser {
    void readData() {
        System.out.println("Reading CSV data...");
    }

    void processData() {
        System.out.println("Processing CSV data...");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        DataParser parser = new CSVParser();
        parser.parse();
    }
}
```

---

## ✅ 7. **Mediator Pattern**

### 🧠 Intent:
Define an object that encapsulates communication between objects.

### 📦 Example: Chatroom

```java
interface Mediator {
    void sendMessage(String msg, User user);
}

class Chatroom implements Mediator {
    public void sendMessage(String msg, User user) {
        System.out.println(user.getName() + " says: " + msg);
    }
}

class User {
    private String name;
    private Mediator mediator;

    public User(String name, Mediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }

    public String getName() {
        return name;
    }

    public void send(String msg) {
        mediator.sendMessage(msg, this);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Mediator chat = new Chatroom();
        User user1 = new User("Alice", chat);
        user1.send("Hello!");
    }
}
```

---

## ✅ 8. **Visitor Pattern**

### 🧠 Intent:
Separate operations from the objects they operate on.

### 📦 Example: Tax Calculator

```java
interface Visitable {
    void accept(Visitor visitor);
}

class Book implements Visitable {
    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}
```

```java
interface Visitor {
    void visit(Book book);
}

class TaxVisitor implements Visitor {
    public void visit(Book book) {
        System.out.println("Calculating tax for book");
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Book book = new Book();
        Visitor visitor = new TaxVisitor();
        book.accept(visitor);
    }
}
```

---

## ✅ 9. **Interpreter Pattern**

### 🧠 Intent:
Define a language and interpret its grammar.

### 📦 Example: Simple Boolean Expression

```java
interface Expression {
    boolean interpret(String context);
}

class TerminalExpression implements Expression {
    private String data;

    public TerminalExpression(String data) {
        this.data = data;
    }

    public boolean interpret(String context) {
        return context.contains(data);
    }
}

class OrExpression implements Expression {
    private Expression expr1, expr2;

    public OrExpression(Expression e1, Expression e2) {
        expr1 = e1; expr2 = e2;
    }

    public boolean interpret(String context) {
        return expr1.interpret(context) || expr2.interpret(context);
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        Expression expr = new OrExpression(
            new TerminalExpression("Java"),
            new TerminalExpression("Python")
        );

        System.out.println(expr.interpret("I love Java")); // true
    }
}
```

---

## ✅ 10. **Iterator Pattern**

### 🧠 Intent:
Provide a way to access elements sequentially without exposing structure.

### 📦 Example: Name Collection

```java
class NameRepository {
    String[] names = {"Alice", "Bob", "Charlie"};

    public Iterator<String> getIterator() {
        return Arrays.asList(names).iterator();
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        NameRepository repo = new NameRepository();
        Iterator<String> it = repo.getIterator();

        while (it.hasNext()) {
            System.out.println(it.next());
        }
    }
}
```

---

## ✅ 11. **Memento Pattern**

### 🧠 Intent:
Capture and restore object’s internal state.

### 📦 Example: Text Editor Undo

```java
class TextEditor {
    private String text = "";

    public void write(String word) {
        text += word;
    }

    public String getText() {
        return text;
    }

    public Memento save() {
        return new Memento(text);
    }

    public void restore(Memento m) {
        this.text = m.getSavedText();
    }

    static class Memento {
        private final String text;

        public Memento(String text) {
            this.text = text;
        }

        public String getSavedText() {
            return text;
        }
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        TextEditor editor = new TextEditor();
        editor.write("Hello ");
        TextEditor.Memento m1 = editor.save();

        editor.write("World!");
        System.out.println(editor.getText()); // Hello World!

        editor.restore(m1);
        System.out.println(editor.getText()); // Hello 
    }
}
```