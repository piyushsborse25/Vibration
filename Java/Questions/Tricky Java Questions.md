### **I. Object-Oriented Programming (OOP)**
1. Can you override a private or static method in Java? Why or why not?
2. What is the "diamond problem" in inheritance, and how does Java resolve it with interfaces?
3. Explain the difference between "IS-A" and "HAS-A" relationships in Java with examples.
4. What happens if a constructor throws an exception? Does the object get created?
5. Can you call a constructor of a class multiple times for the same object? Why or why not?
6. What happens if a subclass has a method with the same name as a private method in the superclass? Is this considered overriding?
7. Can you declare an abstract class without any abstract methods? Why would you do that?
8. How does Java achieve runtime polymorphism? Can method overloading achieve the same?
9. If a class implements two interfaces with the same default method, how does Java resolve the conflict?
10. What happens if a superclass constructor calls an overridden method in a subclass? What are the risks?
11. Can you have a class that is both `final` and `abstract`? Why or why not?
12. Is it possible to cast an object of one type to another unrelated type? Under what conditions?
13. What is the difference between "composition over inheritance"? Why is it preferred?
14. Can you create an instance of an abstract class in Java? If yes, how?

### **II. Exception Handling**
15. What happens if a `finally` block contains a `return` statement? Does it override exceptions thrown in the `try` block?
16. Explain the difference between `throw` and `throws`. Can you use `throws` with a `RuntimeException`?
17. Can you catch an exception thrown in the `static` block of a class? Why or why not?
18. What happens if an exception is thrown in the `catch` block? Does the `finally` block execute?
19. Can a `try` block exist without a `catch` block? What is the purpose of such a construct?
20. Can you catch multiple exceptions in a single `catch` block? How is this implemented?
21. What happens if an exception is thrown in a constructor? Will the object still be partially constructed?
22. Explain how exception chaining works in Java and why you would use it.
23. Is it possible to have multiple `finally` blocks in a `try` statement?
24. Can you declare a `throws` clause for a method that doesn't throw any exceptions? Why?
25. What happens if you call `throw null` in Java? Will it compile and execute?
26. Is it possible for a `catch` block to handle multiple unrelated exception types?
27. Can you define an exception class without extending `Throwable`? What happens?
28. What happens if you catch `Error` or `Throwable` instead of specific exceptions?

### **III. Memory Management & JVM Internals**
29. What is the difference between stack memory and heap memory? Where are `static` variables stored?
30. Explain the lifecycle of an object in the JVM from creation to garbage collection.
31. What is the purpose of the `finalize()` method? Why is it deprecated in Java?
32. Can you prevent an object from being garbage collected? If so, how?
33. What is a memory leak in Java? Give examples of code that could lead to memory leaks.
34. What is the role of `permgen` space (pre-Java 8) vs. `Metaspace` (Java 8+)? Why was this change introduced?
35. How does the JVM handle method overloading and overriding at runtime?
36. Explain how the `invokedynamic` instruction works and how it improves performance.
37. What is escape analysis in JVM, and how does it optimize memory allocation?
38. What is the significance of the `-XX:+UseG1GC` JVM option? When would you use it?
39. What happens if you dynamically load a class using `Class.forName()` vs static loading?
40. How does the JVM optimize bytecode during runtime (JIT compilation)?
41. What is the difference between `Heap` and `Non-Heap` memory in the JVM?
42. What is the role of the `Code Cache` area in the JVM?
43. Explain how method inlining works in the JVM and how it improves performance.

