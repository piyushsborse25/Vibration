# **Java 8 Stream API Interview Answers**

**1. Find the word with the highest length in a sentence**
```java
String sentence = "Java Stream API makes coding concise and powerful";
String result = Arrays.stream(sentence.split(" "))
                     .max(Comparator.comparingInt(String::length))
                     .orElse("");
// Output: powerful
```

**2. Remove duplicates from a string and return the characters in the same order**
```java
String str = "programming";
String result = str.chars()
                   .mapToObj(c -> (char) c)
                   .distinct()
                   .map(String::valueOf)
                   .collect(Collectors.joining());
// Output: progamin
```

**3. Find the word with the second highest length in a sentence**
```java
String sentence = "Java Stream API makes coding concise and powerful";
List<String> sortedWords = Arrays.stream(sentence.split(" "))
                                .sorted(Comparator.comparingInt(String::length).reversed())
                                .collect(Collectors.toList());
String result = sortedWords.get(1);
// Output: concise
```

**4. Find the 2nd highest length word in the given sentence**
```java
String sentence = "Streams are powerful and concise";
String result = Arrays.stream(sentence.split(" "))
                     .sorted((s1, s2) -> Integer.compare(s2.length(), s1.length()))
                     .skip(1)
                     .findFirst()
                     .orElse("");
// Output: concise
```

**5. Find the occurrence of each word in a sentence**
```java
String sentence = "Java Java Stream Stream API";
Map<String, Long> result = Arrays.stream(sentence.split(" "))
                                .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
// Output: {Java=2, Stream=2, API=1}
```

**6. Find the words with a specified number of vowels**
```java
String sentence = "education brings opportunities";
int vowelCount = 4;
List<String> result = Arrays.stream(sentence.split(" "))
                           .filter(word -> word.replaceAll("[^aeiouAEIOU]", "").length() == vowelCount)
                           .collect(Collectors.toList());
// Output: [education, opportunities]
```

**7. Divide a list of integers into even and odd**
```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9);
Map<String, List<Integer>> result = numbers.stream()
        .collect(Collectors.groupingBy(n -> n % 2 == 0 ? "EVEN" : "ODD"));
// Output: {EVEN=[2, 4, 6, 8], ODD=[1, 3, 5, 7, 9]}
```

**8. Find the occurrence of each character in a word**
```java
String word = "banana";
Map<Character, Long> result = word.chars()
                                  .mapToObj(c -> (char) c)
                                  .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
// Output: {b=1, a=3, n=2}
```

**9. Arrange numbers in descending/ascending order**
```java
List<Integer> nums = Arrays.asList(5, 2, 8, 1, 3);
List<Integer> asc = nums.stream().sorted().collect(Collectors.toList());
List<Integer> desc = nums.stream().sorted(Comparator.reverseOrder()).collect(Collectors.toList());
// Output: Asc: [1, 2, 3, 5, 8], Desc: [8, 5, 3, 2, 1]
```

**10. Find the sum of unique elements in an array**
```java
int[] arr = {1, 2, 2, 3, 4, 4, 5};
int sum = Arrays.stream(arr).distinct().sum();
// Output: 15
```

**11. Find the first non-repeated character in a string**
```java
String str = "swiss";
Character result = str.chars()
                      .mapToObj(c -> (char) c)
                      .collect(Collectors.groupingBy(Function.identity(), LinkedHashMap::new, Collectors.counting()))
                      .entrySet().stream()
                      .filter(entry -> entry.getValue() == 1)
                      .map(Map.Entry::getKey)
                      .findFirst()
                      .orElse(null);
// Output: 'w'
```

**12. Find the first repeated character in a string**
```java
String str = "programming";
Character result = str.chars()
                      .mapToObj(c -> (char) c)
                      .collect(Collectors.groupingBy(Function.identity(), LinkedHashMap::new, Collectors.counting()))
                      .entrySet().stream()
                      .filter(entry -> entry.getValue() > 1)
                      .map(Map.Entry::getKey)
                      .findFirst()
                      .orElse(null);
// Output: 'r'
```

