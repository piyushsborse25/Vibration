### **Question:**

In Java, explain in detail where different types of objects — such as local objects created inside methods, instance objects that belong to class fields, and static objects — are stored in memory. Additionally, clarify where their corresponding reference variables are stored and how their lifetimes differ. Use code examples to illustrate your explanation, and summarize the overall memory structure involved in object allocation.

---

### **Answer:**

In Java, **all objects created using the `new` keyword are stored in the heap memory**, regardless of whether they are local, instance, or static. What differs is **where their reference variables are stored** and **how long each one lives**.

---

### **1. Local Objects**

A **local object** is one that is created inside a method, constructor, or block.

```java
void demo() {
    Person p = new Person("Alice");
}
```

- `p` → reference variable, stored on the **stack** (inside the method’s stack frame).
    
- `new Person("Alice")` → actual object, stored on the **heap**.
    

When `demo()` ends:

- The stack frame is destroyed (so `p` is gone).
    
- The `Person` object remains in the heap until it becomes unreachable → then garbage collected.
    

✅ **Key point:** local variable dies with method, but its object may survive longer.

---

### **2. Instance Objects**

An **instance object** belongs to a class instance (i.e., non-static field).

```java
class Employee {
    Address addr = new Address("New York");
}
```

- When you do:
    
    ```java
    Employee e = new Employee();
    ```
    
    - `e` → reference variable on the **stack** (if declared locally).
        
    - `Employee` object → stored in the **heap**.
        
    - Inside that `Employee` object:
        
        - The field `addr` (reference) and its `Address` object → both in the **heap**.
            

✅ **Key point:** instance objects (and their nested objects) always live in the **heap** because they are part of another heap object.

---

### **3. Static Objects**

Static members belong to the **class**, not to any object.

```java
class Company {
    static Address headOffice = new Address("London");
}
```

- `headOffice` → reference stored in the **method area (class metadata area)**.
    
- `new Address("London")` → actual object stored in the **heap**.
    

✅ **Key point:** static variables are loaded once per class and live until the class is unloaded from memory.

---

### **4. Object Lifetime Comparison**

|Type of Object|Object Location|Reference Location|Lifetime|
|---|---|---|---|
|Local Object|Heap|Stack (method frame)|Until GC (after method ends)|
|Instance Object|Heap|Heap (inside parent object)|Until parent object is GC’d|
|Static Object|Heap|Method Area|Until class is unloaded|

---

### **5. Overall Memory Structure**

- **Stack:** holds local variables and references for currently executing methods.
    
- **Heap:** stores all actual objects and their instance variables.
    
- **Method Area (Metaspace):** stores class-level data (static variables, method bytecode, constants).
    

---

### **Final Summary**

👉 Every **object created with `new`** — whether local, instance, or static — resides in the **heap**.  
👉 Only the **references** differ in location (stack, heap, or method area).  
👉 The **object’s lifetime** depends on its reachability — once no references exist, it becomes eligible for **garbage collection**.