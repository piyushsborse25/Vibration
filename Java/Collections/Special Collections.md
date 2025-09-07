### 🔹 **Concurrent Collections (java.util.concurrent)**

- **ConcurrentHashMap** – thread-safe map with fine-grained locking + CAS.
    
- **ConcurrentSkipListMap** – concurrent, sorted, navigable map (like TreeMap but thread-safe).
    
- **ConcurrentSkipListSet** – concurrent, sorted set (backed by ConcurrentSkipListMap).
    
- **ConcurrentLinkedQueue** – lock-free, thread-safe queue (FIFO).
    
- **ConcurrentLinkedDeque** – lock-free, thread-safe double-ended queue.
    
- **CopyOnWriteArrayList** – thread-safe list; writes make a new copy (good for read-heavy use).
    
- **CopyOnWriteArraySet** – same as above but for Set.
    
- **LinkedBlockingQueue** – blocking FIFO queue (optional capacity).
    
- **ArrayBlockingQueue** – bounded blocking queue, backed by array.
    
- **PriorityBlockingQueue** – unbounded blocking priority queue.
    
- **DelayQueue** – queue with delayed elements, only available when delay expires.
    
- **SynchronousQueue** – zero-capacity queue, each insert waits for a remove.
    
- **LinkedTransferQueue** – high-performance unbounded transfer queue (like SynchronousQueue + LinkedBlockingQueue combined).
    

---

### 🔹 **Legacy but Thread-Safe Collections**

- **Vector** – synchronized list (old).
    
- **Stack** – extends Vector, LIFO stack (old).
    
- **Hashtable** – synchronized map (old).
    
- **Properties** – subclass of Hashtable, used for configs.
    

---

### 🔹 **Special Purpose Collections**

- **WeakHashMap** – keys stored as weak references; entries removed when key GC’d.
    
- **IdentityHashMap** – uses `==` instead of `.equals()` for key comparison.
    
- **EnumMap** – high-performance map with enum keys.
    
- **EnumSet** – high-performance set with enum elements.
    
- **TreeMap** – sorted map (Red-Black tree).
    
- **TreeSet** – sorted set (backed by TreeMap).
    