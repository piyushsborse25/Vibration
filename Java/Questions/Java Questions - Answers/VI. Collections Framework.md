### **72. What is the Collection Framework in Java?**

- A **unified architecture** for storing and manipulating groups of objects.
    
- Provides **interfaces (Set, List, Map, Queue)** and **classes (ArrayList, HashSet, HashMap, etc.)**.
    
- Benefits: **reusability, performance, consistency**, and **reduced programming effort**.
    
- Found in **`java.util`** package.
    

---

### **73. Explain various interfaces used in the Collection framework.**

1. **Collection** – Root interface for all collections.
    
2. **List** – Ordered, allows duplicates (e.g., ArrayList, LinkedList).
    
3. **Set** – Unordered, unique elements (e.g., HashSet, TreeSet).
    
4. **Queue** – FIFO order (e.g., PriorityQueue, LinkedList).
    
5. **Map** – Key-value pairs (e.g., HashMap, TreeMap, Hashtable).
    
6. **SortedSet/SortedMap** – Maintains ascending order.
    
7. **NavigableSet/NavigableMap** – Provides navigation methods like `higher()`, `lower()`.
    

---

### **74. What is the difference between Collection and Collections?**

|Aspect|Collection|Collections|
|---|---|---|
|Type|Interface|Utility class|
|Purpose|Defines structure for collections|Provides helper methods (e.g., sorting, searching)|
|Package|`java.util.Collection`|`java.util.Collections`|
|Example|`List`, `Set`, `Queue`|`Collections.sort(list)`|

---

### **75. What is ArrayList in Java?**

- A **resizable array** implementation of the `List` interface.
    
- **Allows duplicates**, maintains insertion order, and provides **random access**.
    
- Not thread-safe (use `Collections.synchronizedList()` if needed).
    
- Grows by **50% (Java 8+)** when capacity exceeds.
    

---

### **76. What is the difference between `ArrayList` and `LinkedList`?**

|Feature|ArrayList|LinkedList|
|---|---|---|
|Data Structure|Dynamic array|Doubly linked list|
|Access Time|Fast (O(1))|Slow (O(n))|
|Insertion/Deletion|Slow (shifting required)|Fast (node manipulation)|
|Memory|Less|More (extra node pointers)|
|Ideal For|Frequent reads|Frequent inserts/deletes|

---

### **77. What are the key differences between `HashSet` and `TreeSet`?**

|Feature|HashSet|TreeSet|
|---|---|---|
|Ordering|Unordered|Sorted (natural/comparator)|
|Implementation|HashMap|TreeMap (Red-Black Tree)|
|Performance|O(1) average|O(log n)|
|Nulls|Allows one null|Does not allow null|
|Use case|Fast lookups|Sorted unique data|

---

### **78. Explain `HashMap` vs `TreeMap`.**

|Feature|HashMap|TreeMap|
|---|---|---|
|Order|Unordered|Sorted (by keys)|
|Performance|O(1) average|O(log n)|
|Nulls|Allows one null key|No null keys|
|Implementation|Hash table|Red-black tree|
|Use case|Fast access|Ordered traversal|

---

### **79. What are Generics in Java?**

- Introduced in **Java 5**, they allow **type-safe collections**.
    
- Prevent **ClassCastException** by defining type at compile time.
    

```java
List<String> list = new ArrayList<>();
```

✅ Compile-time type checking, no explicit casting required.

---

### **80. What is a Vector in Java?**

- Legacy **synchronized** version of `ArrayList`.
    
- Grows by **100%** when capacity exceeds.
    
- Slower due to synchronization; rarely used today.
    

```java
Vector<Integer> v = new Vector<>();
```

---

### **81. What is a PriorityQueue in Java?**

- A **queue** that orders elements based on **priority** rather than FIFO.
    
- Uses **heap-based implementation**.
    
- Null elements not allowed.
    

```java
PriorityQueue<Integer> pq = new PriorityQueue<>();
```

---

### **82. Explain the LinkedList class.**

- Implements both **List** and **Deque** interfaces.
    
- Doubly linked list → efficient insert/delete at both ends.
    
- Allows duplicates and nulls.
    

```java
LinkedList<String> list = new LinkedList<>();
```

---

### **83. What is the Stack class in Java?**

- Legacy **LIFO** (Last-In-First-Out) data structure extending `Vector`.
    
- Methods: `push()`, `pop()`, `peek()`, `empty()`.
    
- Use `Deque` (`ArrayDeque`) in modern code instead.
    

---

### **84. What is Set in the Java Collections framework?**

- Interface extending `Collection`.
    
- Stores **unique elements only**, unordered.
    
