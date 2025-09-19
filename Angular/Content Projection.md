**Content Projection** in Angular is a mechanism that allows you to insert dynamic content into a component’s template from its parent component. This is useful when you want to create reusable, flexible components where the content inside the component can vary depending on the context in which it is used.

There are three types of content projection in Angular:

### 1. **Basic Content Projection**
This is the simplest form of content projection where you insert static content into the component from the parent component. 

- **How it works**: You use the `<ng-content>` directive in the child component’s template to define where the content from the parent component should be inserted.

#### Example:
**Child Component (child.component.html)**:
```html
<p>
  <ng-content></ng-content>
</p>
```

**Parent Component (parent.component.html)**:
```html
<app-child>
  <span>Content from parent component</span>
</app-child>
```

**Explanation**: In this example, the content inside the `<app-child>` tag in the parent component will be projected into the `<ng-content>` tag in the child component. The `ng-content` acts as a placeholder for whatever content is passed into the component.

### 2. **Content Projection with Selectors**
Content projection can also be more specific, where you can project only certain parts of content into specific areas of the child component using selectors.

- **How it works**: You use the `ng-content` directive with the `select` attribute to specify which content should be projected into different parts of the component template.

#### Example:
**Child Component (child.component.html)**:
```html
<div class="header">
  <ng-content select="[header]"></ng-content>
</div>

<div class="body">
  <ng-content select="[body]"></ng-content>
</div>
```

**Parent Component (parent.component.html)**:
```html
<app-child>
  <div header>Header content</div>
  <div body>Body content</div>
</app-child>
```

**Explanation**: In this case, the content inside the parent is projected into different parts of the child component based on the `select` attribute. The `<div header>` content is projected into the `<ng-content select="[header]">`, and the `<div body>` content is projected into the `<ng-content select="[body]">`. This enables more fine-grained control over where the content appears in the child component.

### 3. **Multi-slot Content Projection (Multiple `ng-content`)**
You can have multiple `<ng-content>` elements in your template, allowing you to project different parts of the content into different places within the child component. This is also referred to as "multi-slot content projection."

- **How it works**: Multiple `<ng-content>` tags can be used in the child component’s template to accept different pieces of content from the parent.

#### Example:
**Child Component (child.component.html)**:
```html
<div class="header">
  <ng-content select="[header]"></ng-content>
</div>

<div class="footer">
  <ng-content select="[footer]"></ng-content>
</div>
```

**Parent Component (parent.component.html)**:
```html
<app-child>
  <div header>Header content</div>
  <div footer>Footer content</div>
</app-child>
```

**Explanation**: The content passed into the parent is projected into two distinct areas inside the child component — one for the header and one for the footer. Each `<ng-content>` tag selects content based on the `select` attribute.

### Benefits of Content Projection:
- **Reusable Components**: Content projection allows components to be flexible and reusable, as the content inserted can vary for each use case.
- **Separation of Concerns**: It helps maintain a clean separation between the logic of the component and the content that it displays, enabling you to focus on the structure and layout separately from the content.
- **Customizable Layout**: By projecting content, you can easily customize the structure of a component without changing its internal implementation.

### Use Case:
A common use case for content projection is creating a **modal** component where the content can change dynamically depending on what is passed into it.

#### Example:
**Modal Component (modal.component.html)**:
```html
<div class="modal">
  <div class="modal-header">
    <ng-content select=".modal-header"></ng-content>
  </div>
  <div class="modal-body">
    <ng-content select=".modal-body"></ng-content>
  </div>
  <div class="modal-footer">
    <ng-content select=".modal-footer"></ng-content>
  </div>
</div>
```

**Parent Component (parent.component.html)**:
```html
<app-modal>
  <div class="modal-header">Modal Header</div>
  <div class="modal-body">This is the modal body content.</div>
  <div class="modal-footer">Footer content</div>
</app-modal>
```

**Explanation**: The parent provides different pieces of content for the modal header, body, and footer, which are projected into specific places inside the `app-modal` component.

### Summary:
- **Basic Content Projection**: Passes content directly into the child component.
- **Content Projection with Selectors**: Projects content into specific slots based on CSS selectors.
- **Multi-slot Content Projection**: Uses multiple `ng-content` tags for different parts of the projected content.

Content projection is a powerful tool in Angular for creating flexible and reusable components, enabling you to build dynamic UIs with varying content.