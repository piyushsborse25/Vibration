### **Spring Boot Specifications (JPA Criteria API)**
Spring Boot **Specifications** are a powerful way to dynamically build queries using the **JPA Criteria API**. They allow complex filtering conditions while keeping the code clean and reusable.

---

## **1. What is a Specification in Spring Boot?**
A **Specification** is a **functional interface** from `org.springframework.data.jpa.domain.Specification` that allows dynamic query generation using predicates.

It is used when:
- You need **dynamic filtering** (e.g., based on user input).
- You want to **avoid writing multiple repository methods** for different queries.
- You need **complex WHERE conditions** (AND, OR, JOIN, LIKE, IN, etc.).

---

## **2. Basic Example: Using Specification in Spring Boot**
### **Step 1: Define Your Entity**
```java
@Entity
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String department;
    private Double salary;
    
    // Getters and Setters
}
```

### **Step 2: Implementing the Specification**
```java
import org.springframework.data.jpa.domain.Specification;
import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

public class EmployeeSpecifications {
    public static Specification<Employee> hasDepartment(String department) {
        return (root, query, criteriaBuilder) -> 
            department == null ? null : criteriaBuilder.equal(root.get("department"), department);
    }

    public static Specification<Employee> hasSalaryGreaterThan(Double salary) {
        return (root, query, criteriaBuilder) -> 
            salary == null ? null : criteriaBuilder.greaterThan(root.get("salary"), salary);
    }
}
```

### **Step 3: Extend `JpaSpecificationExecutor` in Repository**
```java
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface EmployeeRepository extends JpaRepository<Employee, Long>, JpaSpecificationExecutor<Employee> {
}
```

### **Step 4: Using Specifications in a Service**
```java
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EmployeeService {
    private final EmployeeRepository employeeRepository;

    public EmployeeService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    public List<Employee> searchEmployees(String department, Double minSalary) {
        Specification<Employee> spec = Specification.where(EmployeeSpecifications.hasDepartment(department))
                                                   .and(EmployeeSpecifications.hasSalaryGreaterThan(minSalary));
        return employeeRepository.findAll(spec);
    }
}
```

---

## **3. Advanced Queries: Combining Multiple Conditions**
### **Using `Specification.where()` for Dynamic Queries**
```java
Specification<Employee> spec = Specification.where(null);

if (department != null) {
    spec = spec.and(EmployeeSpecifications.hasDepartment(department));
}

if (minSalary != null) {
    spec = spec.and(EmployeeSpecifications.hasSalaryGreaterThan(minSalary));
}

List<Employee> employees = employeeRepository.findAll(spec);
```
This approach ensures that only non-null filters are applied dynamically.

---

## **4. Pagination and Sorting with Specifications**
Spring Data JPA supports pagination with `Pageable` when using Specifications.

```java
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public Page<Employee> searchEmployees(String department, Double minSalary, Pageable pageable) {
    Specification<Employee> spec = Specification.where(EmployeeSpecifications.hasDepartment(department))
                                               .and(EmployeeSpecifications.hasSalaryGreaterThan(minSalary));

    return employeeRepository.findAll(spec, pageable);
}
```
Now, you can call:
```java
Pageable pageable = PageRequest.of(0, 10, Sort.by("name").ascending());
Page<Employee> result = employeeService.searchEmployees("IT", 50000.0, pageable);
```

---

## **5. Using Specifications with `CriteriaBuilder` for Complex Queries**
If the conditions are complex, you can create a **custom specification** using `Predicate`.

```java
public static Specification<Employee> hasCustomFilter(String department, Double minSalary) {
    return (root, query, criteriaBuilder) -> {
        List<Predicate> predicates = new ArrayList<>();

        if (department != null) {
            predicates.add(criteriaBuilder.equal(root.get("department"), department));
        }
        if (minSalary != null) {
            predicates.add(criteriaBuilder.greaterThan(root.get("salary"), minSalary));
        }
        
        return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
    };
}
```
Now, call:
```java
Specification<Employee> spec = EmployeeSpecifications.hasCustomFilter("HR", 60000.0);
List<Employee> employees = employeeRepository.findAll(spec);
```

---

## **6. Advantages of Using Specifications**
✅ **Dynamic Queries**: No need to create multiple repository methods for different filters.  
✅ **Reusable Conditions**: Write once, use in multiple queries.  
✅ **Supports Complex Filters**: Including AND, OR, LIKE, IN, JOIN, etc.  
✅ **Works with Pagination & Sorting**: Improves performance for large datasets.  

---

## **Conclusion**
- **Specifications** in Spring Boot simplify **dynamic filtering** using **JPA Criteria API**.
- They are **highly flexible** and allow combining conditions dynamically.
- **Best suited** for applications requiring **custom search filters** with multiple conditions.