### **1. What is the size of a `byte` in Java?**

In Java, a `byte` is a primitive data type that occupies **1 byte = 8 bits** of memory.  
Each bit can store either 0 or 1, so a byte can represent **2^8 = 256** possible values.

---

### **2. What is the general formula to calculate the range of a signed data type?**

**Formula:**  
Range = -(2^(n - 1)) to (2^(n - 1) - 1)  
where `n` = number of bits available for storage.

Example:  
For n = 8 bits → Range = -(2^7) to (2^7 - 1)

---

### **3. What is the range of the `byte` type in Java using the formula?**

Since `byte` has 8 bits and is signed:

- Minimum = -2^7 = -128
    
- Maximum = 2^7 - 1 = 127
    

**Final Range: -128 to 127**

---

### **4. Why is the exponent 7 and not 8 in the formula?**

Out of 8 bits, one bit is reserved as the **sign bit**:

- 0 → positive numbers
    
- 1 → negative numbers
    

So only **7 bits** remain for storing the actual numeric value → that’s why we use 2^7.

---

### **5. Is `byte` signed or unsigned in Java? Why?**

Java’s `byte` is **signed** — it can represent both negative and positive values.  
Reason: Java uses **two’s complement representation** for all integer types, simplifying arithmetic and comparisons.

---

### **6. What is the default value of a `byte` variable?**

Default value = **0** (for instance variables).  
Note: Local variables must be explicitly initialized before use.

---

### **7. What happens if you assign a value outside the range (like 128)?**

It causes a **compile-time error**:  
`possible lossy conversion from int to byte`

If forced with casting:

```java
byte b = (byte) 128;
System.out.println(b); // Output: -128
```

The value wraps around because 128 exceeds the valid range.

---

### **8. What is overflow in `byte` and how does it work?**

Overflow occurs when the result exceeds the valid range (–128 to 127).  
Example:

```java
byte b = 127;
b++;
System.out.println(b); // Output: -128
```

Explanation:  
127 (binary 01111111) + 1 = 10000000 → represents -128 in two’s complement.

---

### **9. Why does Java use two’s complement representation?**

Reasons:

- Simplifies hardware-level arithmetic (same logic for + and –)
    
- Avoids confusion of negative zero
    
- Makes number line continuous (e.g., -128 to 127 for byte)
    

---

### **10. How to cast `int` to `byte` and compute the wrapped result using formula?**

Example:

```java
int num = 130;
byte b = (byte) num;
System.out.println(b); // Output: -126
```

**Formula for wrapped result:**  
Result = OriginalValue - 256 * k  
where `k = floor(OriginalValue / 256)`

For num = 130 →  
Result = 130 - 256 * 1 = -126

So, **(byte)130 = -126**