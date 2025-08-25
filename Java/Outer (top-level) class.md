For an **outer (top-level) class**, the following **keywords** are allowed:

### ✅ **Allowed Keywords for Outer Class Declarations**
- `public`
- `abstract`
- `final`
- `strictfp`
- `sealed` *(Java 17+)*
- `non-sealed` *(Java 17+)*

---

### ❌ **Not Allowed for Outer Class**:
- `static` (Only for nested classes)
- `private` (Only for inner classes)
- `protected` (Only for inner classes)
- `class` (This is not a keyword for the class declaration itself)

So, the outer class can be **public**, **abstract**, **final**, etc., but **not static**.

---

For an **inner (nested) class**, the following **keywords** are allowed:

### ✅ **Allowed Keywords for Inner Class Declarations**
- `public`
- `protected`
- `private`
- `abstract`
- `final`
- `static`
- `strictfp`
- `sealed` *(Java 17+)*
- `non-sealed` *(Java 17+)*

---

### ❌ **Not Allowed for Inner Class**:
- `None`

So, inner classes can use **`static`**, **`private`**, and **`protected`**, which are not allowed for outer classes.

---

### **Outer Class Subclassing**:
Here’s the **yes/no** table for whether an **outer class** can be subclassed based on the possible keywords used in its declaration:

| Keyword       | Subclassing Allowed? |
|---------------|----------------------|
| `public`      | ✅ Yes               |
| `abstract`    | ✅ Yes               |
| `final`       | ❌ No                |
| `strictfp`    | ✅ Yes               |
| `sealed`      | ✅ Yes (restricted via `permits`) |
| `non-sealed`  | ✅ Yes               |

- **`public`, `abstract`, `strictfp`, `sealed`, `non-sealed`**: These allow subclassing (with `sealed` being restricted to specific classes if defined).
- **`final`**: Disallows subclassing entirely.

---

### **Inner Class Subclassing**:
Here’s the **yes/no** table for whether an **inner (nested) class** can be subclassed based on the possible keywords used in its declaration:

| Keyword       | Subclassing Allowed? |
|---------------|----------------------|
| `public`      | ✅ Yes               |
| `protected`   | ✅ Yes               |
| `private`     | ❌ No (can’t be accessed from outside the outer class) |
| `abstract`    | ✅ Yes               |
| `final`       | ❌ No                |
| `static`      | ✅ Yes               |
| `strictfp`    | ✅ Yes               |
| `sealed`      | ✅ Yes (restricted via `permits`) |
| `non-sealed`  | ✅ Yes               |

- **`public`, `protected`, `abstract`, `static`, `strictfp`, `sealed`, `non-sealed`**: These allow subclassing (with `sealed` being restricted to specific classes if defined).
- **`private`**: Disallows subclassing outside the outer class, as it can't be accessed outside.
- **`final`**: Disallows subclassing entirely.