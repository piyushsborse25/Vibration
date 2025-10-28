### 15. What is OAuth and why is it used?

**Explanation:**  
**OAuth (Open Authorization)** is an open standard for access delegation — it allows users to grant limited access to their resources on one site to another site **without sharing credentials**.  
It’s mainly used for **secure token-based authentication** and **authorization**.

**Real-world Example:**  
When you log into a website using “Login with Google,” the website uses OAuth 2.0 to request access to your Google account — without ever seeing your password.

**Why it’s used:**

- Prevents credential sharing
    
- Enables Single Sign-On (SSO)
    
- Provides secure delegated access
    
- Token-based, stateless mechanism
    

**Spring Boot Example (OAuth2 Resource Server):**

```java
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.oauth2Login(); // Enables OAuth2 login
        return http.build();
    }
}
```

---

### 16. How was the authenticator integrated in your project?

**Explanation:**  
The **authenticator** (e.g., Keycloak, Okta, Azure AD) acts as a centralized identity provider.  
It issues JWT tokens upon successful login and validates them for every subsequent request via the API Gateway or Resource Server.

**Real-world Example:**  
In a banking app:

1. User logs in via Keycloak.
    
2. Keycloak issues a JWT.
    
3. Every service (like Account or Transaction) validates the JWT before processing.
    

**Spring Boot Integration Example:**

```java
@Bean
SecurityFilterChain security(HttpSecurity http) throws Exception {
    return http
        .oauth2ResourceServer()
        .jwt()
        .and().build();
}
```

Here, the authenticator (like Keycloak) is configured as an external identity provider.

---

### 17. Authentication — scenario-based question.

**Scenario:**  
You have three microservices — `UserService`, `OrderService`, and `PaymentService`.  
How do you ensure that only authenticated users can access these services?

**Approach:**

1. User logs in via Authentication Service (OAuth2 / JWT).
    
2. A JWT is generated and sent to the client.
    
3. The client includes the token in the `Authorization` header for all future requests.
    
4. Each microservice validates the token before allowing access.
    

**Example Token Validation:**

```java
http
  .authorizeRequests()
  .antMatchers("/public/**").permitAll()
  .anyRequest().authenticated()
  .and()
  .oauth2ResourceServer().jwt();
```

**Real-world Parallel:**  
Like a movie ticket — once issued, you can enter any hall showing the same movie (authorized areas only).

---

### 18. Scenario-based questions on token expiry.

**Scenario:**  
If a JWT token expires while the user is still active, how will the system handle it?

**Answer:**  
When a token expires:

1. The API Gateway or microservice returns a **401 Unauthorized** response.
    
2. The client automatically calls the **token refresh endpoint** using a **refresh token**.
    
3. A new JWT is issued without requiring the user to log in again.
    

**Real-world Example:**  
In Gmail, if your session expires after a long time, it silently refreshes the token in the background.

**Code Example (Token Validation Check):**

```java
if (jwtService.isTokenExpired(token)) {
    throw new AuthenticationException("Token expired, please refresh");
}
```

---

### 19. Security mechanism for JWT token.

**Explanation:**  
JWT (JSON Web Token) is a compact, stateless token containing user identity and roles.  
It has three parts:  
**Header**, **Payload**, and **Signature**.  
Microservices validate the signature using a shared secret or public key to ensure integrity.

**Flow:**

1. User logs in → server generates JWT.
    
2. Token stored client-side (in header).
    
3. Every request includes the token for authorization.
    
4. Server validates signature before access.
    

**Example Token:**  
`eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

**Spring Boot Example:**

```java
public Claims extractAllClaims(String token) {
    return Jwts.parser()
        .setSigningKey(secretKey)
        .parseClaimsJws(token)
        .getBody();
}
```

**Real-world Example:**  
Like a sealed boarding pass — once validated, it allows access to all authorized gates.

---

### 20. How do you ensure security?

**Approach:**

- **JWT/OAuth2 Authentication** — verify user identity.
    
- **Role-Based Access Control (RBAC)** — restrict access to specific roles.
    
- **HTTPS/TLS** — encrypt data in transit.
    
- **Input Validation** — prevent injection attacks.
    
- **Centralized Logging & Monitoring** — track suspicious activities.
    
- **Security Headers** — enforce policies using Spring Security.
    

**Spring Boot Example (RBAC):**

```java
http
  .authorizeRequests()
  .antMatchers("/admin/**").hasRole("ADMIN")
  .antMatchers("/user/**").hasAnyRole("USER", "ADMIN")
  .anyRequest().authenticated();
```

**Real-world Example:**  
Like a corporate building — guards (auth), ID cards (tokens), and access floors (roles).

---

### 21. How do you implement rate limiting?

**Explanation:**  
Rate limiting restricts the number of API requests a client can make within a specific time window to prevent overuse or DDoS attacks.

**Implementation Approaches:**

1. **At API Gateway:** Use built-in filters in Spring Cloud Gateway or tools like Kong.
    
2. **Using Bucket4j or Redis:** Track request counts and expiry per user/IP.
    

**Spring Boot Example (Redis + Bucket4j):**

```java
@Configuration
public class RateLimiterConfig {
    @Bean
    public KeyResolver userKeyResolver() {
        return exchange -> Mono.just(
            exchange.getRequest().getHeaders().getFirst("Authorization"));
    }
}
```

**Real-world Example:**  
Twitter allows limited API calls per 15 minutes — this protects backend systems from abuse.

---

### 22. What is idempotency and why is it important in Microservices?

**Explanation:**  
An **idempotent operation** always produces the same result, no matter how many times it’s executed.  
It ensures reliability and avoids duplicate data creation — especially in distributed systems where retries can occur.

**Real-world Example:**  
Clicking “Pay” twice should not deduct money twice.  
The system identifies repeated requests by a unique **idempotency key** (like transaction ID).

**Importance:**

- Prevents data duplication
    
- Makes retries safe in network failures
    
- Ensures consistency in distributed transactions
    

**Spring Boot Example:**

```java
@PostMapping("/payment")
public ResponseEntity<String> processPayment(
        @RequestHeader("Idempotency-Key") String key) {
    if (paymentService.alreadyProcessed(key)) {
        return ResponseEntity.ok("Payment already processed");
    }
    return ResponseEntity.ok(paymentService.process(key));
}
```

**Analogy:**  
Like pressing the elevator button multiple times — it only registers once.