### Questions

Got it! Here are the questions with their outputs:

---

1. **Sum of even numbers**:  
   Given the list:  
   ```java
   List<Integer> numbers1 = Arrays.asList(10, 15, 20, 25, 30, 35, 40);
   ```  
   **Output**:  
   ```java
   100
   ```

---

2. **Words starting with "a" and converting to uppercase**:  
   Given the list:  
   ```java
   List<String> words1 = Arrays.asList("apple", "banana", "apricot", "blueberry", "cherry", "avocado");
   ```  
   **Output**:  
   ```java
   [APPLE, APRICOT, AVOCADO]
   ```

---

3. **Longest word in a list**:  
   Given the list:  
   ```java
   List<String> words2 = Arrays.asList("elephant", "cat", "giraffe", "hippopotamus", "dog", "antelope");
   ```  
   **Output**:  
   ```java
   hippopotamus
   ```

---

4. **Grouping even and odd numbers**:  
   Given the list:  
   ```java
   List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   ```  
   **Output**:  
   ```java
   {false=[1, 3, 5, 7, 9], true=[2, 4, 6, 8, 10]}
   ```

---

5. **Distinct and sorted words in uppercase**:  
   Given the list:  
   ```java
   List<String> words3 = Arrays.asList("banana", "apple", "orange", "banana", "pear", "apple", "grape");
   ```  
   **Output**:  
   ```java
   [APPLE, BANANA, GRAPE, ORANGE, PEAR]
   ```

---

6. **Average word length**:  
   Given the list:  
   ```java
   List<String> words4 = Arrays.asList("apple", "banana", "cherry", "date", "elderberry");
   ```  
   **Output**:  
   ```java
   6.0
   ```

---

7. **Character frequency in a string**:  
   Given the string:  
   ```java
   String str = "apple";
   ```  
   **Output**:  
   ```java
   {a=1, p=2, l=1, e=1}
   ```

---

8. **Character frequency in a concatenated string**:  
    Given the list:  
    ```java
    List<String> words5 = Arrays.asList("abc", "def");
    ```  
    **Output**:  
    ```java
    {a=1, b=1, c=1, d=1, e=1, f=1}
    ```
   
### Answers

---

1. **Sum of even numbers**:  
   Given the list:  
   ```java
   List<Integer> numbers1 = Arrays.asList(10, 15, 20, 25, 30, 35, 40);
   ```  
   **Answer**:  
   ```java
   numbers1.stream()
           .filter(t -> t % 2 == 0)
           .reduce((t, u) -> t + u)
           .get();
   ```  
   **Explanation**: This stream filters the even numbers using `.filter(t -> t % 2 == 0)` and then reduces them by summing them with `.reduce((t, u) -> t + u)`.

---

2. **Words starting with "a" and converting to uppercase**:  
   Given the list:  
   ```java
   List<String> words1 = Arrays.asList("apple", "banana", "apricot", "blueberry", "cherry", "avocado");
   ```  
   **Answer**:  
   ```java
   words1.stream()
         .filter(t -> t.startsWith("a"))
         .map(t -> t.toUpperCase())
         .toList();
   ```  
   **Explanation**: This stream filters the words that start with "a" using `.filter(t -> t.startsWith("a"))` and then converts them to uppercase using `.map(t -> t.toUpperCase())`.

---

3. **Longest word in a list**:  
   Given the list:  
   ```java
   List<String> words2 = Arrays.asList("elephant", "cat", "giraffe", "hippopotamus", "dog", "antelope");
   ```  
   **Answer**:  
   ```java
   words2.stream()
         .reduce((t, u) -> t.length() > u.length() ? t : u)
         .get();
   ```  
   **Explanation**: The `.reduce((t, u) -> t.length() > u.length() ? t : u)` compares the lengths of the words and returns the longest word.

---

4. **Grouping even and odd numbers**:  
   Given the list:  
   ```java
   List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   ```  
   **Answer**:  
   ```java
   numbers.stream()
          .collect(Collectors.groupingBy(t -> t % 2 == 0));
   ```  
   **Explanation**: The `.collect(Collectors.groupingBy(t -> t % 2 == 0))` groups the numbers by whether they are even or odd, with `true` for even numbers and `false` for odd numbers.

---

5. **Distinct and sorted words in uppercase**:  
   Given the list:  
   ```java
   List<String> words3 = Arrays.asList("banana", "apple", "orange", "banana", "pear", "apple", "grape");
   ```  
   **Answer**:  
   ```java
   words3.stream()
         .distinct()
         .sorted()
         .map(t -> t.toUpperCase())
         .toList();
   ```  
   **Explanation**: The stream first removes duplicates with `.distinct()`, then sorts the words with `.sorted()`, and finally converts each word to uppercase with `.map(t -> t.toUpperCase())`.

---

6. **Average word length**:  
   Given the list:  
   ```java
   List<String> words4 = Arrays.asList("apple", "banana", "cherry", "date", "elderberry");
   ```  
   **Answer**:  
   ```java
   words4.stream()
         .mapToInt(String::length)
         .average()
         .orElse(-1);
   ```  
   **Explanation**: The `.mapToInt(String::length)` converts each word to its length, and `.average()` computes the average length. If the list is empty, `-1` is returned.

---

7. **Character frequency in a string**:  
   Given the string:  
   ```java
   String str = "apple";
   ```  
   **Answer**:  
   ```java
   str.chars()
      .boxed()
      .map(t -> (char) t.intValue())
      .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
   ```  
   **Explanation**: The `str.chars()` converts the string into a stream of integers representing the character codes. `.boxed()` converts them to `Integer`, and `.map(t -> (char) t.intValue())` converts them to characters. The `.collect(Collectors.groupingBy(Function.identity(), Collectors.counting()))` counts the occurrences of each character.

---

8. **Character frequency in a concatenated string**:  
   Given the list:  
   ```java
   List<String> words5 = Arrays.asList("abc", "def");
   ```  
   **Answer**:  
   ```java
   words5.stream()
         .collect(Collectors.joining())
         .chars()
         .boxed()
         .map(t -> (char) t.intValue())
         .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
   ```  
   **Explanation**: The `.collect(Collectors.joining())` concatenates all the words into a single string, and the subsequent steps are similar to the previous one, where characters are counted in the concatenated string.