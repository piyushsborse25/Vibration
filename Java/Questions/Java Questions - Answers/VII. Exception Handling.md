**99. What is exception handling in Java?**  
Exception handling is a mechanism to handle runtime errors, ensuring normal program flow using `try`, `catch`, `finally`, `throw`, and `throws`.

---

**100. What is the difference between checked and unchecked exceptions?**

- **Checked:** Checked at compile-time (e.g., `IOException`, `SQLException`).
    
- **Unchecked:** Occur at runtime (e.g., `NullPointerException`, `ArithmeticException`).
    

---

**101. What are custom exceptions in Java?**  
User-defined exceptions created by extending `Exception` (checked) or `RuntimeException` (unchecked).

---

**102. Explain try-catch-finally blocks.**

- **try:** Contains code that might throw an exception.
    
- **catch:** Handles specific exception types.
    
- **finally:** Executes always (cleanup code), regardless of exception occurrence.
    

---

**103. What is a `throw` vs `throws` in Java?**

- **throw:** Used to explicitly throw an exception.
    
- **throws:** Declares exceptions a method might throw.
    

---

**104. How many types of exceptions can occur in a Java program?**  
Two types:

1. **Checked exceptions**
    
2. **Unchecked exceptions** (includes runtime exceptions and errors)
    

---

**105. Difference between an Error and an Exception.**

- **Error:** Serious issues beyond program control (e.g., `OutOfMemoryError`).
    
- **Exception:** Recoverable conditions (e.g., `IOException`).
    

---

**106. Explain the hierarchy of Java Exception classes.**  
`Throwable` → `Error` and `Exception`

- `Exception` → `RuntimeException` (unchecked) and other checked exceptions.
    

---

**107. What is NullPointerException?**  
Thrown when the program tries to access or modify an object using a `null` reference.

---

**108. When is the ArrayStoreException thrown?**  
Thrown when storing the wrong data type into an array of objects (e.g., storing `String` into an `Integer[]`).

---

**109. Is it necessary that each try block must be followed by a catch block?**  
No. A `try` block can be followed by either a `catch` or a `finally` block (or both).

---

**110. What is exception propagation?**  
When an exception is not handled in a method, it’s passed to the calling method until handled or causes program termination.