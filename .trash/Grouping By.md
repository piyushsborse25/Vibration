Here’s a well-structured breakdown of **Java Stream API – Grouping & Advanced Operations**, suitable for Obsidian:

---

## 🔶 Java Stream API

### 📌 Grouping & Advanced Operations

---

### 🧩 `Collectors.groupingBy()`

* Groups stream elements by a classifier function.

```java
Map<String, List<Employee>> employeesByDept =
    employees.stream().collect(Collectors.groupingBy(Employee::getDepartment));
```

---

### 🧠 Grouping with Downstream Collectors

```java
Map<String, Long> countByDept =
    employees.stream().collect(Collectors.groupingBy(Employee::getDepartment, Collectors.counting()));

Map<String, Double> avgSalaryByDept =
    employees.stream().collect(Collectors.groupingBy(Employee::getDepartment, Collectors.averagingDouble(Employee::getSalary)));
```

---

### ⚙️ `Collectors.mapping()`

* Transform grouped values before collecting.

```java
Map<String, List<String>> employeeNamesByDept =
    employees.stream().collect(Collectors.groupingBy(Employee::getDepartment,
                               Collectors.mapping(Employee::getName, Collectors.toList())));
```

---

### 📚 Multi-Level Grouping

```java
Map<String, Map<String, List<Employee>>> multiGroup =
    employees.stream().collect(Collectors.groupingBy(Employee::getDepartment,
                               Collectors.groupingBy(Employee::getRole)));
```

---

### 🧮 `partitioningBy()` (Boolean-based grouping)

```java
Map<Boolean, List<Employee>> partitioned =
    employees.stream().collect(Collectors.partitioningBy(e -> e.getSalary() > 50000));
```

---

### 🧾 `Collectors.collectingAndThen()`

* Post-process the result of a collector.

```java
Map<String, Set<String>> immutable =
    employees.stream().collect(Collectors.groupingBy(Employee::getDepartment,
                               Collectors.collectingAndThen(
                                   Collectors.mapping(Employee::getName, Collectors.toSet()),
                                   Collections::unmodifiableSet)));
```

---

### 🌀 Custom Collector (Advanced)

* Create custom accumulation behavior.

```java
Collector<Employee, ?, Map<String, Integer>> customCollector = Collector.of(
    HashMap::new,
    (map, emp) -> map.merge(emp.getDepartment(), 1, Integer::sum),
    (m1, m2) -> { m2.forEach((k,v) -> m1.merge(k, v, Integer::sum)); return m1; }
);
```

---

Let me know if you want examples with a custom `Employee` class or want to visualize this in a sample project structure.
