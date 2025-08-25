# @ComponentScan:
It scans the application and tells Spring Boot where to search for annotated components like `@RestController`, `@Component`, `@Service`, and `@Repository` to create and load the beans in the application context.

---

# Classpath Scan:
When Spring Boot starts, it scans `spring.factories` to find all auto-configuration classes.

---

# What is the role of SpringFactoriesLoader in Spring Boot:
It loads configuration classes defined in `META-INF/spring.factories`.

---

# How does Spring Boot auto-configuration work internally?
1. Spring Boot provides the feature of **starters-pom**.
2. Whenever we add any dependency in our `pom.xml` like `spring-boot-starter-web`, which is a predefined set of dependencies.
3. **`@EnableAutoConfiguration`** triggers the auto-configuration classes for that and automatically configures beans based on the dependencies in your application’s classpath.
4. In any Spring Boot application, there is a jar called `spring-boot-auto-configuration.jar` which includes all auto-configuration classes.
5. Spring Boot uses **`@Conditional`** annotations to determine whether specific configurations should be applied.

---

# How does Spring Boot decide the order of bean initialization?
Spring Boot uses the following annotations to control bean initialization order:
- **`@DependsOn`**
- **`@Order`**
- **`@Priority`**

---

# How to resolve circular dependencies:
Use **`@Lazy`** and **`@DependsOn`**.

---

# What are the common pitfalls of using JPA with Spring Boot, and how do you avoid them?
- **N+1 Queries:** You can use `@EntityGraph` or `JOIN FETCH` to resolve this issue.