**13. Group numbers by range**
```java
int[] arr = {5, 12, 25, 37, 45};
Map<String, List<Integer>> result = Arrays.stream(arr)
                                         .boxed()
                                         .collect(Collectors.groupingBy(n -> {
                                             int lower = (n / 10) * 10;
                                             int upper = lower + 10;
                                             return lower + "-" + upper;
                                         }));
// Output: {0-10=[5], 10-20=[12], 20-30=[25], 30-40=[37], 40-50=[45]}
```

**14. Filter only integers from a list of strings**
```java
List<String> data = Arrays.asList("123", "abc", "45", "xyz", "7");
List<String> result = data.stream()
                          .filter(s -> s.matches("\\d+"))
                          .collect(Collectors.toList());
// Output: [123, 45, 7]
```

**15. Find the product of the first two elements in an array**
```java
int[] arr = {2, 3, 4, 5};
int product = Arrays.stream(arr).limit(2).reduce(1, (a, b) -> a * b);
// Output: 6
```

**16. Group/pair anagrams from a list of strings**
```java
List<String> words = Arrays.asList("bat", "tab", "cat", "act", "tac");

List<List<String>> test = words.stream()
        .collect(Collectors.groupingBy(
                word -> word.chars()
                        .mapToObj(c -> String.valueOf((char) c))
                        .sorted()
                        .collect(Collectors.joining())
        ))
        .entrySet()
        .stream()
        .map(Map.Entry::getValue)
        .toList();
// Output: [[bat, tab], [cat, act, tac]]
```

**17. Multiply alternative numbers in an array**
```java
int[] arr = {2, 3, 4, 5, 6};
int product = IntStream.range(0, arr.length)
                      .filter(i -> i % 2 == 0)
                      .map(i -> arr[i])
                      .reduce(1, (a, b) -> a * b);
// Output: 48
```

**18. Multiply 1st and last, 2nd and 2nd last, etc.**
```java
int[] arr = {2, 3, 4, 5};
int[] result = IntStream.range(0, arr.length / 2)
                       .map(i -> arr[i] * arr[arr.length - 1 - i])
                       .toArray();
// Output: [10, 12]
```

**19. Move all zero’s to beginning of array**
```java
int[] arr = {1, 0, 2, 0, 3};
int[] result = Arrays.stream(arr)
                    .boxed()
                    .sorted((a, b) -> Integer.compare(b == 0 ? -1 : 0, a == 0 ? -1 : 0))
                    .mapToInt(Integer::intValue)
                    .toArray();
// Output: [0, 0, 1, 2, 3]
```

**20. Check if array contains distinct values**
```java
int[] arr = {1, 2, 3, 4};
boolean distinct = Arrays.stream(arr).distinct().count() == arr.length;
// Output: true
```

**21. Group strings by their middle character**
```java
String[] arr = {"cat", "bat", "hat", "dog"};
Map<Character, List<String>> result = Arrays.stream(arr)
                                           .collect(Collectors.groupingBy(s -> {
                                               int mid = s.length() / 2;
                                               return s.charAt(mid);
                                           }));
// Output: {a=[cat, bat, hat], o=[dog]}
```

**22. Find the sum of all elements in a list**
```java
List<Integer> nums = Arrays.asList(1, 2, 3, 4, 5);
int sum = nums.stream().mapToInt(Integer::intValue).sum();
// Output: 15
```

**23. Sort a list of strings in alphabetical order**
```java
List<String> words = Arrays.asList("banana", "apple", "cherry");
List<String> sorted = words.stream().sorted().collect(Collectors.toList());
// Output: [apple, banana, cherry]
```

