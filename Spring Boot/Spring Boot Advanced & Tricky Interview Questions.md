### **Spring Boot Advanced & Tricky Interview Questions (Categorized)**  

---

## **1️⃣ Spring Boot Core & Auto-Configuration**  
1. How does Spring Boot auto-configuration work internally?  
2. What happens when multiple beans of the same type exist in the context?  
3. How does Spring Boot determine which embedded server to use?  
4. What is `spring.factories`, and how does Spring Boot utilize it?  
5. What happens if `spring-boot-starter-web` is excluded from the classpath?  
6. Can we have multiple `@SpringBootApplication` classes in a single project?  
7. How does `@ComponentScan` differ from `@SpringBootApplication`?  
8. How does Spring Boot handle application property precedence (YAML, Properties, CLI arguments, etc.)?  
9. What happens if two auto-configuration classes try to configure the same bean?  
10. How does `@SpringBootApplication(exclude = {SomeAutoConfig.class})` work?  

---

## **2️⃣ Dependency Injection & Bean Scope**  
11. What are the differences between `@Component`, `@Service`, and `@Repository`?  
12. How does Spring Boot handle circular dependencies, and how can they be resolved?  
13. What happens if a `@Bean` method returns `null`?  
14. Can we inject a bean into a static field in Spring Boot? How?  
15. What is the difference between `@Primary` and `@Qualifier`?  
16. How does `@Lazy` affect bean initialization and dependency injection?  
17. What is the default scope of a Spring bean, and how does `@Scope("prototype")` affect dependency injection?  
18. How does `@DependsOn` work in Spring Boot?  
19. How does Spring Boot handle `@PostConstruct` and `@PreDestroy` in bean lifecycle?  
20. What happens when a bean implements `InitializingBean` or `DisposableBean`?  

---

## **3️⃣ Spring Boot Annotations & Configuration**  
21. What is the difference between `@ConditionalOnProperty` and `@ConditionalOnClass`?  
22. What happens if a bean is defined in both `application.properties` and `@Configuration` class?  
23. Can we define a `@Bean` inside a `@Component` class instead of a `@Configuration` class?  
24. How does `@PropertySource` work in Spring Boot?  
25. What is the purpose of `@EnableAutoConfiguration`?  
26. How does Spring Boot resolve placeholders in properties (`${property.name}`)?  
27. Can we override properties loaded from `application.properties` using environment variables?  
28. How does `@EnableConfigurationProperties` differ from `@ConfigurationProperties`?  
29. What happens if we define a `@Bean` method with the same name in multiple configuration classes?  
30. How does `@Value("${some.property}")` work internally?  

---

## **4️⃣ Spring Boot AOP (Aspect-Oriented Programming)**  
31. What are the differences between `@Before`, `@After`, `@Around`, and `@AfterReturning` in Spring AOP?  
32. How does Spring AOP proxying work internally?  
33. What happens when multiple aspects are applied to the same method?  
34. How does `@Around` advice modify method arguments and return values?  
35. How do we prevent Spring AOP from proxying private methods?  
36. What happens if an exception is thrown inside an `@AfterThrowing` advice?  
37. Can we apply multiple advices (`@Before`, `@After`) to the same method?  
38. How can we use Spring AOP for method execution time logging?  
39. What happens if `@Transactional` and `@Async` are applied to the same method?  
40. How does Spring handle AOP proxies with `CGLIB` vs `JDK dynamic proxies`?  

---

## **5️⃣ Spring Boot Transactions & JPA**  
41. How does Spring Boot handle transactions by default?  
42. What happens if a `@Transactional` method is called from the same class?  
43. Can we use `@Transactional` on private or static methods?  
44. How do we manually trigger a rollback in Spring Boot transactions?  
45. What are the different propagation levels in Spring Boot transactions?  
46. How does Spring handle transaction isolation levels?  
47. What happens if an exception occurs inside a `@Transactional` method but is not thrown explicitly?  
48. How can we use programmatic transactions in Spring Boot instead of `@Transactional`?  
49. What is the difference between `@Transactional(readOnly = true)` and `@Transactional`?  
50. What happens when an exception occurs inside a method marked with `@Transactional`?  

---

## **6️⃣ Spring Boot Caching & Performance Optimization**  
51. What is the difference between `@Cacheable`, `@CachePut`, and `@CacheEvict`?  
52. How does Spring Boot handle caching, and what are the different caching providers?  
53. How can we use Redis as a cache in Spring Boot?  
54. What happens if a cache entry expires while a request is processing?  
55. How can we prevent a cache stampede problem in Spring Boot?  
56. What are the best practices for handling high-load caching in Spring Boot?  
57. How can we implement a rate limiter in Spring Boot?  
58. How does Spring Boot optimize database connection pooling?  
59. What is the purpose of `spring.datasource.hikari.maximum-pool-size`?  
60. How can we measure the execution time of a method dynamically?  

---

## **7️⃣ Spring Boot Security & Authentication**  
61. How does Spring Boot handle session management in stateless authentication?  
62. What is the difference between JWT and OAuth2 in Spring Security?  
63. How do you prevent session fixation attacks in Spring Security?  
64. How does CSRF protection work in Spring Boot, and how can we disable it?  
65. What is the difference between `@PreAuthorize`, `@Secured`, and `@RolesAllowed`?  
66. How can we implement custom authentication in Spring Security?  
67. What are security best practices for securing REST APIs in Spring Boot?  
68. How does password hashing work in Spring Boot security?  
69. How does method-level security work in Spring Boot?  
70. What happens if authentication fails in Spring Security, and how can we handle it?  

---

## **8️⃣ Spring Boot Async & Event Handling**  
71. What happens if an `@Async` method is called from the same class?  
72. How does Spring Boot handle event listeners with `@EventListener`?  
73. What happens if an event is published but no listener exists?  
74. How can we ensure that `@Async` tasks execute with a specific thread pool?  
75. How does `CompletableFuture` work with `@Async` methods?  
76. What happens if an exception occurs inside an `@Async` method?  
77. Can we have multiple `@EventListener` methods for the same event?  
78. What is the difference between `ApplicationEventPublisher` and `@EventListener`?  
79. How do we ensure event processing order in Spring Boot?  
80. How does Spring Boot handle synchronous vs. asynchronous event listeners?  

---

## **9️⃣ Spring Boot Microservices & Distributed Systems**  
81. How does Spring Boot handle service discovery with Eureka?  
82. What is the role of Spring Cloud Config in microservices?  
83. How can we implement circuit breaking in Spring Boot using Resilience4j?  
84. What happens if a microservice fails while another service depends on it?  
85. How do we handle distributed transactions in Spring Boot microservices?  
86. What are the benefits of using API Gateway in microservices?  
87. How can we implement rate-limiting in a Spring Boot microservice?  
88. What are different ways to secure microservices in Spring Boot?  
89. How does Spring Boot support gRPC communication?  
90. What is the role of OpenFeign in Spring Boot microservices? 