### **58. What is the difference between `==` and `.equals()` in Java?**

| Comparison | `==`                                               | `.equals()`                              |
| ---------- | -------------------------------------------------- | ---------------------------------------- |
| Type       | Reference comparison                               | Content/value comparison                 |
| Use case   | Checks if both references point to the same object | Checks if two objects contain same data  |
| Works for  | Primitives and references                          | Objects (String, etc.)                   |
| Example    | `"abc" == new String("abc")` → false               | `"abc".equals(new String("abc"))` → true |

---

### **59. What is the difference between String and StringBuffer?**

|Aspect|String|StringBuffer|
|---|---|---|
|Mutability|Immutable|Mutable|
|Thread Safety|Not thread-safe|Thread-safe (synchronized methods)|
|Performance|Slower in heavy modifications|Faster for frequent modifications|
|Example|`"Hello" + "World"` → creates new object|`append()` modifies same object|

---

### **60. What are the differences between StringBuffer and StringBuilder?**

|Feature|StringBuffer|StringBuilder|
|---|---|---|
|Synchronization|Synchronized → Thread-safe|Not synchronized → Not thread-safe|
|Performance|Slower (thread safety overhead)|Faster|
|Introduced In|JDK 1.0|JDK 1.5|
|Use Case|Multi-threaded env|Single-threaded env|

---

### **61. What is `StringBuilder` vs `StringBuffer`?**

Both are **mutable** string classes.

- **StringBuilder** → faster, non-synchronized → use when only one thread modifies string.
    
- **StringBuffer** → synchronized → safe in multi-threaded environment.
    

Example:

```java
StringBuilder sb = new StringBuilder("Hi");
sb.append(" There");
```

---

### **62. Which among String or StringBuffer should be preferred when there are a lot of updates to the data?**

- **Prefer `StringBuffer` or `StringBuilder`** when performing many concatenations or updates.
    
- `String` creates a **new object** on every modification → inefficient.
    
- `StringBuffer/StringBuilder` modifies data in **place**, saving memory.
    

---

### **63. How is the creation of a String using `new()` different from that of a literal?**

|Method|Example|Behavior|
|---|---|---|
|**Literal**|`String s1 = "Java";`|Stored in **String Pool**, reused if same literal exists.|
|**Using new()**|`String s2 = new String("Java");`|Always creates a **new object in heap**, even if same literal exists.|

```java
String s1 = "Java";
String s2 = new String("Java");
System.out.println(s1 == s2); // false
```

---

### **64. What is an array in Java?**

- A **collection of elements** of the **same data type**, stored in **contiguous memory**.
    
- Has a **fixed size** and is **zero-indexed**.
    

```java
int[] arr = {1, 2, 3};
```

---

### **65. On which memory are arrays created in Java?**

- Arrays are **objects**, hence created in the **heap memory**, regardless of where they are declared (even inside methods).
    

---

### **66. What are the types of an array?**

1. **Single-Dimensional Array**
    
    ```java
    int[] a = {1, 2, 3};
    ```
    
2. **Multi-Dimensional Array**
    
    ```java
    int[][] b = {{1,2}, {3,4}};
    ```
    

---

### **67. Why does the Java array index start with 0?**

- Due to **pointer arithmetic**: index acts as an **offset** from the base address.
    
- First element = base + 0 offset → efficient and historical (from C language design).
    

---

### **68. What is the difference between `int array[]` and `int[] array`?**

- Both are **syntactically valid** and equivalent.
    
- `int[] array` is preferred for readability and convention.
    

```java
int[] a; // preferred
int b[]; // also valid
```

---

### **69. How to copy an array in Java?**

Several methods:

1. **Using assignment (shallow copy):**  
    `int[] b = a;`
    
2. **Using `clone()`:**  
    `int[] b = a.clone();` → deep copy for primitives.
    
3. **Using `System.arraycopy()`:**  
    `System.arraycopy(a, 0, b, 0, a.length);`
    
4. **Using `Arrays.copyOf()`:**  
    `int[] b = Arrays.copyOf(a, a.length);`
    

---

### **70. What do you understand by the jagged array?**

- A **2D array with different column sizes** in each row.
    

```java
int[][] jagged = new int[3][];
jagged[0] = new int[2];
jagged[1] = new int[4];
jagged[2] = new int[1];
```

✅ Commonly used when data is unevenly structured (e.g., monthly sales data).

---

### **71. Is it possible to make an array volatile?**

- Yes, but **only the reference** is volatile, **not the array elements**.
    
- Meaning: multiple threads will see the updated array reference,  
    but changes to elements inside the array **are not guaranteed to be visible** across threads.
    

```java
volatile int[] nums; // valid
```
