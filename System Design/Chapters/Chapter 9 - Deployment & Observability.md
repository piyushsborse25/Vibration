Modern software systems are not just about writing code and exposing APIs. They live in dynamic environments where uptime, resilience, monitoring, and safe rollouts are just as important as clean code. For system design interviews—especially at MNCs and product-based companies—you are expected to not only know how to build a system but also how to deploy, monitor, and troubleshoot it at scale. This chapter focuses on **deployment strategies** and **observability pillars**.

---

## **9.1 Deployment Strategies**

When deploying a new version of a service, downtime and failures must be minimized. Different strategies exist depending on risk tolerance, traffic, and infrastructure maturity.

### **Blue-Green Deployment**

- Two identical environments: **Blue (current)** and **Green (new)**.
    
- New version is deployed to **Green**, while traffic still goes to **Blue**.
    
- Once tested, traffic is switched from Blue → Green instantly.
    
- If issues occur, rollback is immediate (switch back to Blue).
    
- **Pros**: Fast rollback, zero downtime.
    
- **Cons**: Requires double infrastructure temporarily (costly).
    
- **Use case**: High-criticality systems (e.g., payment gateways).
    

---

### **Rolling Deployment**

- Deploy new version gradually, pod by pod (or instance by instance).
    
- Old version is phased out progressively.
    
- Traffic is distributed among mixed versions during rollout.
    
- **Pros**: No need for double infra, gradual rollout reduces impact.
    
- **Cons**: Harder rollback (must roll forward or re-deploy old version).
    
- **Use case**: Large-scale microservices where gradual rollout is acceptable.
    

---

### **Canary Deployment**

- Release a new version to a **small subset of users** (canary group).
    
- Monitor metrics (latency, error rate, business KPIs).
    
- If healthy, expand rollout gradually.
    
- If unhealthy, rollback before full exposure.
    
- **Pros**: Safest rollout strategy, early detection of issues.
    
- **Cons**: Requires advanced monitoring and traffic routing.
    
- **Use case**: Feature rollouts in consumer apps (e.g., Netflix testing UI changes).
    

---

👉 **Interview Tip**: Be ready to explain which strategy you’d pick when asked:

- "Mission-critical payments system?" → Blue-Green.
    
- "Consumer app UI change?" → Canary.
    
- "Internal admin tool?" → Rolling.
    

---

## **9.2 Kubernetes Basics**

Kubernetes (K8s) is the industry standard for deployment orchestration.

### **Pods**

- Smallest deployable unit in K8s.
    
- A pod can run **one or more containers** that share network/storage.
    
- Ephemeral by design (may die anytime; workload must be resilient).
    

### **Services**

- Provide stable networking to pods (since pod IPs are dynamic).
    
- Types:
    
    - **ClusterIP**: Internal communication within the cluster.
        
    - **NodePort**: Exposes service on each node’s IP and port.
        
    - **LoadBalancer**: Integrates with cloud load balancers for external traffic.
        

### **Ingress**

- API gateway-like entry point to multiple services.
    
- Handles routing, SSL termination, virtual hosts.
    
- Example:
    
    - `/api/*` → Backend service
        
    - `/ui/*` → Frontend service
        

👉 **Pitfall**: Forgetting readiness probes in Kubernetes means a pod may receive traffic before it’s ready, causing failures.

---

## **9.3 Health Checks**

Applications must report their health to orchestration tools.

- **Liveness Probe**:
    
    - Detects if app is **alive**.
        
    - If failing, K8s restarts the pod.
        
    - Example: Spring Boot actuator `/actuator/health/liveness`.
        
- **Readiness Probe**:
    
    - Detects if app is **ready to serve traffic**.
        
    - If failing, pod stays alive but traffic is not routed to it.
        
    - Example: App waiting for DB connection pool to initialize.
        

👉 **Interview Scenario**: If you don’t configure readiness probes, during deployment, K8s may send traffic to pods before DB initialization → failed requests.

---

## **9.4 Monitoring**

### **Prometheus**

- Time-series database designed for metrics collection.
    
- Pull-based: scrapes metrics endpoints (`/metrics`).
    
- Supports **alerting** via Alertmanager.
    

### **Grafana**

- Visualization layer over Prometheus.
    
- Can build dashboards for:
    
    - Latency (p95, p99)
        
    - Error rates
        
    - Throughput (RPS)
        
    - Resource usage (CPU/memory)
        

👉 **Example**:  
If error rate spikes after a deployment, Grafana dashboards will reveal it in real time. Alerts can auto-trigger rollback.

---

## **9.5 Centralized Logging**

Logs are the first line of defense in debugging distributed systems.

### **ELK Stack (Elasticsearch + Logstash + Kibana)**

- **Elasticsearch**: Stores logs, indexed for fast searching.
    
- **Logstash/Fluentd**: Collects and ships logs from services.
    
- **Kibana**: Visualization and search UI.
    

### **EFK (Elasticsearch + Fluentd + Kibana)**

- Fluentd replaces Logstash (lighter, better for K8s).
    

👉 **Best Practices**:

- Use **JSON structured logs** instead of plain text.
    
- Include **trace IDs** for correlation across services.
    
- Avoid logging sensitive data (PII, passwords, tokens).
    
    - **Interview Pitfall**: "What if you log credit card numbers in plaintext?" → GDPR/PCI violation.
        

---

## **9.6 Distributed Tracing**

In microservices, a single user request may traverse 10+ services. Debugging without tracing is impossible.

### **Zipkin & Jaeger**

- OpenTracing-compatible tools for distributed tracing.
    
- Inject trace IDs into requests.
    
- Each service logs spans (timing of operations).
    
- Final trace visualizes **end-to-end request flow**.
    

👉 **Example**:

- A request takes 3 seconds. Tracing shows:
    
    - API Gateway → 10ms
        
    - Auth Service → 30ms
        
    - Payment Service → 2.5s (DB bottleneck detected)
        

👉 **Interview Tip**: Be able to explain how **Spring Cloud Sleuth + Zipkin** works in a Java microservices stack.

---

## **9.7 Pitfalls**

- Deployments without monitoring = blind rollouts.
    
- Using only liveness probes = false positives; app may crash after startup but K8s won’t know.
    
- Logging **too much** = huge storage bills, performance degradation.
    
- Logging **sensitive data** = compliance violations, legal risks.
    
- No distributed tracing = impossible to debug high-latency issues in microservices.
    

---

✅ **Key Takeaway for Interviews**  
When asked about deployment & observability:

- Mention **deployment strategy** (choose based on risk vs speed).
    
- Mention **Kubernetes readiness & liveness probes**.
    
- Mention **metrics, logs, traces** (the 3 pillars of observability).
    
- End with a **pitfall story** (e.g., logged passwords → GDPR violation).
    