When two beans of the same type are present in the Spring context, Spring encounters a **conflict in bean resolution**. How Spring handles this situation depends on the configuration and annotations used. Below are different scenarios and their resolutions:

### **1. Without Any Resolution (Ambiguity Issue)**
If two beans of the same type exist and Spring is unable to determine which one to inject, it will throw an **`org.springframework.beans.factory.NoUniqueBeanDefinitionException`**.

**Example:**
```java
@Component
class ServiceA { }

@Component
class ServiceB { }

@Component
class MyComponent {
    private final ServiceA service;

    @Autowired
    public MyComponent(ServiceA service) {  // Ambiguity issue if two beans of ServiceA exist
        this.service = service;
    }
}
```
### **2. Using `@Primary` (Preferred Bean)**
The `@Primary` annotation marks one bean as the **default** when multiple beans of the same type exist.

**Example:**
```java
@Component
@Primary
class ServiceA implements MyService { }

@Component
class ServiceB implements MyService { }
```
Now, `ServiceA` will be injected whenever a `MyService` bean is required unless explicitly overridden.

### **3. Using `@Qualifier` (Explicit Selection)**
The `@Qualifier` annotation allows explicit selection of a bean by name.

**Example:**
```java
@Component("serviceA")
class ServiceA implements MyService { }

@Component("serviceB")
class ServiceB implements MyService { }

@Component
class MyComponent {
    private final MyService service;

    @Autowired
    public MyComponent(@Qualifier("serviceB") MyService service) {
        this.service = service; // ServiceB will be injected
    }
}
```

### **4. Using `@Bean` with Method Names**
When defining beans manually in a `@Configuration` class, method names become the default bean names.

**Example:**
```java
@Configuration
class AppConfig {
    @Bean
    public MyService serviceA() {
        return new ServiceA();
    }

    @Bean
    public MyService serviceB() {
        return new ServiceB();
    }
}
```
Here, you need to explicitly specify which one to use with `@Qualifier` or `@Primary`.

### **5. Using `@Profile` (Conditional Beans)**
The `@Profile` annotation allows defining beans that load only in specific environments.

**Example:**
```java
@Component
@Profile("dev")
class DevService implements MyService { }

@Component
@Profile("prod")
class ProdService implements MyService { }
```
Spring will load `DevService` in the **dev** profile and `ProdService` in the **prod** profile.

---

### **Conclusion**
- **Without resolution:** Spring throws `NoUniqueBeanDefinitionException`.
- **With `@Primary`**: One bean is marked as the default.
- **With `@Qualifier`**: A specific bean is explicitly chosen.
- **With `@Profile`**: Beans are loaded based on environment profiles.
- **With Factory Methods (`@Bean`)**: The method name serves as the bean name.