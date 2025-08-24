### [Java 8 Stream API Interview Questions](https://youtube.com/playlist?list=PL63BDXJjNfTElajNCfg_2u_pbe1Xi7uTy&si=diocadRqK_Lh3q_K)

---

1.  **Find the word with the highest length in a sentence**:
    Given the sentence:
    ```java
    String sentence = "Java Stream API makes coding concise and powerful";
    ```
    **Output**:
    ```java
    powerful
    ```

---

2.  **Remove duplicates from a string and return the characters in the same order**:
    Given the string:
    ```java
    String str = "programming";
    ```
    **Output**:
    ```java
    progamin
    ```

---

3.  **Find the word with the second highest length in a sentence**:
    Given the sentence:
    ```java
    String sentence = "Java Stream API makes coding concise and powerful";
    ```
    **Output**:
    ```java
    concise
    ```

---

4.  **Find the 2nd highest length of a word in the given sentence**:
    Given the sentence:
    ```java
    String sentence = "Streams are powerful and concise";
    ```
    **Output**:
    ```java
    7
    ```

---

5.  **Find the occurrence of each word in a sentence**:
    Given the sentence:
    ```java
    String sentence = "Java Java Stream Stream API";
    ```
    **Output**:
    ```java
    {Java=2, Stream=2, API=1}
    ```

---

6.  **Find the words with a specified number of vowels**:
    Given the sentence:
    ```java
    String sentence = "education brings opportunities";
    int vowelCount = 4;
    ```
    **Output**:
    ```java
    [education, opportunities]
    ```

---

7.  **Divide a list of integers into even and odd**:
    Given the list:
    ```java
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9);
    ```
    **Output**:
    ```java
    {EVEN=[2, 4, 6, 8], ODD=[1, 3, 5, 7, 9]}
    ```

---

8.  **Find the occurrence of each character in a word**:
    Given the word:
    ```java
    String word = "banana";
    ```
    **Output**:
    ```java
    {b=1, a=3, n=2}
    ```

---

9.  **Arrange numbers in descending/ascending order**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(5, 2, 8, 1, 3);
    ```
    **Output**:
    ```java
    Asc: [1, 2, 3, 5, 8]
    Desc: [8, 5, 3, 2, 1]
    ```

---

10. **Find the sum of unique elements in an array**:
    Given the array:
    ```java
    int[] arr = {1, 2, 2, 3, 4, 4, 5};
    ```
    **Output**:
    ```java
    15
    ```

---

11. **Find the first non-repeated character in a string**:
    Given the string:
    ```java
    String str = "swiss";
    ```
    **Output**:
    ```java
    w
    ```

---

12. **Find the first repeated character in a string**:
    Given the string:
    ```java
    String str = "programming";
    ```
    **Output**:
    ```java
    r
    ```

---

13. **Group numbers by range (e.g., 0-10, 11-20, etc.)**:
    Given the array:
    ```java
    int[] arr = {5, 12, 25, 37, 45};
    ```
    **Output**:
    ```java
    {0-10=[5], 11-20=[12], 21-30=[25], 31-40=[37], 41-50=[45]}
    ```

---

14. **Filter only integers from a list of strings**:
    Given the list:
    ```java
    List<String> data = Arrays.asList("123", "abc", "45", "xyz", "7");
    ```
    **Output**:
    ```java
    [123, 45, 7]
    ```

---

15. **Find the product of the first two elements in an array**:
    Given the array:
    ```java
    int[] arr = {2, 3, 4, 5};
    ```
    **Output**:
    ```java
    6
    ```

---

16. **Group/pair anagrams from a list of strings**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("bat", "tab", "cat", "act", "tac");
    ```
    **Output**:
    ```java
    [[bat, tab], [cat, act, tac]]
    ```

---

17. **Multiply alternative numbers in an array (1st, 3rd, 5th, etc.)**:
    Given the array:
    ```java
    int[] arr = {2, 3, 4, 5, 6};
    ```
    **Output**:
    ```java
    48 // 2 * 4 * 6
    ```

---

18. **Multiply elements from opposite ends (1st and last, 2nd and 2nd last, etc.)**:
    Given the array:
    ```java
    int[] arr = {2, 3, 4, 5};
    ```
    **Output**:
    ```java
    [10, 12] // 2*5=10, 3*4=12
    ```

---

19. **Move all zero’s to the beginning of an array**:
    Given the array:
    ```java
    int[] arr = {1, 0, 2, 0, 3};
    ```
    **Output**:
    ```java
    [0, 0, 1, 2, 3]
    ```

---

20. **Check if an array contains distinct values**:
    Given the array:
    ```java
    int[] arr = {1, 2, 3, 4};
    ```
    **Output**:
    ```java
    true
    ```

