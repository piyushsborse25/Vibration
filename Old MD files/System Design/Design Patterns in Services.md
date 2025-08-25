### **Url Shortener Service**

| **Pattern**            | **Purpose**                                               |
|------------------------|-----------------------------------------------------------|
| **Singleton**           | Shared cache, URL generator                               |
| **Factory**             | Different encoding formats                                |
| **Strategy**            | Swappable shortening algorithm                            |
| **Proxy**               | Redis caching layer                                       |
| **Builder**             | Build response objects                                    |
| **Decorator**           | Analytics or logging wrapper                              |
| **Command**             | Analytics queuing                                         |
| **Observer**            | URL lifecycle events                                      |
| **DAO**                 | DB layer abstraction                                      |
| **Circuit Breaker**     | Fault-tolerant system                                     |

---

### **Netflix**

| **Pattern**                | **Usage**                                                                 |
|----------------------------|---------------------------------------------------------------------------|
| **Facade**                 | Login, registration simplification                                        |
| **Template Method**        | Common login flow with pluggable providers                                |
| **Singleton**              | JWT, auth service, DB clients                                             |
| **Strategy**               | Streaming bitrate control                                                 |
| **State**                  | Player/download status tracking                                           |
| **Decorator**              | Add subtitles, DRM, watermarks                                            |
| **Proxy**                  | CDN/local video fallback                                                  |
| **Observer**               | React to playback, watch, and analytics events                            |
| **Adapter**                | Multi-CDN integration                                                     |
| **Builder**                | Construct metadata/profile object                                         |
| **DAO**                    | Mongo/Postgres access for metadata/profile                                |
| **Command**                | Download operations                                                       |
| **Chain of Responsibility**| Multi-step recommendation filters                                         |
| **Factory**                | Build appropriate recommendation strategies                               |
| **Circuit Breaker**        | Service resiliency (e.g., Resilience4j in Spring Boot)                    |

---

### **Amazon**

| **Pattern**                | **Use Case**                                                              |
|----------------------------|---------------------------------------------------------------------------|
| **Strategy**               | Search, filters, payment modes                                            |
| **Factory**                | Payment processor selection                                               |
| **Builder**                | Product cards, responses, wishlist export                                 |
| **Singleton**              | Shared services like Cart, CacheManager                                   |
| **State**                  | Cart, order lifecycle                                                     |
| **Command**                | Cart actions, payment, retry                                              |
| **Observer**               | Inventory updates, recommendations, UI binding                            |
| **Proxy**                  | Redis cache for inventory/products                                        |
| **Template Method**        | Vendor/order flow customization                                           |
| **Chain of Responsibility**| Multi-step order processing                                               |
| **Decorator**              | Product views, badges, offers                                             |
| **Facade**                 | Unified order placement API                                               |
| **Circuit Breaker**        | Protect from external service failures (payment, shipping)                |
| **DAO / Repository**       | DB access for product, user, order                                        |

---

### **Whatsapp**

| **Pattern**                | **Use Case**                                                              |
|----------------------------|---------------------------------------------------------------------------|
| **Command**                | Send, delete, edit, retry message actions                                |
| **Observer**               | Message receive, user presence, typing indicators                        |
| **Strategy**               | Delivery methods (WebSocket, push, polling)                              |
| **Composite**              | Group chat = collection of users                                         |
| **Mediator**               | Chat room manages internal communication                                 |
| **Proxy**                  | Redis cache for recent chats/messages                                    |
| **Adapter**                | Storage abstraction for media uploads                                    |
| **Builder**                | Message construction                                                     |
| **Decorator**              | Enhance messages with media/metadata                                     |
| **State**                  | User presence and typing status                                          |
| **Singleton**              | Auth service, token handler, cache manager                               |
| **Facade**                 | Unified entry point for login + auth                                     |
| **DAO / Repository**       | Mongo/Cassandra access for messages                                      |
| **Circuit Breaker**        | Failure handling for push/notification/media services                    |

---

### **Swiggy**

| **Pattern**                | **Use Case**                                                              |
|----------------------------|---------------------------------------------------------------------------|
| **Strategy**               | Search filters, delivery partner assignment                               |
| **Factory**                | Payment handler, delivery partner object                                  |
| **Builder**                | Restaurant cards, reviews                                                 |
| **Command**                | Order actions, payment flows                                              |
| **State**                  | Cart state, order status                                                  |
| **Facade**                 | Abstract complex order flow                                               |
| **Chain of Responsibility**| Multi-step order processing                                               |
| **Observer**               | Real-time order updates                                                   |
| **Decorator**              | Promotions/offers over menu items                                         |
| **Adapter**                | Location/GPS API wrapping                                                 |
| **Proxy**                  | Cache recent orders, location                                             |
| **Template Method**        | Common cooking templates per cuisine                                      |
| **Circuit Breaker**        | Prevent system-wide failure on payment errors                             |
| **Singleton**              | Shared services like CartService, CacheManager                            |
| **DAO / Repository**       | Data access abstraction                                                   |

---

### **Uber**

| **Pattern**                | **Use Case**                                                              |
|----------------------------|---------------------------------------------------------------------------|
| **Strategy**               | Driver matching, pricing, surge                                          |
| **Factory**                | Ride type, payment handler creation                                        |
| **Command**                | Ride request/cancel, charge/refund actions                                 |
| **State**                  | Trip lifecycle                                                           |
| **Observer**               | Real-time updates: ride status, locations, notifications                 |
| **Template Method**        | Trip flow logic shared across ride types                                   |
| **Decorator**              | Add fare components (tax, discount, surge)                                |
| **Adapter**                | GPS API integration                                                      |
| **Proxy**                  | Cached location/driver data                                              |
| **Builder**                | Feedback, trip receipts                                                  |
| **Singleton**              | Shared services like TripManager                                         |
| **Circuit Breaker**        | Payment and third-party failures                                         |
| **DAO / Repository**       | DB access layers                                                         |