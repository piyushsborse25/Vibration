## **📌 Complete List of Important Annotations in Spring Boot**
Spring Boot provides a wide range of annotations for **dependency injection, web development, database access, security, testing, and more**. Below is a categorized list of the **most important annotations** you need to know.

---

# **1️⃣ Spring Boot Core Annotations**
| Annotation | Description |
|------------|-------------|
| `@SpringBootApplication` | Main entry point for a Spring Boot app (combines `@Configuration`, `@EnableAutoConfiguration`, and `@ComponentScan`). |
| `@ComponentScan` | Scans the package for Spring-managed components (Beans, Controllers, Services, etc.). |
| `@Configuration` | Marks a class as a source of Spring bean definitions. |
| `@Bean` | Declares a Spring-managed **bean** inside a `@Configuration` class. |
| `@Lazy` | Initializes a bean **only when it is needed** (lazy loading). |
| `@DependsOn` | Ensures that a bean is **initialized after another bean**. |

✔ **Example:**
```java
@SpringBootApplication
public class MyApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyApplication.class, args);
    }
}
```

---

# **2️⃣ Dependency Injection (Spring IoC)**
| Annotation | Description |
|------------|-------------|
| `@Component` | Generic annotation to define a Spring bean. |
| `@Service` | Specialized `@Component` for **service layer** beans. |
| `@Repository` | Specialized `@Component` for **data access layer** beans (includes exception translation). |
| `@Controller` | Specialized `@Component` for **Spring MVC controllers**. |
| `@RestController` | Combines `@Controller` and `@ResponseBody` (returns JSON instead of views). |
| `@Autowired` | Injects a **Spring-managed bean** automatically. |
| `@Qualifier` | Specifies **which bean** to inject when multiple beans exist. |
| `@Primary` | Marks a **default bean** when multiple beans of the same type exist. |

✔ **Example:**
```java
@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired  // Automatically injects the UserRepository bean
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
```

---

# **3️⃣ Spring Boot Web Annotations (Spring MVC)**
| Annotation | Description |
|------------|-------------|
| `@RestController` | Marks a class as a **RESTful API** controller. |
| `@Controller` | Defines a controller that returns **views (HTML, JSP, etc.)**. |
| `@RequestMapping("/path")` | Maps an HTTP request to a **class or method**. |
| `@GetMapping`, `@PostMapping`, `@PutMapping`, `@DeleteMapping` | Shortcuts for HTTP request handling. |
| `@RequestParam` | Extracts query parameters from a request. |
| `@PathVariable` | Extracts dynamic values from URL paths. |
| `@RequestBody` | Binds **JSON request body** to a method parameter. |
| `@ResponseBody` | Forces a method to return **JSON instead of a view**. |

✔ **Example:**
```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(new User(id, "John Doe"));
    }
}
```

---

# **4️⃣ Spring Boot Database & JPA Annotations**
| Annotation | Description |
|------------|-------------|
| `@Entity` | Marks a class as a **JPA entity** (database table). |
| `@Table(name = "table_name")` | Specifies the database **table name**. |
| `@Id` | Defines the **primary key**. |
| `@GeneratedValue(strategy = GenerationType.IDENTITY)` | Specifies **auto-increment** for primary key. |
| `@Column(name = "column_name", unique = true, nullable = false)` | Maps a field to a **database column**. |
| `@OneToMany`, `@ManyToOne`, `@OneToOne`, `@ManyToMany` | Defines entity **relationships**. |
| `@JoinColumn(name = "column_name")` | Specifies a **foreign key**. |
| `@Transient` | Marks a field **not to be persisted** in the database. |

✔ **Example:**
```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;
}
```

---

# **5️⃣ Spring Boot Security Annotations**
| Annotation | Description |
|------------|-------------|
| `@EnableWebSecurity` | Enables Spring Security in a Spring Boot app. |
| `@Configuration` | Used with `@EnableWebSecurity` to define security configurations. |
| `@PreAuthorize("hasRole('ADMIN')")` | Restricts method execution based on roles. |
| `@Secured("ROLE_ADMIN")` | Similar to `@PreAuthorize`, but simpler. |
| `@RolesAllowed("ROLE_USER")` | Defines roles allowed to access a method. |

✔ **Example:**
```java
@EnableWebSecurity
@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests()
            .requestMatchers("/admin/**").hasRole("ADMIN")
            .anyRequest().authenticated()
            .and().formLogin();
        return http.build();
    }
}
```

---

# **6️⃣ Spring Boot Caching Annotations**
| Annotation | Description |
|------------|-------------|
| `@EnableCaching` | Enables caching in Spring Boot. |
| `@Cacheable("cacheName")` | Caches the return value of a method. |
| `@CachePut("cacheName")` | Updates the cache when a method is executed. |
| `@CacheEvict("cacheName")` | Removes an entry from the cache. |

✔ **Example:**
```java
@Cacheable("users")
public User getUserById(Long id) {
    return userRepository.findById(id).orElseThrow();
}
```

---

# **7️⃣ Spring Boot Scheduling & Asynchronous Processing**
| Annotation | Description |
|------------|-------------|
| `@EnableScheduling` | Enables Spring's **scheduler**. |
| `@Scheduled(fixedRate = 5000)` | Runs a method **every 5 seconds**. |
| `@Async` | Runs a method **asynchronously in a separate thread**. |

✔ **Example:**
```java
@Scheduled(cron = "0 0 * * * ?")
public void runEveryHour() {
    System.out.println("Task running every hour...");
}
```

---

# **8️⃣ Spring Boot Testing Annotations**
| Annotation | Description |
|------------|-------------|
| `@SpringBootTest` | Loads the full Spring Boot application context for testing. |
| `@MockBean` | Mocks a Spring bean during testing. |
| `@WebMvcTest` | Loads only the **Web layer** (for controller testing). |
| `@DataJpaTest` | Loads only the **JPA layer** (for repository testing). |
| `@Test` | Marks a **JUnit test method**. |

✔ **Example:**
```java
@SpringBootTest
class UserServiceTest {
    @Test
    void testUserService() {
        System.out.println("Running test...");
    }
}
```

---

## **🔥 Final Summary**
Spring Boot provides **many annotations**, but these are the **most important**:

✅ **Core:** `@SpringBootApplication`, `@Configuration`, `@ComponentScan`  
✅ **Dependency Injection:** `@Component`, `@Service`, `@Repository`, `@Autowired`  
✅ **Web:** `@RestController`, `@RequestMapping`, `@GetMapping`, `@RequestParam`, `@PathVariable`  
✅ **JPA:** `@Entity`, `@Table`, `@OneToMany`, `@ManyToOne`, `@GeneratedValue`  
✅ **Security:** `@EnableWebSecurity`, `@PreAuthorize`, `@Secured`  
✅ **Caching:** `@EnableCaching`, `@Cacheable`  
✅ **Scheduling:** `@EnableScheduling`, `@Scheduled`  
✅ **Testing:** `@SpringBootTest`, `@MockBean`, `@Test`