---

21. **Group strings by their middle character**:
    Given the array:
    ```java
    String[] arr = {"cat", "bat", "hat", "dog"};
    ```
    **Output**:
    ```java
    {a=[cat, bat, hat], o=[dog]}
    ```

---

22. **Find the sum of all elements in a list**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(1, 2, 3, 4, 5);
    ```
    **Output**:
    ```java
    15
    ```

---

23. **Sort a list of strings in alphabetical order**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("banana", "apple", "cherry");
    ```
    **Output**:
    ```java
    [apple, banana, cherry]
    ```

---

24. **Convert a list of integers to their squares**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(1, 2, 3, 4);
    ```
    **Output**:
    ```java
    [1, 4, 9, 16]
    ```

---

25. **Find distinct odd numbers in a list**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(1, 2, 3, 3, 5, 6, 7, 7, 9);
    ```
    **Output**:
    ```java
    [1, 3, 5, 7, 9]
    ```

---

26. **Find the union of two lists (all distinct elements)**:
    Given:
    ```java
    List<Integer> l1 = Arrays.asList(1, 2, 3);
    List<Integer> l2 = Arrays.asList(3, 4, 5);
    ```
    **Output**:
    ```java
    [1, 2, 3, 4, 5]
    ```

---

27. **Find the kth smallest element in a list**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(7, 10, 4, 3, 20, 15);
    int k = 3;
    ```
    **Output**:
    ```java
    7
    ```

---

28. **Remove all non-numeric strings from a list**:
    Given the list:
    ```java
    List<String> items = Arrays.asList("123", "abc", "45", "!@#", "7x");
    ```
    **Output**:
    ```java
    [123, 45]
    ```

---

29. **Print strings containing only digits**:
    Given the list:
    ```java
    List<String> items = Arrays.asList("123", "45a", "789", "abc");
    ```
    **Output**:
    ```java
    [123, 789]
    ```

---

30. **Convert a list of strings to uppercase**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("java", "stream", "api");
    ```
    **Output**:
    ```java
    [JAVA, STREAM, API]
    ```

---

