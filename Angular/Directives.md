In Angular, **directives** are used to add behavior to elements in the DOM. They allow you to manipulate the DOM structure or modify the behavior of HTML elements. There are three main types of directives in Angular:

### 1. **Structural Directives**
Structural directives are responsible for altering the DOM layout by adding or removing elements. These directives modify the structure of the DOM.

#### Common Structural Directives:
- **`*ngIf`**: Conditionally includes or excludes an element from the DOM based on an expression.
  ```html
  <div *ngIf="isVisible">This content is visible when isVisible is true.</div>
  ```

- **`*ngFor`**: Loops over a collection (such as an array or list) and repeats an element for each item in the collection.
  ```html
  <ul>
    <li *ngFor="let item of items">{{ item }}</li>
  </ul>
  ```

- **`*ngSwitch`**: A group of directives that works similar to a switch-case in JavaScript. It conditionally displays an element based on the value of an expression.
  ```html
  <div [ngSwitch]="currentSelection">
    <div *ngSwitchCase="'option1'">Option 1 selected</div>
    <div *ngSwitchCase="'option2'">Option 2 selected</div>
    <div *ngSwitchDefault>Default Option</div>
  </div>
  ```

### 2. **Attribute Directives**
Attribute directives are used to modify the appearance or behavior of a DOM element by changing its attributes or properties. They don’t alter the DOM structure but affect the elements’ look or behavior.

#### Common Attribute Directives:
- **`ngClass`**: Adds or removes CSS classes to an element conditionally based on an expression.
  ```html
  <div [ngClass]="{ 'highlight': isHighlighted }">This element may be highlighted.</div>
  ```

- **`ngStyle`**: Adds or removes inline styles to an element based on an expression.
  ```html
  <div [ngStyle]="{ 'background-color': color }">This element has dynamic background color.</div>
  ```

- **`[attr.*]`**: Binds an attribute to an element.
  ```html
  <img [attr.src]="imageUrl" />
  ```

- **`[disabled]`**: Conditionally enables or disables form elements like buttons or inputs.
  ```html
  <button [disabled]="isDisabled">Click Me</button>
  ```

- **`[readonly]`**: Conditionally applies the "readonly" attribute.
  ```html
  <input [readonly]="isReadOnly" />
  ```

- **`[style.*]`**: Binds a style to an element, allowing for dynamic styling.
  ```html
  <div [style.color]="textColor">This element has dynamic text color.</div>
  ```

### 3. **Custom Directives**
Angular allows you to create your own custom directives, both structural and attribute, to encapsulate logic and behaviors for reuse in your application.

#### Example of a Custom Attribute Directive:
A simple custom directive that changes the background color of an element when hovered.

```typescript
import { Directive, ElementRef, Renderer2, HostListener } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {
  constructor(private el: ElementRef, private renderer: Renderer2) {}

  @HostListener('mouseenter') onMouseEnter() {
    this.renderer.setStyle(this.el.nativeElement, 'background-color', 'yellow');
  }

  @HostListener('mouseleave') onMouseLeave() {
    this.renderer.removeStyle(this.el.nativeElement, 'background-color');
  }
}
```

In the template, you can use this directive as follows:
```html
<div appHighlight>Hover over me to change my background color.</div>
```

#### Example of a Custom Structural Directive:
A custom structural directive that hides or shows an element based on a condition.

```typescript
import { Directive, TemplateRef, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[appIf]'
})
export class IfDirective {
  constructor(private templateRef: TemplateRef<any>, private viewContainer: ViewContainerRef) {}

  set appIf(condition: boolean) {
    if (condition) {
      this.viewContainer.createEmbeddedView(this.templateRef);
    } else {
      this.viewContainer.clear();
    }
  }
}
```

In the template, you can use this directive like:
```html
<div *appIf="isVisible">This content is conditionally rendered based on isVisible.</div>
```

### Summary of Directive Types:

1. **Structural Directives**: Modify the structure of the DOM by adding or removing elements.
   - `*ngIf`
   - `*ngFor`
   - `*ngSwitch`

2. **Attribute Directives**: Modify the appearance or behavior of an element, such as its style or classes.
   - `ngClass`
   - `ngStyle`
   - `[attr.*]`
   - `[disabled]`
   - `[readonly]`
   - `[style.*]`

3. **Custom Directives**: Custom user-defined directives that can be either structural or attribute directives, enabling you to encapsulate reusable behavior for DOM manipulation.

Directives are a powerful feature of Angular, enabling you to modularize and reuse behavior across components and templates in a clean and efficient way.