**24. Convert a list of integers to their squares**
```java
List<Integer> nums = Arrays.asList(1, 2, 3, 4);
List<Integer> squares = nums.stream().map(n -> n * n).collect(Collectors.toList());
// Output: [1, 4, 9, 16]
```

**25. Find distinct odd numbers in a list**
```java
List<Integer> nums = Arrays.asList(1, 2, 3, 3, 5, 6, 7, 7, 9);
List<Integer> distinctOdds = nums.stream()
                                .filter(n -> n % 2 != 0)
                                .distinct()
                                .collect(Collectors.toList());
// Output: [1, 3, 5, 7, 9]
```

**26. Find the union of two lists**
```java
List<Integer> l1 = Arrays.asList(1, 2, 3);
List<Integer> l2 = Arrays.asList(3, 4, 5);
List<Integer> union = Stream.concat(l1.stream(), l2.stream())
                           .distinct()
                           .collect(Collectors.toList());
// Output: [1, 2, 3, 4, 5]
```

**27. Find the kth smallest element in a list**
```java
List<Integer> nums = Arrays.asList(7, 10, 4, 3, 20, 15);
int k = 3;
int kthSmallest = nums.stream()
                     .sorted()
                     .skip(k - 1)
                     .findFirst()
                     .orElse(-1);
// Output: 7
```

**28. Remove all non-numeric characters from a list**
```java
List<String> items = Arrays.asList("123", "abc", "45", "!@#", "7x");
List<String> numericOnly = items.stream()
                               .filter(s -> s.matches("\\d+"))
                               .collect(Collectors.toList());
// Output: [123, 45]
```

**29. Print strings containing only digits**
```java
List<String> items = Arrays.asList("123", "45a", "789", "abc");
List<String> digitsOnly = items.stream()
                              .filter(s -> s.matches("\\d+"))
                              .collect(Collectors.toList());
// Output: [123, 789]
```

**30. Convert a list of strings to uppercase**
```java
List<String> words = Arrays.asList("java", "stream", "api");
List<String> upperCase = words.stream()
                             .map(String::toUpperCase)
                             .collect(Collectors.toList());
// Output: [JAVA, STREAM, API]
```

**31. Calculate the average of numbers**
```java
List<Integer> nums = Arrays.asList(10, 20, 30, 40);
double average = nums.stream()
                    .mapToInt(Integer::intValue)
                    .average()
                    .orElse(0.0);
// Output: 25.0
```

**32. Find the intersection of two lists**
```java
List<Integer> l1 = Arrays.asList(1, 2, 3, 4);
List<Integer> l2 = Arrays.asList(3, 4, 5, 6);
List<Integer> intersection = l1.stream()
                              .filter(l2::contains)
                              .collect(Collectors.toList());
// Output: [3, 4]
```

**33. Find the occurrence of domains**
```java
List<String> emails = Arrays.asList("a@gmail.com", "b@yahoo.com", "c@gmail.com");
Map<String, Long> domainCount = emails.stream()
                                     .map(email -> email.substring(email.indexOf('@') + 1))
                                     .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
// Output: {gmail.com=2, yahoo.com=1}
```

**34. Generate first 10 Fibonacci numbers**
```java
Stream.iterate(new long[]{0, 1}, fib -> new long[]{fib[1], fib[0] + fib[1]})
      .limit(10)
      .mapToLong(fib -> fib[0])
      .boxed()
      .collect(Collectors.toList());
// Output: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

**35. Convert integers to their squares**
```java
List<Integer> nums = Arrays.asList(1, 2, 3);
List<Integer> squares = nums.stream().map(n -> n * n).collect(Collectors.toList());
// Output: [1, 4, 9]
```

**36. Transform Person object stream into a single string**
```java
List<Person> persons = Arrays.asList(new Person("John"), new Person("Jane"));
String result = persons.stream()
                      .map(Person::getName)
                      .collect(Collectors.joining(", "));
