Here’s how and why to override equals() and hashCode() in Java:


---

✅ Why override equals() and hashCode()?

So your custom objects behave correctly in collections like HashMap, HashSet, etc.

Contract: If a.equals(b) is true, then a.hashCode() == b.hashCode() must be true.



---

✅ Override Example

public class Person {
    private String name;
    private int age;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Person person = (Person) obj;
        return age == person.age &&
               name.equals(person.name);
    }

    @Override
    public int hashCode() {
        return 31 * name.hashCode() + age;
    }
}


---

✅ Notes:

Use Objects.equals(a, b) and Objects.hash(...) to make it cleaner.

Modern IDEs (like IntelliJ or Eclipse) can auto-generate these safely.



---

Want a Lombok version or a record-based version for Java 16+?

