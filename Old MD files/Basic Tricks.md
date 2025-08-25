### **11. Generics**
- **Type Erasure**:
  - Generics exist only at compile-time, so type information is erased at runtime.
  ```java
  List<String> list1 = new ArrayList<>();
  List<Integer> list2 = new ArrayList<>();
  System.out.println(list1.getClass() == list2.getClass()); // true
  ```

- **Bounded Wildcards**:
  ```java
  void print(List<? extends Number> list) {
      // List is read-only here
      // list.add(10); // Compilation error
  }
  ```

- **Raw Types**:
  - Using raw types bypasses generic type checks.
  ```java
  List rawList = new ArrayList<String>();
  rawList.add(10); // No compile-time error
  ```

---

### **12. Polymorphism**
- **Method Overriding and Hiding**:
  ```java
  class Parent {
      static void staticMethod() { System.out.println("Parent static"); }
      void instanceMethod() { System.out.println("Parent instance"); }
  }

  class Child extends Parent {
      static void staticMethod() { System.out.println("Child static"); }
      @Override
      void instanceMethod() { System.out.println("Child instance"); }
  }

  Parent obj = new Child();
  obj.staticMethod(); // Parent static (static methods are not overridden)
  obj.instanceMethod(); // Child instance
  ```

- **Overloaded Methods with Varargs**:
  ```java
  void print(int x) { System.out.println("int"); }
  void print(int... x) { System.out.println("varargs"); }
  print(10); // int (exact match wins)
  ```

---

### **13. Serialization**
- **SerialVersionUID**:
  - Changing the class structure without specifying `serialVersionUID` can lead to `InvalidClassException`.

- **Transient Fields**:
  ```java
  class Test implements Serializable {
      transient int value = 10;
  }
  ```

- **Custom Serialization**:
  ```java
  private void writeObject(ObjectOutputStream oos) throws IOException {
      oos.defaultWriteObject();
      oos.writeInt(value);
  }

  private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException {
      ois.defaultReadObject();
      value = ois.readInt();
  }
  ```

---

### **14. Functional Programming and Streams**
- **Infinite Streams**:
  ```java
  Stream<Integer> infinite = Stream.iterate(1, x -> x + 1);
  infinite.limit(5).forEach(System.out::println); // 1, 2, 3, 4, 5
  ```

- **Short-Circuiting Operations**:
  - Operations like `findFirst()` or `anyMatch()` stop processing as soon as a result is found.
  ```java
  List<String> list = Arrays.asList("a", "b", "c");
  list.stream().filter(x -> x.equals("b")).findFirst(); // Stops after finding "b"
  ```

- **Collectors.toMap() and Duplicate Keys**:
  ```java
  List<String> list = Arrays.asList("a", "b", "a");
  Map<String, Integer> map = list.stream().collect(Collectors.toMap(x -> x, String::length, (v1, v2) -> v1));
  // Conflict resolution: (v1, v2) -> v1
  ```

---

### **15. Concurrency and Threading**
- **Volatile**:
  - Ensures visibility of changes to variables across threads but doesn’t guarantee atomicity.
  ```java
  private volatile boolean running = true;
  ```

- **ThreadLocal Variables**:
  ```java
  ThreadLocal<Integer> threadLocal = ThreadLocal.withInitial(() -> 1);
  ```

- **ExecutorService Shutdown**:
  ```java
  ExecutorService executor = Executors.newFixedThreadPool(2);
  executor.shutdown();
  if (!executor.awaitTermination(1, TimeUnit.SECONDS)) {
      executor.shutdownNow();
  }
  ```

- **ForkJoinPool Deadlocks**:
  - Recursive tasks can lead to deadlocks if one thread is waiting for a result from another thread that hasn’t started.

---

### **16. Memory Management**
- **Garbage Collection**:
  - Circular references don’t prevent garbage collection.
  ```java
  class Test {
      Test t;
  }
  ```

- **OutOfMemoryError**:
  - **Heap Space**: Too many objects created.
  - **Metaspace**: Too many loaded classes (e.g., dynamic proxies).

- **Finalize Method**:
  ```java
  @Override
  protected void finalize() {
      System.out.println("Finalize called");
  }
  ```

---

### **17. Reflection**
- **Access Private Fields/Methods**:
  ```java
  Field field = MyClass.class.getDeclaredField("privateField");
  field.setAccessible(true);
  field.set(obj, "newValue");
  ```

- **Invoking Methods**:
  ```java
  Method method = MyClass.class.getMethod("myMethod", String.class);
  method.invoke(obj, "arg");
  ```

---

### **18. Annotations**
- **Retention Policies**:
  - `SOURCE`: Discarded during compilation.
  - `CLASS`: Available in the bytecode but not at runtime.
  - `RUNTIME`: Available at runtime.

- **Custom Annotations**:
  ```java
  @Retention(RetentionPolicy.RUNTIME)
  @Target(ElementType.METHOD)
  public @interface MyAnnotation {
      String value() default "default";
  }
  ```

---

### **19. Advanced Collections**
- **ConcurrentHashMap**:
  - Uses a combination of **segment locks** and **CAS (Compare-And-Swap)** to ensure thread safety.

- **PriorityQueue**:
  - Doesn’t allow `null` elements and uses natural ordering or a provided comparator.

- **TreeMap Comparator Pitfall**:
  ```java
  TreeMap<String, String> map = new TreeMap<>(Comparator.reverseOrder());
  ```

---

### **20. Miscellaneous Tricky Concepts**
- **ClassCastException with Generics**:
  ```java
  List rawList = new ArrayList<String>();
  rawList.add(10); // Compiles
  String str = (String) rawList.get(0); // ClassCastException
  ```

- **Unchecked Exceptions**:
  ```java
  @SuppressWarnings("unchecked")
  List<String> list = (List<String>) new ArrayList<>();
  ```

- **Deadlock Example**:
  ```java
  synchronized (lock1) {
      synchronized (lock2) {
          // Deadlock if another thread locks in reverse order
      }
  }
  ```

- **Cloning**:
  ```java
  class Test implements Cloneable {
      @Override
      protected Object clone() throws CloneNotSupportedException {
          return super.clone();
      }
  }
  ```

---

### Focus Areas for the Interview:
1. **Core Java**: Memory management, OOP, collections, and multithreading.
2. **JVM Internals**: Class loading, GC, and performance tuning.
3. **Problem Solving**: Practice using collections, algorithms, and design patterns.
4. **Frameworks**: If the role is Spring-focused, prepare for DI, AOP, and transactions.