In Angular, decorators are special types of annotations that provide metadata to classes, properties, and methods. They are used to modify or configure the behavior of the Angular elements they are attached to. Here are the main types of decorators in Angular:

### 1. **Class Decorators**
   - **`@Component`**: Defines an Angular component, providing metadata such as the selector, template, styles, etc.
     ```typescript
     @Component({
       selector: 'app-root',
       templateUrl: './app.component.html',
       styleUrls: ['./app.component.css']
     })
     export class AppComponent {}
     ```

   - **`@Directive`**: Defines a directive, which allows you to extend HTML with custom behavior.
     ```typescript
     @Directive({
       selector: '[appHighlight]'
     })
     export class HighlightDirective {}
     ```

   - **`@Injectable`**: Marks a class as available for dependency injection.
     ```typescript
     @Injectable({
       providedIn: 'root',
     })
     export class MyService {}
     ```

   - **`@NgModule`**: Defines an Angular module, which contains metadata about the components, services, and other modules included in the module.
     ```typescript
     @NgModule({
       declarations: [AppComponent],
       imports: [BrowserModule],
       providers: [],
       bootstrap: [AppComponent]
     })
     export class AppModule {}
     ```

### 2. **Property Decorators**
   - **`@Input`**: Marks a property as an input, allowing data to be passed from a parent component to a child component.
     ```typescript
     @Input() name: string;
     ```

   - **`@Output`**: Marks a property as an output, allowing data or events to be emitted from a child component to a parent component.
     ```typescript
     @Output() change = new EventEmitter<string>();
     ```

   - **`@HostBinding`**: Binds a property of the host element to a class or style.
     ```typescript
     @HostBinding('class.active') isActive = true;
     ```

   - **`@HostListener`**: Attaches an event listener to a DOM event on the host element.
     ```typescript
     @HostListener('click') onClick() {
       console.log('Element clicked');
     }
     ```

### 3. **Method Decorators**
   - **`@ViewChild`**: Gets a reference to a child component, directive, or DOM element within a component’s view.
     ```typescript
     @ViewChild(ChildComponent) childComponent: ChildComponent;
     ```

   - **`@ContentChild`**: Gets a reference to a projected content (content passed into the component via `<ng-content>`).
     ```typescript
     @ContentChild(ChildComponent) contentChild: ChildComponent;
     ```

### 4. **Parameter Decorators**
   - **`@Inject`**: Specifies the dependency to inject into a constructor parameter.
     ```typescript
     constructor(@Inject(MyService) private myService: MyService) {}
     ```

   - **`@Optional`**: Marks a dependency as optional.
     ```typescript
     constructor(@Optional() private myService: MyService) {}
     ```

### 5. **Other Angular Decorators**
   - **`@Pipe`**: Marks a class as a pipe and provides metadata about the pipe, such as its name and transformation logic.
     ```typescript
     @Pipe({
       name: 'currency'
     })
     export class CurrencyPipe implements PipeTransform {
       transform(value: number): string {
         return '$' + value;
       }
     }
     ```

   - **`@Host`**: Marks a directive or component to be attached to the host element of another component.
     ```typescript
     @Directive({
       selector: '[appFocus]',
       host: { '(click)': 'onClick()' }
     })
     export class FocusDirective {
       onClick() {
         console.log('Host element clicked!');
       }
     }
     ```

### Conclusion
These decorators play a crucial role in Angular by associating metadata with different elements of the framework, making the framework more powerful and flexible.