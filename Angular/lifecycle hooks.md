In Angular, lifecycle hooks are methods that allow you to tap into key moments in a component or directive's lifecycle. These hooks provide a way for you to perform custom logic during different stages of the lifecycle of a component or directive. Here's an explanation of all the lifecycle hooks available in Angular:

### 1. **`ngOnChanges()`**
   - **When it's called**: Whenever there are changes to input properties of the component or directive (i.e., when the values bound to `@Input()` properties change).
   - **Parameters**: It receives a `SimpleChanges` object containing the current and previous values of the input properties.
   - **Use case**: Useful for responding to input changes, such as performing calculations or updating dependent values.
   ```typescript
   ngOnChanges(changes: SimpleChanges) {
     console.log(changes);
   }
   ```

### 2. **`ngOnInit()`**
   - **When it's called**: Called once, after the first `ngOnChanges()` call and when Angular sets up the input properties for the component.
   - **Use case**: Ideal for initializing logic, like fetching data or setting up services. It’s the most commonly used hook for initialization.
   ```typescript
   ngOnInit() {
     console.log('Component initialized!');
   }
   ```

### 3. **`ngDoCheck()`**
   - **When it's called**: Called during every change detection cycle, even if no inputs have changed.
   - **Use case**: Used when you need to perform custom change detection or track changes that Angular's default change detection doesn’t detect.
   ```typescript
   ngDoCheck() {
     console.log('Change detection cycle is running');
   }
   ```

### 4. **`ngAfterContentInit()`**
   - **When it's called**: Called once, after Angular projects content into the component (i.e., after the content inside `<ng-content>` is available).
   - **Use case**: Used when you need to perform actions once content has been projected into the component, such as initializing values in child components or DOM manipulation.
   ```typescript
   ngAfterContentInit() {
     console.log('Content has been projected into the component');
   }
   ```

### 5. **`ngAfterContentChecked()`**
   - **When it's called**: Called after every check of content projected into the component.
   - **Use case**: Used to perform actions after Angular checks the projected content.
   ```typescript
   ngAfterContentChecked() {
     console.log('Content has been checked');
   }
   ```

### 6. **`ngAfterViewInit()`**
   - **When it's called**: Called once, after Angular initializes the component's view and child views.
   - **Use case**: Useful for initialization logic that depends on the view or child components being available, such as DOM manipulation or working with child component references.
   ```typescript
   ngAfterViewInit() {
     console.log('View has been initialized');
   }
   ```

### 7. **`ngAfterViewChecked()`**
   - **When it's called**: Called after every check of the component's view and child views.
   - **Use case**: Used when you need to perform custom logic after Angular has checked the component's view and its child views.
   ```typescript
   ngAfterViewChecked() {
     console.log('View has been checked');
   }
   ```

### 8. **`ngOnDestroy()`**
   - **When it's called**: Called just before Angular destroys the component or directive.
   - **Use case**: Ideal for cleanup tasks such as unsubscribing from observables, removing event listeners, or invalidating timers.
   ```typescript
   ngOnDestroy() {
     console.log('Component is being destroyed');
   }
   ```

### Summary of Lifecycle Hook Call Order:
Here’s the order in which Angular invokes these lifecycle hooks:

1. **`ngOnChanges()`** (if there are input property changes)
2. **`ngOnInit()`**
3. **`ngDoCheck()`**
4. **`ngAfterContentInit()`**
5. **`ngAfterContentChecked()`**
6. **`ngAfterViewInit()`**
7. **`ngAfterViewChecked()`**
8. **`ngOnDestroy()`** (when the component is being destroyed)

### Example Use Case:

```typescript
@Component({
  selector: 'app-lifecycle-example',
  templateUrl: './lifecycle-example.component.html',
})
export class LifecycleExampleComponent implements OnInit, OnChanges, AfterViewInit, OnDestroy {
  
  @Input() inputProperty: string;

  ngOnChanges(changes: SimpleChanges) {
    console.log('ngOnChanges', changes);
  }

  ngOnInit() {
    console.log('ngOnInit');
  }

  ngDoCheck() {
    console.log('ngDoCheck');
  }

  ngAfterContentInit() {
    console.log('ngAfterContentInit');
  }

  ngAfterContentChecked() {
    console.log('ngAfterContentChecked');
  }

  ngAfterViewInit() {
    console.log('ngAfterViewInit');
  }

  ngAfterViewChecked() {
    console.log('ngAfterViewChecked');
  }

  ngOnDestroy() {
    console.log('ngOnDestroy');
  }
}
```

In this example, every hook logs a message to the console to show the order in which they are triggered.

These hooks provide fine-grained control over a component’s lifecycle, allowing developers to optimize performance, manage resources, and respond to changes effectively.