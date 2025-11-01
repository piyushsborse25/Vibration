### **60. How does `HashMap` handle hash collisions? What is the difference between chaining and open addressing?**

- **Collision Handling in HashMap:**
    
    - A collision occurs when two keys produce the same hash index.
        
    - Java’s `HashMap` handles this using **chaining**, not open addressing.
        
    - Each bucket of the `HashMap` stores entries in a **linked list** (or a **balanced tree** in Java 8+ when the bucket size exceeds 8).
        
- **Chaining:**
    
    - Each bucket holds a list (or tree) of key-value pairs.
        
    - Example: two keys with the same hash index are stored as nodes in the same list.
        
    - Lookup time is **O(n)** in the worst case, but becomes **O(log n)** when treeified.
        
- **Open Addressing:**
    
    - Used in some other hash structures (e.g., `ThreadLocalMap`).
        
    - If a collision occurs, the next empty slot is searched for (linear or quadratic probing).
        
- **In summary:**
    
    - `HashMap` → **Chaining (LinkedList/TreeNode)**
        
    - Open addressing → **No separate lists; finds next free slot**
        

---

### **61. Why is `HashMap` not thread-safe? How does `ConcurrentHashMap` resolve this?**

- **HashMap Problem:**
    
    - Concurrent updates by multiple threads can cause **data corruption**, especially during resize (infinite loops, lost entries).
        
    - Example:
        
        ```java
        Map<String, Integer> map = new HashMap<>();
        new Thread(() -> map.put("A", 1)).start();
        new Thread(() -> map.put("B", 2)).start(); // Race condition
        ```
        
- **ConcurrentHashMap Solution:**
    
    - Designed for concurrent use.
        
    - **Before Java 8:** Used **Segmented Locks** (each segment locked independently).
        
    - **After Java 8:** Uses **CAS (Compare-And-Swap)** and **fine-grained synchronization** at the bucket level.
        
    - Allows multiple threads to read/write simultaneously without corruption.
        
- **Key Difference:**
    
    - `HashMap` → unsafe concurrent access.
        
    - `ConcurrentHashMap` → safe, scalable concurrency.
        

---

### **62. What is the difference between `Comparable` and `Comparator`? Can a class implement both?**

- **Comparable (java.lang.Comparable):**
    
    - Defines **natural ordering** within the class itself.
        
    - Method: `compareTo(T o)`
        
    - Example:
        
        ```java
        class Employee implements Comparable<Employee> {
            int id;
            public int compareTo(Employee e) {
                return this.id - e.id;
            }
        }
        ```
        
- **Comparator (java.util.Comparator):**
    
    - Defines **custom ordering**, external to the class.
        
    - Method: `compare(T o1, T o2)`
        
    - Example:
        
        ```java
        Comparator<Employee> byName = (a, b) -> a.name.compareTo(b.name);
        ```
        
- **Can a class implement both?**
    
    - Yes. A class can define its natural order (`Comparable`) and still use external comparators (`Comparator`).
        

---

### **63. What is the difference between `IdentityHashMap` and `HashMap`?**

- **HashMap:**
    
    - Compares keys using `equals()` and computes hash with `hashCode()`.
        
- **IdentityHashMap:**
    
    - Compares keys using **reference equality (`==`)** instead of `equals()`.
        
    - Ignores overridden `equals()` and `hashCode()` methods.
        
- **Use Case:**
    
    - Useful in frameworks like serialization, proxy handling, or object identity tracking.
        

---

### **64. Why are `ArrayList` and `LinkedList` not synchronized? How can you make them thread-safe?**

- **Not synchronized** by default for **performance reasons**.
    
- In single-threaded use, synchronization adds unnecessary overhead.
    
- To make them thread-safe:
    
    1. Use `Collections.synchronizedList(new ArrayList<>())`
        
    2. Or use `CopyOnWriteArrayList` from `java.util.concurrent` (better for frequent reads).
        

---

### **65. How does `LinkedHashSet` maintain insertion order? How does it handle hash collisions?**

- Inherits from `HashSet`, which uses a **`HashMap` internally**.
    
- Maintains **insertion order** via a **doubly linked list** across all entries.
    
- Hash collisions are handled by **chaining** (like `HashMap`).
    
- Example:
    
    ```java
    Set<Integer> set = new LinkedHashSet<>();
    set.add(10);
    set.add(20);
    // Order preserved as inserted
    ```
    

