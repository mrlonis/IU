public class Student {
  private String name; 
  private int age; 
  public String toString() {
    return "Hi, my name is " + this.name + ". " + 
           "I am " + this.age + " years old." ;  
  }
  public Student(String name, int age) { 
    this.name = name; 
    this.age = age; 
  } 
  public static void main(String[] args) {
    Student a = new Student("Laura", 12), 
            b = new Student("Leslie", 9); 
    System.out.println( a ); 
    System.out.println( b ); 
  }
} 
