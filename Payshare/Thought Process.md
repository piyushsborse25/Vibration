## ✅ How to Answer the Main Question: _"What was your thought process while building this application?"_

You break it into **phases**:

1. **Requirement Understanding**
    
    - The problem is not just about storing expenses; it’s about _fairly computing settlements_ while minimizing transactions.
        
    - Key: Keep track of **who paid, who owes, and simplify debts**.
        
2. **Modeling the Domain**
    
    - Entities: `User`, `Group`, `Event`, `Expense`, `ExpenseSplit`.
        
    - Why Event is the root: Because it encapsulates real-world trips/events where groups can overlap.
        
    - Why Group is standalone: Because you can reuse groups across events (like “Office Team” used for “Goa Trip” and “Team Dinner”).
        
3. **Database & Normalization**
    
    - Third Normal Form (3NF): Avoid duplication (e.g., Users exist independently, not duplicated inside every event).
        
    - Expense Splits table ensures **flexible splitting (not always equal)**.
        
4. **API Design**
    
    - RESTful, resource-based (`/user`, `/event`, `/group`, `/expense`, `/settle`).
        
    - Separation of concerns: Create event → Add participants → Add expenses → Compute settlement.
        
5. **Business Logic Layer**
    
    - Key focus on **settlement simplification** → Graph-based debt minimization.
        
    - Consistency checks (e.g., cannot delete a user if unsettled).
        
6. **Error Handling & Validations**
    
    - Example: Prevent adding expense for non-participant.
        
    - Example: Prevent group deletion if linked to active events.
        
7. **Scalability Considerations** (Enterprise level)
    
    - If 1M+ users across 10k+ groups → monolith won’t scale.
        
    - Microservices:
        
        - `User Service`, `Group Service`, `Event Service`, `Expense Service`, `Settlement Service`.
            
    - Event-driven communication (Kafka → async settlement updates).
        
    - Caching balances (Redis) for quick settlement queries.
        
8. **Future Enhancements**
    
    - Integrate payment gateway (auto settlement).
        
    - Multi-currency & real-time FX conversion.
        
    - Machine Learning for expense categorization.
        
    - Offline mode (sync later).
        
    - Audit Logs for compliance.
        

---

## 🔄 Cross-Questions Interviewers Might Ask You

Here’s a curated list to prepare for an **hour-long interview**:

---

### 🟢 API & Entity Design

1. Why did you make `Event` the root entity instead of `Group`?
    
2. What happens if one group is used for multiple events — how do you track expenses separately?
    
3. Why do we need `ExpenseSplit` table instead of just storing `amount` in Expense?
    
4. Can expenses be shared unevenly? How does your model handle that?
    
5. Suppose an expense is added for a user not in the event, what should happen?
    

---

### 🟢 Data Consistency & Edge Cases

6. What if two users try to add expenses at the same time for the same event? How will you prevent race conditions?
    
7. Suppose an event is ongoing and one participant leaves the group. Should expenses already paid remain valid?
    
8. What if a participant was removed, but had unsettled balances? Do you:
    
    - Block removal until settled?
        
    - Or mark debts as _frozen_?
        
    - Or transfer debt to group admin?
        

👉 **This matches your example question perfectly.**  
You’d answer: _In my design, a participant cannot be removed if they have unsettled balances. They must first clear settlements, otherwise the system rejects deletion._

---

### 🟢 Performance & Scalability

9. Imagine 1M expenses in an event. How do you calculate settlement efficiently?
    
10. Why not run settlement computation in real-time after each expense instead of at query time?
    
11. How will you scale this application for 10M+ users?
    

---

### 🟢 Microservices & System Design

12. How would you break this monolith into microservices?
    
13. How will services communicate (Sync → REST, Async → Kafka)?
    
14. How do you ensure data consistency across services (2PC vs Saga pattern)?
    
15. If the Settlement service is down, can expenses still be added?
    
16. How will you handle caching vs database truth?
    

---

### 🟢 Reliability & Enterprise Readiness

17. How will you prevent double transactions if a user retries the same request due to network error?
    
18. What about **idempotency** in APIs (`POST /expense`)?
    
19. How do you secure sensitive data like email, phone numbers?
    
20. How would you implement authentication and authorization (JWT, OAuth)?
    

---

### 🟢 Future & Business-Oriented

21. Can this system integrate with UPI/PayPal for real money transfers?
    
22. How do you handle multiple currencies in international trips?
    
23. What if different groups want to merge into one event?
    
24. How would you monetize this system as a product?
    
25. How would you handle GDPR compliance (delete user data on request)?
    

---

## 🔥 Your Own Edge Case (Deleting Group Member With Expenses)

> _"What if I created an event with existing group, added expenses, and later deleted a group member who has unsettled balances?"_

This is gold because it shows **practical thinking**. Answer like this:

- **Rule 1**: A user cannot be deleted from a group/event until all balances are settled.
    
- **Rule 2**: If forced deletion (admin override), system marks the user as “inactive” but keeps their balances frozen → settlements must still happen.
    
- **Rule 3**: For enterprise, we’d use **soft delete** (keep data for audit) instead of hard delete.
    

That way you show **data integrity > user convenience**. 