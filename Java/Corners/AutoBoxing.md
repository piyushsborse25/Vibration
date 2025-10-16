### **1. Primitive Wrapper Classes**
- **Caching**: Integer, Byte, Short, and Long cache values from **-128 to 127**. Beyond this range, new objects are created.
  ```java
  Integer x = 127, y = 127;
  System.out.println(x == y); // true (cached)

  Integer a = 128, b = 128;
  System.out.println(a == b); // false (new objects)
  ```

- **NullPointerException on Unboxing**:
  ```java
  Integer x = null;
  int y = x; // Throws NullPointerException
  ```

- **Mixed Comparisons**:
  ```java
  Integer x = 42;
  Long y = 42L;
  System.out.println(x.equals(y)); // false (different types)
  ```

---

### **2. String Pool and Immutability**
- **String Pool**: Strings with the same value are interned (cached).
  ```java
  String s1 = "Java";
  String s2 = "Java";
  System.out.println(s1 == s2); // true (same reference)
  System.out.println(s1.equals(s2)); // true
  ```

- **Creating New Strings**:
  ```java
  String s1 = new String("Java");
  String s2 = "Java";
  System.out.println(s1 == s2); // false (different objects)
  System.out.println(s1.equals(s2)); // true
  ```

- **String Concatenation**:
  ```java
  String s1 = "Java";
  String s2 = "Ja" + "va"; // Compile-time constant
  System.out.println(s1 == s2); // true
  ```

---

### **3. Overloading vs Overriding**
- **Overloading Resolution** (compile-time decision):
  ```java
  void print(int x) { System.out.println("int"); }
  void print(Integer x) { System.out.println("Integer"); }
  
  print(10); // Calls print(int)
  ```

- **Varargs Overloading**:
  ```java
  void print(int... x) { System.out.println("varargs"); }
  void print(Integer x) { System.out.println("Integer"); }
  
  print(10); // Calls print(Integer) (exact match preferred)
  ```

- **Covariant Return Type in Overriding**:
  ```java
  class Parent {
      Number getNumber() { return 10; }
  }

  class Child extends Parent {
      @Override
      Integer getNumber() { return 20; } // Covariant return
  }
  ```

---

### **4. Equals and HashCode**
- **Contract**:
  - If `a.equals(b)` is `true`, `a.hashCode()` must equal `b.hashCode()`.
  - Violating the contract leads to unexpected behavior in collections.

- Common Mistake:
  ```java
  class Point {
      int x, y;
      public boolean equals(Object o) {
          if (this == o) return true;
          if (!(o instanceof Point)) return false;
          Point p = (Point) o;
          return x == p.x && y == p.y;
      }
  }
  // No hashCode() implementation leads to issues in HashMap/HashSet
  ```

---

### **5. Multithreading**
- **Thread Safety with `synchronized`**:
  - `synchronized` ensures mutual exclusion but can lead to **deadlocks**.
  ```java
  synchronized (lock1) {
      synchronized (lock2) {
          // Deadlock risk if another thread reverses the order
      }
  }
  ```

- **Atomicity Issues**:
  ```java
  int count = 0;
  void increment() { count++; } // Not thread-safe (read-modify-write)
  ```

- **Double-Checked Locking** (Use `volatile`):
  ```java
  private volatile Singleton instance;

  public Singleton getInstance() {
      if (instance == null) {
          synchronized (Singleton.class) {
              if (instance == null) {
                  instance = new Singleton();
              }
          }
      }
      return instance;
  }
  ```

---

### **6. Final, Static, and Transient**
- **Final Variables**: Must be initialized before constructor completes.
  ```java
  final int x;
  public Test() {
      x = 10; // OK
  }
  ```

- **Static Methods**: Cannot be overridden.
  ```java
  class Parent {
      static void display() { System.out.println("Parent"); }
  }

  class Child extends Parent {
      static void display() { System.out.println("Child"); } // Hides, not overrides
  }
  ```

- **Transient Keyword**: Excludes fields from serialization.
  ```java
  class Test implements Serializable {
      transient int value = 42;
  }
  ```

---

### **7. Collections Framework**
- **HashMap Behavior**:
  - Keys are compared using `equals()`.
  - Hash collisions lead to linked lists (or trees for large buckets in Java 8+).

- **ConcurrentModificationException**:
  ```java
  List<Integer> list = new ArrayList<>(Arrays.asList(1, 2, 3));
  for (Integer i : list) {
      list.add(4); // Throws ConcurrentModificationException
  }
  ```

---

### **8. Default Methods in Interfaces**
- Default methods can be overridden or used directly.
  ```java
  interface A {
      default void show() { System.out.println("A"); }
  }

  class B implements A {
      @Override
      public void show() { System.out.println("B"); }
  }
  ```

---

### **9. Streams and Lambdas**
- **Lazy Evaluation**:
  - Operations like `filter()` and `map()` are not executed until a terminal operation (e.g., `collect()` or `forEach()`).

- **Mutability in Streams**:
  ```java
  List<Integer> list = new ArrayList<>();
  list.stream().map(x -> x * 2).forEach(list::add); // ConcurrentModificationException
  ```

---

### **10. Class Loading and Initialization**
- **Static Block**:
  ```java
  static {
      System.out.println("Static block"); // Runs only once when the class is loaded
  }
  ```

- **Order of Initialization**:
  - Static fields and blocks are initialized before instance fields and constructors.

---

### Study Tips:
- Focus on edge cases in each concept.
- Be ready to debug small code snippets.
- Understand **JVM optimizations** and **real-world issues** like memory leaks, race conditions, and deadlocks.