// Output: "John, Jane"
```

**37. Group strings by their first character and count**
```java
List<String> words = Arrays.asList("apple", "apricot", "banana", "blueberry");
Map<Character, Long> result = words.stream()
                                  .collect(Collectors.groupingBy(s -> s.charAt(0), Collectors.counting()));
// Output: {a=2, b=2}
```

**38. Convert a list to a map (string to length)**
```java
List<String> words = Arrays.asList("a", "bb", "ccc");
Map<String, Integer> result = words.stream()
                                  .collect(Collectors.toMap(Function.identity(), String::length));
// Output: {a=1, bb=2, ccc=3}
```

**39. Multiply array elements**
```java
int[] arr = {1, 2, 3, 4};
int product = Arrays.stream(arr).reduce(1, (a, b) -> a * b);
// Output: 24
```

**40. Can we reuse stream in Java 8?**
```java
// No, streams cannot be reused once a terminal operation has been invoked.
// Attempting to reuse a stream will throw an IllegalStateException.
```

**41. Convert a list to uppercase and concatenate**
```java
List<String> words = Arrays.asList("java", "api");
String result = words.stream()
                    .map(String::toUpperCase)
                    .collect(Collectors.joining());
// Output: "JAVAAPI"
```

**42. Concatenate 2 streams**
```java
List<String> l1 = Arrays.asList("A", "B");
List<String> l2 = Arrays.asList("C", "D");
List<String> combined = Stream.concat(l1.stream(), l2.stream())
                             .collect(Collectors.toList());
// Output: [A, B, C, D]
```

**43. Best Practices #1 – Avoid Complex Stream Pipelines**
```java
// Break down complex stream operations into smaller, more readable steps.
// Consider using intermediate variables for better maintainability.
```

**44. Implement filter, reduction, average, min**
```java
List<Integer> nums = Arrays.asList(2, 4, 6, 8);
int sum = nums.stream().mapToInt(Integer::intValue).sum();
int min = nums.stream().mapToInt(Integer::intValue).min().orElse(0);
double avg = nums.stream().mapToInt(Integer::intValue).average().orElse(0.0);
// Output: Sum=20, Min=2, Avg=5.0
```

**45. Best Practices #2 – Avoid re-using streams**
```java
// Streams are single-use. Create a new stream for each operation.
// Reusing a consumed stream will throw an IllegalStateException.
```

**46. Best Practices #3 – Limiting infinite streams and method use**
```java
// Always use limit() with Stream.iterate() or Stream.generate()
// to prevent infinite operations that can crash your application.
```

**47. Commonly used Stream methods**
```java
// Intermediate: filter, map, flatMap, sorted, distinct, limit, skip
// Terminal: forEach, collect, reduce, findFirst, findAny, anyMatch, allMatch, noneMatch, count, min, max
```

**48. Print the middle character of a string**
```java
String str = "hello";
String result = String.valueOf(str.charAt(str.length() / 2));
// Output: "l"
```

**49. Print distinct numbers starting with 1 in descending order**
```java
List<Integer> nums = Arrays.asList(10, 11, 21, 13, 19);
List<Integer> result = nums.stream()
                          .distinct()
                          .filter(n -> String.valueOf(n).startsWith("1"))
                          .sorted(Comparator.reverseOrder())
                          .collect(Collectors.toList());
// Output: [19, 13, 11, 10]
```

**50. Print employees whose salary filtered and modified**
```java
List<Employee> employees = Arrays.asList(
    new Employee("John", 45000),
    new Employee("Jane", 55000),
    new Employee("Jack", 65000)
);

employees.stream()
         .filter(e -> e.getSalary() > 50000)
         .map(e -> {
             e.setSalary(e.getSalary() * 1.1);
             return e;
         })
         .forEach(e -> System.out.println(e.getName() + " " + e.getSalary()));
