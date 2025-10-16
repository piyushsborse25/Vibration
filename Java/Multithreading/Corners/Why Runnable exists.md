### **Reason for Runnable**

1. **Java supports only single inheritance**
    
    - A class can **extend only one other class**.
        
    - If you extend `Thread`, your class **cannot extend anything else**.
        
    - Using `Runnable`, your class can **implement Runnable** and still **extend another class** if needed.
        
2. **Separation of task and execution**
    
    - `Runnable` separates **what the task does** (the `run()` method) from **how it is executed** (the `Thread` that runs it).
        
    - This allows **more flexible design** and better decoupling.
        
3. **Reusability**
    
    - A single `Runnable` object can be passed to **multiple threads**.
        
    - Example: multiple threads running the same task without creating multiple Thread subclasses.
        
4. **Consistency with Executor framework**
    
    - `Runnable` is the standard interface used in the **ExecutorService** and other concurrency utilities.
        
    - You cannot pass a `Thread` subclass directly to an executor; you pass a `Runnable` or `Callable`.
        

---

**In short:**

- `Thread` = **represents the thread itself** (mechanism of execution)
    
- `Runnable` = **represents the task to be executed** (logic of execution)
    

✅ Runnable exists to **decouple task from thread**, allow **flexibility**, and **support multiple inheritance scenarios**.