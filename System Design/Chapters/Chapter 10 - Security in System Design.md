Security is one of the most critical aspects of system design. Even the most scalable, highly available system is worthless if it is not secure. Modern applications, especially in **Java + Spring Boot microservices**, face threats from API misuse, unauthorized access, data leaks, and mismanagement of secrets. As a developer preparing for interviews, you should not only know security definitions but also **how they are practically implemented and why certain design decisions matter**.

This chapter covers authentication, authorization, encryption, and secret management in-depth, along with pitfalls that often come up in real-world systems and interviews.

---

## **1. API Authentication: OAuth2, JWT**

Authentication answers **“Who are you?”**. It validates the identity of a user or service before granting access.

### **OAuth2**

- OAuth2 is the industry-standard protocol for authorization, but it is also widely used for authentication through **OpenID Connect (OIDC)**.
    
- It involves four roles:
    
    1. **Resource Owner** – The user who owns the data.
        
    2. **Client Application** – The app requesting access on behalf of the user.
        
    3. **Authorization Server** – Issues tokens after verifying credentials.
        
    4. **Resource Server** – The API/service that validates tokens before serving data.
        

**Flow Example (Authorization Code Grant):**

1. User tries to log in to a shopping app.
    
2. App redirects to Google’s OAuth server (Authorization Server).
    
3. User logs in with Google → Google issues an **authorization code**.
    
4. App exchanges the code for an **access token (and refresh token)**.
    
5. App uses the token to call backend APIs (Resource Server).
    

**Key Points for Interviews:**

- OAuth2 tokens are **short-lived** (access token) + **long-lived** (refresh token).
    
- Tokens can be **revoked** by the Authorization Server.
    
- Common in **microservices + API Gateway authentication**.
    

---

### **JWT (JSON Web Token)**

- A **compact, stateless token** format used in distributed systems.
    
- Structure: `Header.Payload.Signature`
    
    - Header → Algorithm & type
        
    - Payload → Claims (user ID, roles, expiry)
        
    - Signature → Ensures token integrity (signed with secret or private key).
        

**Why JWT is popular in microservices:**

- **Stateless** – no need for a central session store.
    
- **Lightweight** – JSON format, easy to parse.
    
- **Self-contained** – carries user info and permissions.
    

**Pitfalls of JWT:**

- Cannot be revoked easily (unlike OAuth2 refresh tokens).
    
- If **secret key leaks**, all tokens are compromised.
    
- Always set **short expiry** + rotate secrets.
    

---

## **2. Authorization: RBAC Basics**

Authorization answers **“What can you do?”**.

### **RBAC (Role-Based Access Control)**

- Users are assigned roles, and roles have permissions.
    
- Example:
    
    - **Admin** → create/read/update/delete all resources.
        
    - **Editor** → create/update but not delete.
        
    - **Viewer** → read-only.
        

**Implementation in Spring Security:**

- Use `@PreAuthorize("hasRole('ADMIN')")` or method-level security.
    
- Map user roles in the JWT or OAuth2 token.
    

**Limitations:**

- RBAC can become too coarse-grained in large systems.
    
- For complex needs, **ABAC (Attribute-Based Access Control)** is used (policies based on attributes like time, IP, department, etc.).
    

---

## **3. Data Encryption (At Rest, In Transit)**

Data security is not just about controlling access; it’s also about protecting data from being leaked if stolen.

### **Encryption In Transit**

- Protects data moving between services/users.
    
- Achieved using **TLS (HTTPS)**.
    
- Ensures **Confidentiality** (no eavesdropping), **Integrity** (no tampering), and **Authentication** (trusted server).
    

### **Encryption At Rest**

- Protects stored data from being read if disks are stolen or backups are compromised.
    
- Example:
    
    - Encrypting databases with AES-256.
        
    - Using cloud-managed encryption (AWS KMS, GCP KMS, Azure Key Vault).
        

**Pitfalls:**

- Encrypting everything without considering performance.
    
- Forgetting to rotate keys regularly.
    

---

## **4. Secret Management (Spring Cloud Config, Vault)**

Secrets like **API keys, database passwords, certificates, JWT signing keys** must not be hardcoded or left in configuration files.

### **Bad Practices (What interviewers test you on):**

- Hardcoding secrets in `application.properties`
    
- Committing `.env` files to GitHub
    
- Using the same secret across environments (dev, staging, prod)
    

### **Best Practices:**

1. Use **Spring Cloud Config** with encrypted properties (`{cipher}` prefix).
    
2. Use **HashiCorp Vault** for centralized secret management.
    
    - Stores secrets securely.
        
    - Provides automatic **rotation** of credentials.
        
    - Integrates with **Spring Boot via Spring Cloud Vault**.
        
3. Cloud-native alternatives: AWS Secrets Manager, Azure Key Vault, GCP Secret Manager.
    

---

## **👉 Pitfall: Keeping Secrets in Code/Config**

- Example:
    
    ```java
    spring.datasource.username=admin
    spring.datasource.password=admin123
    ```
    
    If committed to GitHub, attackers can use tools like **truffleHog** to scan for secrets.
    
- Instead, load secrets dynamically from Vault or Kubernetes secrets.
    

---

## **Interview Angle**

**Q1. How does JWT differ from OAuth2?**

- JWT is just a token format.
    
- OAuth2 is a protocol that defines how to issue/validate tokens (often using JWTs).
    

**Q2. How would you secure microservices in Spring Boot?**

- API Gateway with OAuth2/JWT authentication.
    
- RBAC/ABAC for authorization.
    
- TLS everywhere.
    
- Secrets managed via Vault.
    
- Sensitive logging masked.
    

**Q3. What are common security pitfalls in real-world systems?**

- Logging passwords/PII.
    
- Using long-lived JWTs without refresh mechanism.
    
- Not rotating secrets.
    
- Exposing internal APIs without authentication.
    