// Output: Jane 60500.0, Jack 71500.0
```

**51. Compare Person objects by first name then last name**
```java
List<Person> people = Arrays.asList(
    new Person("John", "Doe"),
    new Person("John", "Smith"),
    new Person("Alice", "Adams")
);

List<Person> sorted = people.stream()
                           .sorted(Comparator.comparing(Person::getFirstName)
                                          .thenComparing(Person::getLastName))
                           .collect(Collectors.toList());
// Output: [Alice Adams, John Doe, John Smith]
```

**52. Print the count of a particular substring**
```java
List<String> logs = Arrays.asList(
    "ERROR: Disk full",
    "INFO: Operation completed",
    "ERROR: File not found",
    "WARN: Connection slow"
);
String searchTerm = "ERROR";

long count = logs.stream()
                .filter(log -> log.contains(searchTerm))
                .count();
// Output: 2
```

**53. Find the department with maximum people**
```java
List<Employee> employees = Arrays.asList(
    new Employee("John", "IT"),
    new Employee("Jane", "HR"),
    new Employee("Jack", "IT"),
    new Employee("Jill", "Finance")
);

String maxDept = employees.stream()
                         .collect(Collectors.groupingBy(Employee::getDepartment, Collectors.counting()))
                         .entrySet().stream()
                         .max(Map.Entry.comparingByValue())
                         .map(Map.Entry::getKey)
                         .orElse("");
// Output: IT
```

**54. Find the average salary from each department**
```java
List<Employee> employees = Arrays.asList(
    new Employee("John", "IT", 60000),
    new Employee("Jane", "IT", 65000),
    new Employee("Jack", "HR", 55000),
    new Employee("Jill", "HR", 50000)
);

Map<String, Double> avgSalaries = employees.stream()
                                          .collect(Collectors.groupingBy(Employee::getDepartment, 
                                                   Collectors.averagingDouble(Employee::getSalary)));
// Output: {IT=62500.0, HR=52500.0}
```

**55. Reorder message in chronological order**
```java
List<String> logMessages = Arrays.asList(
    "2023-11-10: Event C",
    "2023-11-09: Event B",
    "2023-11-08: Event A"
);

List<String> chronological = logMessages.stream()
                                       .sorted()
                                       .collect(Collectors.toList());
// Output: [2023-11-08: Event A, 2023-11-09: Event B, 2023-11-10: Event C]
```

**56. Return character with maximum frequency**
```java
String str = "aabbbccdeefff";
Character maxChar = str.chars()
                      .mapToObj(c -> (char) c)
                      .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()))
                      .entrySet().stream()
                      .max(Map.Entry.comparingByValue())
                      .map(Map.Entry::getKey)
                      .orElse(null);
// Output: 'b'
```

**57. Convert list of string into map with string length**
```java
List<String> words = Arrays.asList("Java", "Stream", "API");
Map<String, Integer> result = words.stream()
                                  .collect(Collectors.toMap(Function.identity(), String::length));
// Output: {Java=4, Stream=6, API=3}
```

**58. Transform Employee to EmployeeDTO**
```java
List<Employee> employees = Arrays.asList(
    new Employee("John", "IT", 60000),
    new Employee("Jane", "HR", 55000)
);

List<EmployeeDTO> dtos = employees.stream()
                                 .map(emp -> new EmployeeDTO(emp.getName(), emp.getDepartment()))
                                 .collect(Collectors.toList());
// Output: [EmployeeDTO{name='John', department='IT'}, EmployeeDTO{name='Jane', department='HR'}]
```

**59. Find the employee with the highest salary**
```java
List<Employee> employees = Arrays.asList(
    new Employee("John", 60000),
    new Employee("Jane", 75000),
    new Employee("Jack", 55000)
);

Employee maxSalaryEmployee = employees.stream()
                                     .max(Comparator.comparingDouble(Employee::getSalary))
                                     .orElse(null);
// Output: Employee{name='Jane', salary=75000}
```