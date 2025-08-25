# **📌 Internal Working of `@ComponentScan` in Spring Boot**

### **1️⃣ What is `@ComponentScan`?**
`@ComponentScan` is a **Spring annotation** used to **scan and register** Spring beans (components) automatically from the specified package and its sub-packages.

🔹 **Default Behavior:**  
If no base package is specified, it **scans the package of the class where it is declared** (usually `@SpringBootApplication`).

---

### **2️⃣ How `@ComponentScan` Works Internally?**
When Spring Boot starts, the `@ComponentScan` annotation triggers a **process called component scanning**, which involves:

#### **🔹 Step 1: Identifies Classes to Scan**
Spring Boot **scans the package** and its sub-packages for classes annotated with:
- `@Component`
- `@Service`
- `@Repository`
- `@Controller`
- `@RestController`
- `@Configuration`

#### **🔹 Step 2: Uses ClassPathScanningCandidateComponentProvider**
Internally, `@ComponentScan` uses **`ClassPathScanningCandidateComponentProvider`** to find all classes annotated with `@Component` (or its derivatives).  

✔ **Example:**
```java
ClassPathScanningCandidateComponentProvider scanner =
        new ClassPathScanningCandidateComponentProvider(true);
scanner.findCandidateComponents("com.example.app");
```
- The scanner looks for all classes **within the specified package**.
- It checks if they are **annotated with `@Component` or its specializations**.
- It **registers them as Spring beans** in the ApplicationContext.

#### **🔹 Step 3: Registers Beans in the ApplicationContext**
- Once Spring finds the components, it **registers them as beans** in the `ApplicationContext`.
- The beans are **managed by Spring's IoC (Inversion of Control) container**.

✔ **Example:**
```java
ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
UserService userService = context.getBean(UserService.class);
```
- The `UserService` bean is **retrieved from the ApplicationContext** because it was **automatically scanned and registered**.

---

### **3️⃣ Example Usage of `@ComponentScan`**
#### **🔹 Default Behavior (Scanning Current Package)**
If no package is specified, Spring Boot scans the package of the class where `@SpringBootApplication` is declared.

```java
@SpringBootApplication  // Includes @ComponentScan by default
public class MyApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyApplication.class, args);
    }
}
```
✔ This automatically scans all **components inside `com.example.app` and its sub-packages**.

---

#### **🔹 Customizing `@ComponentScan` to Scan Specific Packages**
You can specify **which package(s) to scan**:
```java
@ComponentScan(basePackages = {"com.example.service", "com.example.repository"})
public class AppConfig {
}
```
✔ Spring will **only scan** `com.example.service` and `com.example.repository`.

---

#### **🔹 Excluding Certain Beans from Scanning**
You can exclude certain components from scanning using **`excludeFilters`**.
```java
@ComponentScan(
    basePackages = "com.example",
    excludeFilters = @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = Service.class)
)
public class AppConfig {
}
```
✔ This **excludes all `@Service` components** from being scanned.

---

### **4️⃣ `@ComponentScan` vs `@SpringBootApplication`**
`@SpringBootApplication` **already includes** `@ComponentScan` by default.  
If you specify a custom `@ComponentScan`, it **overrides** the default scanning.

✔ **Example:**
```java
@SpringBootApplication
@ComponentScan("com.example.custom")  // Overrides default scanning
public class MyApplication {
}
```
✔ Now Spring will **only scan `com.example.custom` and its sub-packages**.

---

### **5️⃣ When to Use `@ComponentScan`?**
✅ Use it **only when you need to scan a different package** than the one where `@SpringBootApplication` is declared.  
✅ If your components are in **a different package hierarchy**, manually specify `@ComponentScan(basePackages = "your.package")`.

---

### **💡 Summary of Internal Working**
1️⃣ `@ComponentScan` **triggers** the **ClassPathScanningCandidateComponentProvider**.  
2️⃣ It **scans** for `@Component`, `@Service`, `@Repository`, etc., inside the given package(s).  
3️⃣ Spring Boot **registers** the detected beans into the **ApplicationContext**.  
4️⃣ The beans become **available for dependency injection** (`@Autowired`).  

---

### **🚀 Final Takeaway**
- `@ComponentScan` is **automatically included** in `@SpringBootApplication`.
- Use it **only if scanning a different package** than the default.
- It works by **scanning the classpath**, finding `@Component`-like annotations, and **registering them** as Spring Beans.