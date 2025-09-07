## 1️⃣ **Thread-Safe / Concurrent Collections**

These are modern, high-performance replacements for legacy synchronized collections.

- **Maps**
    
    - `ConcurrentHashMap` → thread-safe hash map using CAS + fine-grained locking.
        
    - `ConcurrentSkipListMap` → thread-safe, sorted map (like TreeMap).
        
- **Sets**
    
    - `ConcurrentSkipListSet` → thread-safe, sorted set.
        
    - `CopyOnWriteArraySet` → write = copy, good for read-heavy scenarios.
        
- **Lists**
    
    - `CopyOnWriteArrayList` → thread-safe, snapshot-based list.
        
- **Queues / Deques**
    
    - Non-blocking (lock-free, fast):
        
        - `ConcurrentLinkedQueue` → FIFO.
            
        - `ConcurrentLinkedDeque` → double-ended.
            
    - Blocking (threads wait if full/empty):
        
        - `LinkedBlockingQueue` → linked, optional capacity.
            
        - `ArrayBlockingQueue` → array-backed, fixed capacity.
            
        - `PriorityBlockingQueue` → unbounded, ordered by priority.
            
        - `DelayQueue` → elements released after delay.
            
        - `SynchronousQueue` → zero-capacity, producer ↔ consumer handoff.
            
        - `LinkedTransferQueue` → hybrid, supports transfer of elements directly between threads.
            

---

## 2️⃣ **Legacy Thread-Safe Collections**

Old synchronized collections — not recommended now (slower).

- `Vector` (old synchronized ArrayList).
    
- `Stack` (extends Vector, LIFO).
    
- `Hashtable` (old synchronized HashMap).
    
- `Properties` (subclass of Hashtable, for configs).
    

---

## 3️⃣ **Special-Purpose Collections**

Collections with unique behaviors (not just thread-safety).

- **Weak / Identity**
    
    - `WeakHashMap` → keys weakly referenced, auto-removed when GC’d.
        
    - `IdentityHashMap` → compares keys with `==` (identity), not `.equals()`.
        
- **Enum-based**
    
    - `EnumMap` → fast map keyed by enums.
        
    - `EnumSet` → fast set storing enums.
        
- **Sorted**
    
    - `TreeMap` → sorted map (Red-Black tree).
        
    - `TreeSet` → sorted set (backed by TreeMap).
        

---

# 📌 How to Remember

- **Concurrent** → `ConcurrentHashMap`, `ConcurrentSkipListMap`, `ConcurrentLinkedQueue`, etc.
    
- **CopyOnWrite** → read-heavy scenarios (`CopyOnWriteArrayList`, `CopyOnWriteArraySet`).
    
- **Blocking Queues** → producer-consumer patterns.
    
- **Legacy** → `Vector`, `Stack`, `Hashtable`.
    
- **Special** → `WeakHashMap`, `IdentityHashMap`, `EnumMap`, `EnumSet`.
    
- **Sorted** → `TreeMap`, `TreeSet`, `ConcurrentSkipListMap`, `ConcurrentSkipListSet`.
    