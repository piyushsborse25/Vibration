### **Validations in Angular**
Angular provides powerful validation mechanisms to ensure user inputs are correct and meet predefined criteria. Angular's validation system includes **template-driven forms** and **reactive forms**, each offering various validation techniques.

---

## **1. Types of Validations in Angular**
Angular supports **built-in validators** and **custom validators** in forms.

### **A. Built-in Validators**
Angular provides several predefined validators in the `Validators` class, which can be used in both template-driven and reactive forms.

| Validator | Description |
|-----------|-------------|
| `required` | Field must not be empty |
| `minlength(length)` | Minimum length of input |
| `maxlength(length)` | Maximum length of input |
| `pattern(regex)` | Matches input against a regular expression |
| `email` | Ensures input is a valid email format |
| `min(value)` | Minimum numeric value allowed |
| `max(value)` | Maximum numeric value allowed |

---

## **2. Implementing Validations in Angular**

### **A. Template-Driven Forms Validation**
Template-driven forms use directives such as `ngModel` to bind data and apply validations.

#### **Example: Validations in Template-Driven Form**
```html
<form #userForm="ngForm">
  <!-- Required Validation -->
  <input type="text" name="username" ngModel required #username="ngModel">
  <div *ngIf="username.invalid && username.touched">Username is required</div>

  <!-- Email Validation -->
  <input type="email" name="email" ngModel email #email="ngModel">
  <div *ngIf="email.invalid && email.touched">Enter a valid email</div>

  <!-- Pattern Validation (Only Alphabets) -->
  <input type="text" name="name" ngModel pattern="^[a-zA-Z]+$" #name="ngModel">
  <div *ngIf="name.invalid && name.touched">Only alphabets allowed</div>

  <button [disabled]="userForm.invalid">Submit</button>
</form>
```

**Explanation:**
- `#username="ngModel"` allows tracking validation state.
- `ngModel` along with `required`, `email`, and `pattern` applies built-in validation.
- The error message is displayed when the field is **invalid** and **touched**.

---

### **B. Reactive Forms Validation**
Reactive forms provide more control and flexibility by defining validation rules programmatically.

#### **Example: Validations in Reactive Form**
**Component File (app.component.ts)**
```typescript
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html'
})
export class AppComponent {
  userForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.userForm = this.fb.group({
      username: ['', Validators.required],  // Required Validation
      email: ['', [Validators.required, Validators.email]],  // Email Validation
      password: ['', [Validators.required, Validators.minLength(6)]],  // Minimum Length Validation
      age: ['', [Validators.required, Validators.min(18), Validators.max(60)]],  // Min-Max Value Validation
    });
  }

  onSubmit() {
    if (this.userForm.valid) {
      console.log(this.userForm.value);
    }
  }
}
```

**Template File (app.component.html)**
```html
<form [formGroup]="userForm" (ngSubmit)="onSubmit()">
  <input type="text" formControlName="username" placeholder="Username">
  <div *ngIf="userForm.get('username').invalid && userForm.get('username').touched">Username is required</div>

  <input type="email" formControlName="email" placeholder="Email">
  <div *ngIf="userForm.get('email').invalid && userForm.get('email').touched">Enter a valid email</div>

  <input type="password" formControlName="password" placeholder="Password">
  <div *ngIf="userForm.get('password').invalid && userForm.get('password').touched">Min 6 characters required</div>

  <input type="number" formControlName="age" placeholder="Age">
  <div *ngIf="userForm.get('age').invalid && userForm.get('age').touched">Age must be between 18 and 60</div>

  <button type="submit" [disabled]="userForm.invalid">Submit</button>
</form>
```

**Explanation:**
- `FormBuilder` is used to create the form dynamically.
- `Validators.required`, `Validators.email`, `Validators.minLength()`, `Validators.min()` are used for validation.
- Error messages are displayed when the field is invalid and touched.

---

## **3. Custom Validators**
When built-in validators are not sufficient, Angular allows us to create custom validators.

### **A. Custom Validator Function**
Let's create a validator that ensures the password contains at least one uppercase letter and one special character.

```typescript
import { AbstractControl, ValidationErrors } from '@angular/forms';

export function strongPasswordValidator(control: AbstractControl): ValidationErrors | null {
  const value = control.value;
  if (!/[A-Z]/.test(value) || !/[!@#$%^&*]/.test(value)) {
    return { strongPassword: true };
  }
  return null;
}
```

**Applying Custom Validator:**
```typescript
this.userForm = this.fb.group({
  password: ['', [Validators.required, strongPasswordValidator]]
});
```

**Displaying Custom Validation Message:**
```html
<div *ngIf="userForm.get('password').hasError('strongPassword')">
  Password must contain at least one uppercase letter and one special character.
</div>
```

---

### **B. Custom Async Validator (Checking if Username Already Exists)**
```typescript
import { AbstractControl } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { map, delay } from 'rxjs/operators';

export function usernameExistsValidator(control: AbstractControl): Observable<{ usernameTaken: boolean } | null> {
  const existingUsernames = ['admin', 'testuser'];  // Mock existing usernames

  return of(existingUsernames.includes(control.value)).pipe(
    delay(1000),  // Simulating server request
    map(isTaken => (isTaken ? { usernameTaken: true } : null))
  );
}
```

**Applying Async Validator:**
```typescript
this.userForm = this.fb.group({
  username: ['', Validators.required, usernameExistsValidator]
});
```

**Displaying Async Validation Message:**
```html
<div *ngIf="userForm.get('username').hasError('usernameTaken')">
  This username is already taken. Choose another one.
</div>
```

---

## **4. Enabling/Disabling Validation Dynamically**
Angular allows enabling or disabling validation dynamically using `setValidators()`.

```typescript
this.userForm.get('email').setValidators([Validators.required, Validators.email]);
this.userForm.get('email').updateValueAndValidity();
```

---

## **5. Displaying Validation Errors Dynamically**
Instead of writing separate `<div>` for each field, we can create a function to handle errors dynamically.

```typescript
getErrorMessage(field: string) {
  const control = this.userForm.get(field);
  if (control.hasError('required')) return 'This field is required';
  if (control.hasError('email')) return 'Enter a valid email';
  if (control.hasError('minlength')) return `Minimum length required: ${control.errors?.minlength.requiredLength}`;
  return '';
}
```

**Usage in Template:**
```html
<div *ngIf="userForm.get('email').invalid && userForm.get('email').touched">
  {{ getErrorMessage('email') }}
</div>
```

---

## **Conclusion**
- **Built-in Validators**: `required`, `minlength`, `maxlength`, `email`, `pattern`, `min`, `max`
- **Template-driven Forms**: Uses `ngModel` and validation directives.
- **Reactive Forms**: Uses `FormBuilder` and `Validators` programmatically.
- **Custom Validators**: Create reusable validation functions.
- **Async Validators**: Validate against backend data asynchronously.
- **Dynamic Validation**: Enable/disable validation dynamically using `setValidators()`.

By implementing these validation techniques, Angular ensures that user input is properly validated before processing, enhancing security and user experience. 🚀