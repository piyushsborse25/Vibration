### 📚 Collections Hierarchy & Null Behavior
- Core interfaces: `List`, `Set`, `Queue`, `Map`
- Behavior w.r.t `null`:
  - `HashMap`: allows one null key, multiple null values
  - `Hashtable`: does **not** allow null keys/values
  - `TreeMap`: throws `NullPointerException` if comparator is used
  - `HashSet`, `LinkedHashSet`: allow one null element
  - `TreeSet`: may throw exception if comparator doesn't handle null

---

### 🔁 Iterators & ListIterator
- `Iterator`:
  - Traverses forward only
  - Methods: `hasNext()`, `next()`, `remove()`
- `ListIterator`:
  - Bidirectional traversal
  - Methods: `hasPrevious()`, `previous()`, `add()`, `set()`

---

### 👁️ Enumeration (Read-Only Interface)
- Legacy cursor used in `Vector` and `Hashtable`
- Methods: `hasMoreElements()`, `nextElement()`
- No `remove()` → **read-only**

---

### 📦 Vector, Hashtable
- Legacy classes, synchronized
- Slower than modern alternatives (`ArrayList`, `HashMap`)
- Allow thread-safe usage but not recommended in new code

---

### ⏳ BlockingQueue
- Interface from `java.util.concurrent`
- Supports producer-consumer patterns
- Blocking methods: `put()`, `take()`, `offer()`, `poll()`

---

### 📈 Load Factor
- Defines how full a hash table can get before resizing
- Default: `0.75`
- Used in `HashMap`, `HashSet`
- Impacts time-space tradeoff

---

### 🧠 IdentityHashMap
- Compares keys using `==` instead of `.equals()`
- Does not follow general `Map` contract
- Used for **object identity** rather than logical equality

---

### 🧵 Synchronized List
- Achieved using `Collections.synchronizedList(new ArrayList<>())`
- Thread-safe, but all operations are synchronized — may affect performance

---

### 🚫 Unmodifiable List
- Created using `Collections.unmodifiableList(list)`
- Throws `UnsupportedOperationException` on modification
- Useful for returning read-only views

---

### 🧽 WeakHashMap
- Keys are stored with **weak references**
- If key is no longer referenced elsewhere → entry is eligible for GC
- Good for caches or metadata mapping

---

### 🔒 Read-Only Collections
- Achieved using:
  - `List.of(...)` (Java 9+)
  - `Collections.unmodifiableXXX(...)`
- Immutable, thread-safe by design

---

### 📋 CopyOnWriteArrayList
- Thread-safe variant of `ArrayList`
- On write → creates a **copy** of the underlying array
- Good for **read-heavy, write-light** operations

---

### 🧭 EnumMap
- Specialized `Map` with `Enum` keys
- Very **efficient** and **compact**
- Keys must be from a single enum type
- Faster than `HashMap` for enum keys

---

### 🌳 Red-Black Tree
- Self-balancing BST
- Used in `TreeMap`, `TreeSet`
- Guarantees **O(log n)** operations for insert/search/delete
- Properties:
  - Each node is red or black
  - Root is black
  - No two red nodes in a row
  - Every path from root to leaf has the same number of black nodes