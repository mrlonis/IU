import java.util.Scanner;

class Student {
  public String name = "";
  public int age = 0;
  
  public Student (String name1, int years) {
    age = years;
    name = name1;
  }
  
  public void report () {
    System.out.println("Hi, my name is " + name + ". I am " + age + " years old."); 
  }
  
  public static void main(String[] args) {
    Student newStudent1 = new Student("Laura", 12);
    newStudent1.report();
    
    Scanner in = new Scanner(System.in);
    
    int inputAge;
    String inputName;
    
    System.out.print("Please enter your age: ");
    inputAge = in.nextInt();
    
    System.out.print("Please enter your name: ");
    inputName = in.next();
    
    Student newStudentInput = new Student(inputName, inputAge);
    System.out.println("Here's your report based on what you input: ");
    newStudentInput.report();
    
    in.close();
  }
}