- Implementations: `HashSet`, `LinkedHashSet`, `TreeSet`.
    

---

### **85. What is the HashSet class in Java?**

- Backed by a `HashMap`.
    
- No duplicates, allows one null element.
    
- Unordered, uses `hashCode()` and `equals()` for uniqueness.
    
- O(1) average for add/search/remove.
    

---

### **86. What is LinkedHashSet in Java?**

- Extends `HashSet` + maintains **insertion order**.
    
- Uses **LinkedHashMap** internally.
    
- Slightly slower than `HashSet` due to linked list overhead.
    

---

### **87. What is a Map interface in Java?**

- Stores **key-value pairs**; keys are unique, values can repeat.
    
- Not part of `Collection` hierarchy.
    
- Implementations: `HashMap`, `TreeMap`, `LinkedHashMap`, `ConcurrentHashMap`.
    

---

### **88. Explain TreeMap in Java.**

- **Sorted Map** based on **Red-Black Tree**.
    
- Keys sorted in **natural order** or by **Comparator**.
    
- Does **not allow null keys**, allows multiple null values.
    

---

### **89. What is EnumSet?**

- Specialized `Set` for **enum types only**.
    
- All elements must be from a **single enum type**.
    
- Faster than HashSet; stored as **bit vectors**.
    

```java
EnumSet<Color> colors = EnumSet.of(Color.RED, Color.GREEN);
```

---

### **90. What is BlockingQueue?**

- Thread-safe **queue** used in concurrent programming.
    
- Blocks on insert if full and on remove if empty.
    
- Used in producer-consumer problems.  
    Examples: `ArrayBlockingQueue`, `LinkedBlockingQueue`, `PriorityBlockingQueue`.
    

---

### **91. What is the ConcurrentHashMap in Java?**

- Thread-safe map for **concurrent read/write operations**.
    
- Uses **bucket-level locking (segments)** for high performance.
    
- Null keys/values not allowed.
    
- Introduced in **Java 5**, improved in **Java 8** with **lock striping** and **CAS**.
    

---

### **92. What is an Iterator?**

- Interface to **traverse elements** of a collection one by one.
    
- Methods: `hasNext()`, `next()`, `remove()`.
    
- Works for all `Collection` types.
    

```java
Iterator<Integer> it = list.iterator();
```

---

### **93. What is an Enumeration?**

- Legacy interface (pre-Java 2) used for iteration.
    
- Methods: `hasMoreElements()`, `nextElement()`.
    
- Used mainly with **Vector** and **Hashtable**.
    
- Replaced by `Iterator`.
    

---

### **94. What is the difference between Iterator and ListIterator?**

|Feature|Iterator|ListIterator|
|---|---|---|
|Direction|Forward only|Both directions|
|Applicable to|All collections|Only `List` implementations|
|Add/Modify|Cannot add elements|Can add, modify, remove|
|Methods|`hasNext()`, `next()`|`hasNext()`, `hasPrevious()`, `next()`, `previous()`, `add()`|

---

### **95. Differentiate between HashMap and Hashtable.**

|Feature|HashMap|Hashtable|
|---|---|---|
|Synchronization|Not synchronized|Synchronized|
|Nulls|Allows one null key, multiple null values|No nulls allowed|
|Performance|Faster|Slower|
|Legacy|Modern|Legacy|
|Use case|Single-threaded|Multi-threaded (but prefer ConcurrentHashMap)|

---

### **96. What is the difference between Comparable and Comparator?**

|Feature|Comparable|Comparator|
|---|---|---|
|Package|`java.lang`|`java.util`|
|Interface Method|`compareTo(Object o)`|`compare(Object o1, Object o2)`|
|Sorting Logic|Defined inside the class|Defined outside the class|
|Multiple Sort Orders|Not possible|Possible|
|Example|`Collections.sort(list)`|`Collections.sort(list, comp)`|

---

### **97. What is the difference between Set and Map?**

|Feature|Set|Map|
|---|---|---|
|Data Type|Stores only elements|Stores key-value pairs|
|Key|Not applicable|Keys are unique|
|Value|Each element is value itself|Value associated with key|
|Example|`HashSet<Integer>`|`HashMap<Integer, String>`|

---

### **98. Explain the FailFast iterator and FailSafe iterator.**

|Type|Behavior|Example|
|---|---|---|
|**Fail-Fast**|Throws `ConcurrentModificationException` if structure modified during iteration|`ArrayList`, `HashMap`|
|**Fail-Safe**|Works on a copy of the collection (no exception)|`ConcurrentHashMap`, `CopyOnWriteArrayList`|
|**Mechanism**|Uses modCount variable|Uses cloned snapshot|
