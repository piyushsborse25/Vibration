**165. Name some classes present in the `java.util.regex` package.**  
The `java.util.regex` package provides classes for pattern matching with regular expressions.  
Main classes:

1. **`Pattern`** – Represents a compiled regular expression.
    
2. **`Matcher`** – Performs match operations on a character sequence using a `Pattern`.
    
3. **`PatternSyntaxException`** – Thrown when a regular expression has invalid syntax.
    

Example:

```java
Pattern pattern = Pattern.compile("[a-z]+");
Matcher matcher = pattern.matcher("hello");
boolean matchFound = matcher.matches();
```

---

**166. Write a regular expression to validate a password.**  
A strong password typically includes at least one uppercase letter, one lowercase letter, one digit, one special character, and a minimum length of 8.

**Regex Pattern:**

```
^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!]).{8,}$
```

**Explanation:**

- `(?=.*[0-9])` → At least one digit
    
- `(?=.*[a-z])` → At least one lowercase letter
    
- `(?=.*[A-Z])` → At least one uppercase letter
    
- `(?=.*[@#$%^&+=!])` → At least one special character
    
- `.{8,}` → Minimum length 8
    

**Example in Java:**

```java
String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!]).{8,}$";
Pattern pattern = Pattern.compile(regex);
Matcher matcher = pattern.matcher("Password@123");
System.out.println(matcher.matches());  // true
```