31. **Calculate the average of numbers**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(10, 20, 30, 40);
    ```
    **Output**:
    ```java
    25.0
    ```

---

32. **Find the intersection of two lists (common elements)**:
    Given:
    ```java
    List<Integer> l1 = Arrays.asList(1, 2, 3, 4);
    List<Integer> l2 = Arrays.asList(3, 4, 5, 6);
    ```
    **Output**:
    ```java
    [3, 4]
    ```

---

33. **Find the occurrence count of email domains**:
    Given the list:
    ```java
    List<String> emails = Arrays.asList("a@gmail.com", "b@yahoo.com", "c@gmail.com");
    ```
    **Output**:
    ```java
    {gmail.com=2, yahoo.com=1}
    ```

---

34. **Generate the first 10 Fibonacci numbers**:
    **Output**:
    ```java
    [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    ```

---

35. **Convert a list of integers to their squares**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(1, 2, 3);
    ```
    **Output**:
    ```java
    [1, 4, 9]
    ```

---

36. **Transform a list of Person objects into a single comma-separated string of names**:
    Given:
    ```java
    List<Person> persons = Arrays.asList(new Person("John"), new Person("Jane"));
    ```
    **Output**:
    ```java
    "John, Jane"
    ```

---

37. **Group strings by their first character and count the number in each group**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("apple", "apricot", "banana", "blueberry");
    ```
    **Output**:
    ```java
    {a=2, b=2}
    ```

---

38. **Convert a list of strings to a map where key is the string and value is its length**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("a", "bb", "ccc");
    ```
    **Output**:
    ```java
    {a=1, bb=2, ccc=3}
    ```

---

39. **Find the product of all elements in an array**:
    Given the array:
    ```java
    int[] arr = {1, 2, 3, 4};
    ```
    **Output**:
    ```java
    24 // 1 * 2 * 3 * 4
    ```

---

40. **Can we reuse a stream in Java 8?**  
    **Output**:
    ```java
    No, streams cannot be reused once a terminal operation has been called. They are single-use.
    ```

---

41. **Convert a list of strings to uppercase and then concatenate them into a single string**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("java", "api");
    ```
    **Output**:
    ```java
    "JAVAAPI"
    ```

---

42. **Concatenate two streams**:
    Given:
    ```java
    List<String> l1 = Arrays.asList("A", "B");
    List<String> l2 = Arrays.asList("C", "D");
    ```
    **Output**:
    ```java
    [A, B, C, D]
    ```

---

43. **Best Practice: Avoid overly complex and nested stream pipelines for better readability.**

---

44. **Implement common aggregate operations: filter evens, then find sum, min, and average**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(2, 4, 6, 8);
    ```
    **Output**:
    ```java
    Sum=20, Min=2, Avg=5.0
    ```

---

45. **Best Practice: Avoid re-using streams. Create a new stream for each operation.**

---

46. **Best Practice: Always use a limit() with infinite streams (e.g., Stream.generate()) to prevent infinite execution.**

---

47. **Commonly used Stream methods: `filter`, `map`, `flatMap`, `sorted`, `collect`, `reduce`, `findFirst`, `findAny`, `anyMatch`, `allMatch`, `noneMatch`, `distinct`, `limit`, `skip`, `forEach`.**

---

48. **Print the middle character of a string (if even length, print the one just left of center)**:
    Given the string:
    ```java
    String str = "hello"; // length=5, middle index=2
    ```
    **Output**:
    ```java
    l
    ```

---

49. **Print distinct numbers that start with the digit '1', sorted in descending order**:
    Given the list:
    ```java
    List<Integer> nums = Arrays.asList(10, 11, 21, 13, 19, 11, 10);
    ```
    **Output**:
    ```java
    [19, 13, 11, 10]
    ```

---

50. **Print employees from a list who have a salary greater than 50,000 and give them a 10% raise**:
    Given:
    ```java
    List<Employee> employees = Arrays.asList(
        new Employee("John", 45000),
        new Employee("Jane", 55000),
        new Employee("Jack", 65000)
    );
    ```
    **Output**:
    ```java
    Jane 60500.0
    Jack 71500.0
    ```

---

51. **Sort a list of Person objects first by firstName, then by lastName**:
    Given:
    ```java
    List<Person> people = Arrays.asList(
        new Person("John", "Doe"),
        new Person("John", "Smith"),
        new Person("Alice", "Adams")
    );
    ```
    **Output**:
    ```java
    [Alice Adams, John Doe, John Smith]
    ```

---

52. **Print the count of a particular substring in a list of strings**:
    Given:
    ```java
    List<String> logs = Arrays.asList(
        "ERROR: Disk full",
        "INFO: Operation completed",
        "ERROR: File not found",
        "WARN: Connection slow"
    );
    String searchTerm = "ERROR";
    ```
    **Output**:
    ```java
    2
    ```

---

53. **Find the department with the maximum number of employees**:
    Given:
    ```java
    List<Employee> employees = Arrays.asList(
        new Employee("John", "IT"),
        new Employee("Jane", "HR"),
        new Employee("Jack", "IT"),
        new Employee("Jill", "Finance")
    );
    ```
    **Output**:
    ```java
    IT
    ```

---

54. **Find the average salary for each department**:
    Given:
    ```java
    List<Employee> employees = Arrays.asList(
        new Employee("John", "IT", 60000),
        new Employee("Jane", "IT", 65000),
        new Employee("Jack", "HR", 55000),
        new Employee("Jill", "HR", 50000)
    );
    ```
    **Output**:
    ```java
    {IT=62500.0, HR=52500.0}
    ```

---

55. **Reorder a list of log messages, assumed to be in reverse chronological order, into chronological order**:
    Given:
    ```java
    List<String> logMessages = Arrays.asList(
        "2023-11-10: Event C",
        "2023-11-09: Event B",
        "2023-11-08: Event A"
    );
    ```
    **Output**:
    ```java
    [2023-11-08: Event A, 2023-11-09: Event B, 2023-11-10: Event C]
    ```

---

56. **Return the character with the maximum frequency in a string**:
    Given the string:
    ```java
    String str = "aabbbccdeefff";
    ```
    **Output**:
    ```java
    b // appears 3 times
    ```

---

57. **Convert a list of strings into a map where the key is the string and the value is its length**:
    Given the list:
    ```java
    List<String> words = Arrays.asList("Java", "Stream", "API");
    ```
    **Output**:
    ```java
    {Java=4, Stream=6, API=3}
    ```

---

58. **Transform a list of Employee objects into a list of EmployeeDTO objects (containing only name and department)**:
    Given:
    ```java
    List<Employee> employees = Arrays.asList(
        new Employee("John", "IT", 60000),
        new Employee("Jane", "HR", 55000)
    );
    ```
    **Output**:
    ```java
    [EmployeeDTO{name='John', department='IT'}, EmployeeDTO{name='Jane', department='HR'}]
    ```

---

59. **Find the employee with the highest salary**:
    Given:
    ```java
    List<Employee> employees = Arrays.asList(
        new Employee("John", 60000),
        new Employee("Jane", 75000),
        new Employee("Jack", 55000)
    );
    ```
    **Output**:
    ```java
    Employee{name='Jane', salary=75000}
    ```