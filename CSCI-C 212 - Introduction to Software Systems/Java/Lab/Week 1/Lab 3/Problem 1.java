/*
What is the output of this program and why?
public class One {
    public static void main(String[] args) {
 String greeting = "Hello, Bill!"; 
        greeting.toLowerCase(); 
        System.out.println(greeting); 
    } 
} 
Modify just one line in the program to obtain the following output:
hello bill!
*/
class One {
  public static void main(String[] args) {
    String greeting = "Hello, Bill!"; 
    System.out.println(greeting.toLowerCase()); 
  } 
}