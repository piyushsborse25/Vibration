**159. What is JDBC?**  
JDBC (Java Database Connectivity) is an API that allows Java applications to interact with databases. It provides a standard way to execute SQL queries, retrieve data, and perform CRUD operations.  
Example:

```java
Connection con = DriverManager.getConnection(url, user, pass);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM users");
```

---

**160. What is a JDBC Driver?**  
A JDBC driver is a software component that enables Java applications to connect and interact with a specific database.  
**Types of JDBC Drivers:**

1. **Type 1:** JDBC-ODBC Bridge Driver
    
2. **Type 2:** Native-API Driver
    
3. **Type 3:** Network Protocol Driver
    
4. **Type 4:** Thin Driver (pure Java, most commonly used)
    

Example: MySQL Driver → `com.mysql.cj.jdbc.Driver`

---

**161. What are the steps to connect to the database in Java?**  
**Steps:**

1. **Load the Driver:**
    
    ```java
    Class.forName("com.mysql.cj.jdbc.Driver");
    ```
    
2. **Establish Connection:**
    
    ```java
    Connection con = DriverManager.getConnection(url, user, pass);
    ```
    
3. **Create Statement:**
    
    ```java
    Statement stmt = con.createStatement();
    ```
    
4. **Execute Query:**
    
    ```java
    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
    ```
    
5. **Process Results and Close:**
    
    ```java
    con.close();
    ```
    

---

**162. What are the JDBC API components?**  
Main components:

1. **DriverManager** – Manages JDBC drivers and connections.
    
2. **Connection** – Represents a session with the database.
    
3. **Statement** – Executes SQL queries.
    
4. **PreparedStatement** – Precompiled SQL statements (faster and secure).
    
5. **ResultSet** – Stores data retrieved from queries.
    
6. **SQLException** – Handles database-related exceptions.
    

---

**163. What is the JDBC Connection interface?**  
The `Connection` interface represents a **session between a Java app and a database**.  
It provides methods to:

- Create statements
    
- Commit/rollback transactions
    
- Manage auto-commit behavior  
    Example:
    

```java
Connection con = DriverManager.getConnection(url, user, pass);
con.setAutoCommit(false);
con.commit();
```

---

**164. What does the JDBC ResultSet interface do?**  
`ResultSet` represents a **table of data** returned by a SQL query.  
It allows navigating rows and reading column values.  
Common methods:

- `next()` → Move to next row
    
- `getString("colName")`, `getInt(index)` → Retrieve data  
    Example:
    

```java
ResultSet rs = stmt.executeQuery("SELECT name FROM users");
while (rs.next()) {
    System.out.println(rs.getString("name"));
}
```