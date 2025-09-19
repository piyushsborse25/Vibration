### **Difference Between `OnPush` and `Default` Change Detection in Angular**

**Change Detection** in Angular determines how and when the UI updates when data changes. Angular provides two change detection strategies:  

1. **`Default` (default strategy)**
2. **`OnPush` (optimized strategy for performance)**  

---

### **1️⃣ Default Change Detection (Default Strategy)**
- Every time **any event** occurs (e.g., user input, timer, HTTP response, service data update), Angular runs **change detection on all components** in the tree.
- This means **even if a component’s data hasn’t changed, Angular still checks it**, leading to **unnecessary checks and potential performance issues**.

🔹 **Example of Default Change Detection**
```typescript
@Component({
  selector: 'app-default-change',
  template: `<p>{{ counter }}</p> <button (click)="increment()">Increment</button>`,
  changeDetection: ChangeDetectionStrategy.Default // Default behavior
})
export class DefaultChangeComponent {
  counter = 0;

  increment() {
    this.counter++;
  }
}
```
**How it works?**  
- Every time a button is clicked, **Angular checks the entire component tree**.
- Even **unrelated components** are checked, which can be inefficient.

---

### **2️⃣ `OnPush` Change Detection (Optimized for Performance)**
- When using **`ChangeDetectionStrategy.OnPush`**, Angular **only checks the component if**:
  1. An `@Input()` property has a **new reference** (object or array).
  2. An event inside the component occurs (e.g., button click).
  3. `ChangeDetectorRef.markForCheck()` is explicitly called.

🔹 **Example of `OnPush` Change Detection**
```typescript
@Component({
  selector: 'app-onpush-change',
  template: `<p>{{ data.value }}</p> <button (click)="updateData()">Update</button>`,
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class OnPushChangeComponent {
  @Input() data!: { value: number };

  updateData() {
    this.data.value++;  // Won't trigger change detection!
  }
}
```

🔹 **How it works?**
- If the parent component **modifies the `data` object but doesn’t replace it**, Angular **won’t detect changes**.
- To trigger change detection, **a new object reference must be assigned**:
```typescript
this.data = { value: this.data.value + 1 }; // This works!
```

---

### **3️⃣ Key Differences**
| Feature                  | Default (`ChangeDetectionStrategy.Default`) | `OnPush` (`ChangeDetectionStrategy.OnPush`) |
|--------------------------|--------------------------------|--------------------------------|
| **Change detection triggers** | Runs on every event (even if unrelated to component) | Only runs when `@Input()` changes (new reference) or triggered manually |
| **Performance impact**   | More checks = Slower for large apps | Fewer checks = Faster performance |
| **Best use case**        | Small apps, frequent updates | Large apps, performance-critical components |
| **Triggers manual change detection?** | Not required | Often requires `markForCheck()` or `detectChanges()` |

---

### **4️⃣ When to Use `OnPush`?**
✅ Use **`OnPush`** when:
- Your component relies mainly on `@Input()` properties.
- You are working with **large lists or complex UIs** (e.g., `*ngFor` with thousands of items).
- You want to **reduce unnecessary re-renders**.

🚫 Avoid **`OnPush`** when:
- Your component updates based on global events (e.g., WebSockets, service subscriptions).
- You frequently mutate objects instead of replacing them.

---

### **5️⃣ Forcing Change Detection Manually**
If you're using `OnPush` but need to manually trigger an update, use **ChangeDetectorRef**:

```typescript
import { ChangeDetectorRef } from '@angular/core';

constructor(private cdr: ChangeDetectorRef) {}

updateManually() {
  this.cdr.markForCheck(); // Marks component for re-checking in the next cycle
}
```

---

### **Conclusion**
- **Use `Default`** if you don’t need optimization and want Angular to handle everything automatically.
- **Use `OnPush`** to improve performance when dealing with `@Input()` properties and large applications.