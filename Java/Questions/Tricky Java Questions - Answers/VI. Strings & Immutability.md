### **76. Why is the `String` class immutable in Java? What are the benefits of immutability?**

- **Reasons for Immutability:**
    
    1. **Security:** Strings are used in sensitive areas (e.g., class loading, network connections). Immutability prevents tampering.
        
    2. **Thread Safety:** Multiple threads can safely share a `String` without synchronization.
        
    3. **HashCode Caching:** Since value never changes, `hashCode()` can be cached for faster lookups (used in `HashMap`).
        
    4. **String Pooling:** Enables reusing common string literals in the pool.
        
- **Example:**
    
    ```java
    String s1 = "Java";
    String s2 = s1.toUpperCase(); // creates new object
    ```
    

✅ **Benefit:** Immutable design improves performance, memory efficiency, and safety.

---

### **77. What is the difference between `String`, `StringBuilder`, and `StringBuffer`?**

|Class|Mutability|Thread-Safety|Performance|Use Case|
|---|---|---|---|---|
|`String`|Immutable|Safe|Slow in concatenation|Fixed data|
|`StringBuilder`|Mutable|❌ Not thread-safe|Fast|Single-threaded concatenation|
|`StringBuffer`|Mutable|✅ Thread-safe|Slower|Multi-threaded concatenation|

- **Example:**
    
    ```java
    StringBuilder sb = new StringBuilder("Hello");
    sb.append(" World"); // modifies same object
    ```
    

✅ **Summary:** Use `StringBuilder` for performance, `String` for immutability, `StringBuffer` for synchronization.

---

### **78. Can two different `String` objects with the same value have different hash codes?**

❌ **No.**  
If two `String` objects have the same **sequence of characters**, their `hashCode()` will **always be identical** (as per contract).

- **Example:**
    
    ```java
    String s1 = new String("abc");
    String s2 = new String("abc");
    System.out.println(s1.hashCode() == s2.hashCode()); // true
    ```
    

✅ **Note:** Objects are different, but hash codes (derived from characters) are same.

---

### **79. What is the difference between `==` and `.equals()` when comparing strings?**

|Operator|Compares|Behavior|
|---|---|---|
|`==`|References|True only if both point to same object|
|`.equals()`|Values|True if content is identical|

- **Example:**
    
    ```java
    String a = "Java";
    String b = new String("Java");
    System.out.println(a == b);      // false
    System.out.println(a.equals(b)); // true
    ```
    

✅ Always use `.equals()` for string content comparison.

---

### **80. How does the `intern()` method work in the `String` class?**

- **Purpose:**  
    Returns a **canonical representation** of the string from the **String Pool**.
    
- **Behavior:**
    
    - If the pool already has a string with same value → returns reference from pool.
        
    - Otherwise → adds it to pool and returns that reference.
        
- **Example:**
    
    ```java
    String s1 = new String("Java");
    String s2 = s1.intern();
    String s3 = "Java";
    System.out.println(s2 == s3); // true
    ```
    

✅ Ensures memory efficiency and consistent references.

---

### **81. How does the String pool in Java work? Can you disable it?**

- **String Pool:**  
    A special area in heap that stores unique string literals.
    
- **Working:**
    
    ```java
    String a = "Java"; // goes to pool
    String b = "Java"; // reused from pool
    ```
    
- **Disable:**  
    ❌ Cannot be disabled — it’s part of the JVM optimization mechanism.
    

✅ **Note:** Since Java 7, pool is moved to the **heap** (was in PermGen earlier).

---

### **82. What happens if you use `String.intern()` on a dynamically created string?**

- **Behavior:**
    
    - If string’s value is **not in pool**, it will be **added**.
        
    - If already present, **existing pooled instance** is returned.
        
- **Example:**
    
    ```java
    String s1 = new String("Hello").intern();
    String s2 = "Hello";
    System.out.println(s1 == s2); // true
    ```
    

✅ **Result:** References become identical to the pooled literal.

---

### **83. Why is `String` immutable, but `StringBuilder` and `StringBuffer` are not?**

- **`String`** stores data in a final char array — once created, cannot change.
    
- **`StringBuilder`/`StringBuffer`** use mutable buffers internally.
    
- **Example:**
    
    ```java
    StringBuilder sb = new StringBuilder("Hi");
    sb.append(" Java"); // modifies same object
    ```
    

✅ **Reason:** Builders are meant for modification and concatenation efficiency, unlike Strings.

---

### **84. What are the memory implications of using `String` concatenation with `+` operator in a loop?**

- **Problem:**  
    Each `+` creates a **new String object** (since Strings are immutable).
    
- **Example (inefficient):**
    
    ```java
    String s = "";
    for (int i = 0; i < 1000; i++) {
        s += i; // creates 1000 new objects
    }
    ```
    
- **Solution:**  
    Use `StringBuilder`:
    
    ```java
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < 1000; i++) {
        sb.append(i);
    }
    ```
    

✅ Saves memory and improves performance.

---

### **85. How does `String` deduplication work in Java 9+?**

- **Feature:** Automatic deduplication of identical string values in the heap (not just literals).
    
- **Mechanism:**  
    G1 Garbage Collector identifies duplicate character arrays and replaces them with a shared one.
    

✅ **Benefit:**  
Reduces memory usage in applications with many duplicate strings (e.g., web apps, logs).

---

### **86. What happens if you modify a string using reflection? Will it still be immutable?**

- **Yes, but unsafe.**  
    You can technically modify a string’s internal `value[]` via reflection (pre-Java 9), but doing so breaks invariants and may cause unpredictable behavior.
    
- **Example (not recommended):**
    
    ```java
    Field value = String.class.getDeclaredField("value");
    value.setAccessible(true);
    value.set("Java", new char[]{'H','a','c','k'});
    ```
    

✅ **From Java 9+:** `value` field is a final `byte[]` — making such modification impossible safely.

---

### **87. How is a `String` represented internally in Java 9+?**

- **Before Java 9:**  
    `char[] value` — each character used **2 bytes (UTF-16)**.
    
- **After Java 9:**  
    Compact Strings introduced → uses `byte[] value` + `coder` flag (LATIN1 or UTF16).
    

✅ **Result:**  
Reduces memory footprint for ASCII-heavy text.

---

### **88. Can you use a `String` as a key in a `HashMap`? What are the implications?**

✅ **Yes**, `String` is one of the most common keys in `HashMap`.

- **Why Safe:**
    
    - Immutable → hashCode remains constant.
        
    - Well-implemented `equals()` and `hashCode()` methods.
        
- **Example:**
    
    ```java
    Map<String, Integer> map = new HashMap<>();
    map.put("Java", 1);
    ```
    

✅ Ensures reliable lookups and no data inconsistency.

---

### **89. How does `String` interning differ before and after Java 7?**

|Version|String Pool Location|Behavior|
|---|---|---|
|Java 6 and earlier|PermGen (fixed size)|Limited, `OutOfMemoryError` possible|
|Java 7+|Heap|Expands dynamically|
|Java 9+|Heap + deduplication|More memory efficient|

✅ **Change:** Pool now benefits from GC and larger heap memory.