### **IV. Multithreading & Concurrency**
44. What is the difference between a `synchronized` block and a `synchronized` method? Which is more efficient?
45. How does the `volatile` keyword ensure thread safety? Does it guarantee atomicity?
46. Explain the difference between `wait()`, `notify()`, and `notifyAll()`. Why are they part of `Object` and not `Thread`?
47. What is a "race condition"? How can it be avoided in Java?
48. Can a `Thread` start twice? What happens if you call `start()` on a thread that has already started?
49. How does the Java Memory Model (JMM) ensure visibility and ordering of shared variables?
50. What are the differences between `synchronized` and `Lock` from `java.util.concurrent.locks`?
51. Explain the difference between `Thread.yield()`, `Thread.sleep()`, and `Thread.join()`.
52. What happens if a thread calls `wait()` on an object without holding the lock?
53. Can `volatile` variables guarantee thread safety for increment operations? Why or why not?
54. Can a thread acquire multiple locks at the same time? What problems can this lead to?
55. What is the difference between a live lock and a deadlock? Provide examples.
56. Can you implement a thread-safe singleton without using `synchronized`? If so, how?
57. What is the difference between `ThreadLocalRandom` and `Random`?
58. Explain the difference between `AtomicInteger` and using `synchronized` for increment operations.
59. What is the difference between `Object`'s `wait()` method and `Thread.sleep()`?

### **V. Collections Framework**
60. How does `HashMap` handle hash collisions? What is the difference between chaining and open addressing?
61. Why is `HashMap` not thread-safe? How does `ConcurrentHashMap` resolve this?
62. What is the difference between `Comparable` and `Comparator`? Can a class implement both?
63. What is the difference between `IdentityHashMap` and `HashMap`?
64. Why are `ArrayList` and `LinkedList` not synchronized? How can you make them thread-safe?
65. How does `LinkedHashSet` maintain insertion order? How does it handle hash collisions?
66. Explain the significance of the `load factor` in `HashMap` and how it impacts performance.
67. Can you store `null` as a key in `TreeMap`? Why or why not?
68. What happens when you modify an object that is used as a key in a `HashMap`?
69. What is the difference between `ConcurrentSkipListMap` and `TreeMap`?
70. How does `PriorityQueue` ensure the order of elements? Can it contain `null` elements?
71. What is the difference between a `Deque` and a `Queue`? How does `ArrayDeque` optimize over `LinkedList`?
72. How does a `ConcurrentHashMap` split its buckets for thread safety?
73. What happens if you use a mutable object as a key in a `TreeMap`?
74. Why is `Collections.unmodifiableList()` not truly immutable? How does it behave differently from `List.of()`?
75. What happens if you add a `null` element to a `TreeSet`?

### **VI. Strings & Immutability**
76. Why is the `String` class immutable in Java? What are the benefits of immutability?
77. What is the difference between `String`, `StringBuilder`, and `StringBuffer`?
78. Can two different `String` objects with the same value have different hash codes?
79. What is the difference between `==` and `.equals()` when comparing strings?
80. How does the `intern()` method work in the `String` class?
81. How does the String pool in Java work? Can you disable it?
82. What happens if you use `String.intern()` on a dynamically created string?
83. Why is `String` immutable, but `StringBuilder` and `StringBuffer` are not?
84. What are the memory implications of using `String` concatenation with `+` operator in a loop?
85. How does `String` deduplication work in Java 9+?
86. What happens if you modify a string using reflection? Will it still be immutable?
87. How is a `String` represented internally in Java 9+?
88. Can you use a `String` as a key in a `HashMap`? What are the implications?
89. How does `String` interning differ before and after Java 7?

### **VII. Class Loading & Initialization**
90. What are the differences between `static` and instance initialization blocks?
91. What is the order of execution for `static` blocks, instance blocks, and constructors?
92. What are the different types of class loaders in Java? How do they work?
93. What happens if a static variable is accessed before the class is loaded?
94. Explain the difference between eager and lazy initialization with examples.
95. How does the parent delegation model work in Java class loading? Can it be overridden?
96. What is the difference between `bootstrap`, `extension`, and `application` class loaders?
97. How would you use a custom class loader to load classes at runtime?
98. What happens if two different class loaders load the same class? Are the objects compatible?
99. Can you dynamically reload a class in Java? How?
100. What is the difference between `NoClassDefFoundError` and `ClassNotFoundException`?
101. Can you load a class twice in Java using custom class loaders?
102. What happens if the `main()` method is declared as `private`? Will it execute?
103. Can a static block throw exceptions? How does the JVM handle it?