---

### **66. Explain the significance of the `load factor` in `HashMap` and how it impacts performance.**

- **Load Factor:** ratio of (number of entries) / (capacity).
    
- Default is **0.75** — meaning the table resizes when 75% full.
    
- Lower value → less collision, more memory.
    
- Higher value → more collision, less memory.
    
- Performance trade-off:
    
    - **Low load factor:** faster access, more memory usage.
        
    - **High load factor:** slower access, compact memory usage.
        

---

### **67. Can you store `null` as a key in `TreeMap`? Why or why not?**

- No. `TreeMap` uses **natural ordering** or a **Comparator** that requires comparisons.
    
- Comparing `null` throws a `NullPointerException`.
    
- Example:
    
    ```java
    TreeMap<String, Integer> map = new TreeMap<>();
    map.put(null, 1); // Throws NullPointerException
    ```
    

---

### **68. What happens when you modify an object that is used as a key in a `HashMap`?**

- HashMap depends on the **key’s hashCode and equals()**.
    
- Changing a key field affects its hash, making it **unreachable** in the map.
    
- Example:
    
    ```java
    class Key { int id; }
    Map<Key, String> map = new HashMap<>();
    Key k = new Key(); k.id = 1;
    map.put(k, "A");
    k.id = 2; // Now lookup fails
    map.get(k); // null
    ```
    

---

### **69. What is the difference between `ConcurrentSkipListMap` and `TreeMap`?**

- Both are **sorted maps**, but:
    
    - `TreeMap`: not thread-safe.
        
    - `ConcurrentSkipListMap`: **thread-safe** and **non-blocking**.
        
- Internally uses a **skip list**, allowing concurrent reads/writes.
    
- Supports **log(n)** operations with better scalability than synchronized maps.
    

---

### **70. How does `PriorityQueue` ensure the order of elements? Can it contain `null` elements?**

- Based on a **heap data structure** (min-heap by default).
    
- Elements are ordered by **natural order** or **Comparator**.
    
- `null` elements are **not allowed** (throws `NullPointerException`).
    
- Example:
    
    ```java
    PriorityQueue<Integer> pq = new PriorityQueue<>();
    pq.add(10); pq.add(5);
    pq.poll(); // returns 5 (min element)
    ```
    

---

### **71. What is the difference between a `Deque` and a `Queue`? How does `ArrayDeque` optimize over `LinkedList`?**

- **Queue:** FIFO — add at rear, remove from front.
    
- **Deque:** double-ended queue — add/remove from both ends.
    
- **ArrayDeque**:
    
    - Backed by a **resizable array** (no node overhead like `LinkedList`).
        
    - **Faster**, cache-friendly, no capacity restrictions.
        
- Example:
    
    ```java
    Deque<Integer> dq = new ArrayDeque<>();
    dq.addFirst(1); dq.addLast(2);
    ```
    

---

### **72. How does a `ConcurrentHashMap` split its buckets for thread safety?**

- Before Java 8: divided into **segments** with separate locks.
    
- Java 8+: each bucket can lock individually; updates use **CAS + synchronized** per node.
    
- Allows multiple threads to modify different buckets safely.
    
- Example: high concurrency with minimal blocking.
    

---

### **73. What happens if you use a mutable object as a key in a `TreeMap`?**

- The order is based on the **key’s comparison logic**.
    
- If the key changes, the tree’s structure becomes inconsistent, leading to incorrect lookups.
    
- Avoid using mutable objects as keys.
    

---

### **74. Why is `Collections.unmodifiableList()` not truly immutable? How does it differ from `List.of()`?**

- `unmodifiableList()` is a **read-only wrapper** — if the original list changes, it reflects those changes.
    
- `List.of()` creates a **truly immutable list** — no modification possible and underlying data is fixed.
    
- Example:
    
    ```java
    List<String> list = new ArrayList<>(List.of("A"));
    List<String> unmod = Collections.unmodifiableList(list);
    list.add("B"); // visible in unmod
    ```
    

---

### **75. What happens if you add a `null` element to a `TreeSet`?**

- `TreeSet` uses **natural ordering** or **Comparator** → comparison with `null` is invalid.
    
- Throws **NullPointerException**.
    
- Example:
    
    ```java
    TreeSet<Integer> set = new TreeSet<>();
    set.add(null); // Throws NPE
    ```
