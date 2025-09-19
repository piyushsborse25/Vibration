In Angular, **data binding** is a mechanism that allows you to connect the application data (model) with the UI (view). It ensures that when the data changes, the UI updates automatically, and vice versa, depending on the direction of the binding.

Angular supports **four types of data binding**:

### 1. **Interpolation (One-Way Data Binding from Component to View)**
   - Interpolation is used to bind data from the component's class to the view. The data is inserted into the HTML template.
   - It is typically used for inserting dynamic data into element content, such as text or attributes.
   - Syntax: `{{ expression }}`
   
   #### Example:
   ```html
   <h1>{{ title }}</h1> <!-- Interpolation binding -->
   ```

   In the component:
   ```typescript
   export class AppComponent {
     title = 'Hello, Angular!';
   }
   ```

   **Explanation**: The `title` property in the component is bound to the `<h1>` element in the template. When the `title` value changes in the component, it will automatically reflect in the view.

### 2. **Property Binding (One-Way Data Binding from Component to View)**
   - Property binding allows you to bind the property of an element in the DOM to an expression in the component.
   - It is used when you want to bind data to an element's attributes, properties, or DOM elements.
   - Syntax: `[property]="expression"`
   
   #### Example:
   ```html
   <img [src]="imageUrl" alt="Image"> <!-- Property Binding -->
   ```

   In the component:
   ```typescript
   export class AppComponent {
     imageUrl = 'https://example.com/image.jpg';
   }
   ```

   **Explanation**: The `src` property of the `<img>` tag is bound to the `imageUrl` property of the component. If the `imageUrl` changes, the image displayed on the page will automatically update.

### 3. **Event Binding (One-Way Data Binding from View to Component)**
   - Event binding allows you to bind events like click, change, mouse events, etc., from the view to a method in the component.
   - It enables the view to send data to the component when an event occurs.
   - Syntax: `(event)="method($event)"`

   #### Example:
   ```html
   <button (click)="onClick()">Click me</button> <!-- Event Binding -->
   ```

   In the component:
   ```typescript
   export class AppComponent {
     onClick() {
       alert('Button clicked!');
     }
   }
   ```

   **Explanation**: The `onClick()` method in the component is triggered when the button is clicked. Event binding sends the event data to the component, allowing the method to execute.

### 4. **Two-Way Data Binding**
   - Two-way data binding allows synchronization of data between the component and the view. It enables changes in the component to be reflected in the view and vice versa.
   - Angular provides the `[(ngModel)]` directive to implement two-way binding.
   - Syntax: `[(ngModel)]="property"`

   #### Example:
   ```html
   <input [(ngModel)]="username"> <!-- Two-Way Binding -->
   <p>{{ username }}</p> <!-- Displaying the value -->
   ```

   In the component:
   ```typescript
   export class AppComponent {
     username: string = '';
   }
   ```

   **Explanation**: The `username` property in the component is bound to the `<input>` field in the template. Any change in the input will automatically update the `username` property, and vice versa. The `ngModel` directive helps to synchronize both the model and the view.

### Summary of Data Binding Types:

1. **Interpolation**: One-way binding from the component to the view.
   - Syntax: `{{ expression }}`
   
2. **Property Binding**: One-way binding from the component to an element property.
   - Syntax: `[property]="expression"`
   
3. **Event Binding**: One-way binding from the view to the component (events).
   - Syntax: `(event)="method($event)"`
   
4. **Two-Way Binding**: Bi-directional binding between the component and the view.
   - Syntax: `[(ngModel)]="property"`

### When to Use Each Type:
- **Interpolation**: When you need to display dynamic data in the view.
- **Property Binding**: When you want to bind a component's property to an element’s attribute, DOM property, or input.
- **Event Binding**: When you want to respond to user actions (like clicks, keystrokes, etc.) and send data to the component.
- **Two-Way Binding**: When you want to create a synchronization between the component's data and the view, such as in forms or input fields. 

These four types of data binding enable Angular to provide an efficient and declarative way of updating the view based on model changes, which makes it easier to manage data flow and UI updates.