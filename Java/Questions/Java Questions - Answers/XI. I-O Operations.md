**151. What is the difference between `System.out`, `System.err`, and `System.in`?**

- `System.out`: Standard output stream used to print normal messages to the console.
    
- `System.err`: Standard error stream used to print error messages (usually in red).
    
- `System.in`: Standard input stream used to read user input (keyboard input).  
    Example:
    

```java
System.out.println("Hello");
System.err.println("Error!");
Scanner sc = new Scanner(System.in);
```

---

**152. What do you understand by an IO stream?**  
An I/O stream in Java represents a sequence of data that flows either **into** or **out of** a program.

- **Input Stream:** Reads data (e.g., from keyboard or file).
    
- **Output Stream:** Writes data (e.g., to file or console).  
    Java provides byte streams (`InputStream`, `OutputStream`) and character streams (`Reader`, `Writer`).
    

---

**153. What is the difference between Reader/Writer and InputStream/OutputStream?**

|Type|Data Type|Base Class|Usage|
|---|---|---|---|
|InputStream / OutputStream|Binary (bytes)|`InputStream`, `OutputStream`|Used for images, videos, etc.|
|Reader / Writer|Text (characters)|`Reader`, `Writer`|Used for text data like `.txt`, `.csv`|

Example:

```java
FileInputStream fin = new FileInputStream("file.bin");
FileReader fr = new FileReader("file.txt");
```

---

**154. What are FileInputStream and FileOutputStream?**

- `FileInputStream`: Reads data from a file in bytes.
    
- `FileOutputStream`: Writes data to a file in bytes.  
    Example:
    

```java
FileInputStream fin = new FileInputStream("data.txt");
FileOutputStream fout = new FileOutputStream("copy.txt");
```

---

**155. What is the purpose of using BufferedInputStream and BufferedOutputStream?**  
They add buffering to improve performance during file operations. Instead of reading/writing one byte at a time, they use a **buffer** (temporary storage).  
Example:

```java
BufferedInputStream bis = new BufferedInputStream(new FileInputStream("a.txt"));
BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream("b.txt"));
```

---

**156. What are FilterStreams?**  
Filter streams **modify or filter data** being read/written through other streams. They are wrappers around existing streams.  
Example:

- `DataInputStream`, `DataOutputStream` (for primitive data types)
    
- `BufferedInputStream`, `BufferedOutputStream` (for buffering)
    

```java
DataInputStream dis = new DataInputStream(new FileInputStream("data.bin"));
```

---

**157. How many ways can you take input from the console?**

1. `Scanner` class (most common):
    
    ```java
    Scanner sc = new Scanner(System.in);
    ```
    
2. `BufferedReader` + `InputStreamReader`:
    
    ```java
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    ```
    
3. `Console` class:
    
    ```java
    String input = System.console().readLine();
    ```
    

---

**158. Difference in the use of `print`, `println`, and `printf`.**

|Method|Function|Example|
|---|---|---|
|`print()`|Prints text without newline|`System.out.print("Hi");`|
|`println()`|Prints text with newline|`System.out.println("Hi");`|
|`printf()`|Prints formatted text|`System.out.printf("Name: %s, Age: %d", "Tom", 25);`|