### **VIII. Advanced Topics & Keywords**
104. What is the difference between shallow copy and deep copy? How do you implement them?
105. How does the `clone()` method work? Why is it discouraged in modern Java?
106. What is the difference between `SoftReference`, `WeakReference`, and `PhantomReference`?
107. Explain the `transient` and `volatile` keywords and how they differ.
108. Can you serialize a class with a static variable? What happens to the static variable after deserialization?
109. What is the difference between `final`, `finally`, and `finalize()`?
110. Can you use the `abstract` keyword with a constructor? Why or why not?
111. Can an `interface` extend a `class`? Why or why not?
112. What happens if you declare a method `native`? When would you use it?
113. Can a `final` method be overloaded? Why or why not?
114. What happens if you declare a variable as `final` but do not initialize it immediately?
115. What is the difference between `transient` and `volatile`? Can they be used together?
116. Why can't a `static` method be abstract in Java?
117. What happens if you declare a class as `static`? In what contexts is this allowed?
118. Can an interface contain `static` methods? Why was this introduced in Java 8?
119. What does the `strictfp` keyword do? When would you use it?
120. What is the difference between `synchronized(this)` and `synchronized(className.class)`?
121. Can you use `super` to call a method in a grandparent class directly?

### **IX. Serialization**
122. How can you exclude certain fields from being serialized using `transient`?
123. What happens if a serialized class changes its structure? How can you maintain compatibility?
124. Can you serialize a static field? Why or why not?
125. What is the role of `writeReplace()` and `readResolve()` methods in serialization?
126. Explain custom serialization using the `Externalizable` interface.
127. Can you serialize an inner class? What are the constraints?
128. What happens if a serialized class doesn't have a `serialVersionUID`?
129. Can you customize serialization using `writeObject` and `readObject`?
130. Is it possible to serialize an object containing circular references?
131. How does `transient` work with `final` fields? Can a `final` field be `transient`?

### **X. Reflection & Annotations**
132. Can you use reflection to access private fields and methods? How?
133. What is the difference between `Class.forName()` and `ClassLoader.loadClass()`?
134. How does reflection affect performance? When should you avoid it?
135. What are the security implications of using reflection?
136. How do you create objects dynamically using reflection?
137. What is the difference between marker annotation and regular annotation?
138. How does Java handle runtime retention for annotations (`@Retention(RUNTIME)`)?
139. Can annotations have default values? How are they defined?
140. What is a meta-annotation in Java? Provide examples.
141. How would you process custom annotations at runtime?
142. Can you create an object of a private class using reflection?
143. How does `Proxy` in `java.lang.reflect` work? Can it proxy multiple interfaces?
144. What is the difference between `Method.invoke()` and direct method calls?
145. Can you use reflection to bypass `final` field immutability?

### **XI. Lambda Expressions & Streams**
146. Can you use `this` inside a lambda expression? How does it behave vs anonymous classes?
147. What happens if you use a `Stream` after its terminal operation?
148. How does `reduce()` work in streams? What is the significance of the identity parameter?
149. What is the difference between `flatMap()` and `map()`?
150. Can you parallelize a `Stream` that operates on non-thread-safe collections?

### **XII. Miscellaneous Advanced Concepts**
151. What is the difference between `System.out`, `System.err`, and `System.in`?
152. How is a `HashSet` implemented internally? Why does it not allow duplicates?
153. Explain why `Enum` is a special type of class and how it handles singleton behavior.
154. What is the difference between pass by value and pass by reference? Is Java pass-by-reference?
155. What are "zombie objects" in Java? How can they occur?
156. Explain the difference between `System.gc()` and `Runtime.getRuntime().gc()`.
157. Why are wrapper classes (`Integer`, `Double`, etc.) immutable? How does autoboxing affect this?
158. Can you force the JVM to execute code after a `System.exit()` call?
159. What is a daemon thread? How does it differ from a user thread?
160. How does Java handle circular dependencies between classes?
161. Can a method be `synchronized` and `native` at the same time?
162. What happens if you override `hashCode()` but not `equals()`?
163. Why doesn't Java support multiple inheritance for classes but allows it for interfaces?