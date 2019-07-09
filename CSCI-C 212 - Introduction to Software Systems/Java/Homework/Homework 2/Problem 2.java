import java.util.Scanner;

class HomeworkTwo2 {
  public static void main(String[] args) {
    Scanner s = new Scanner(System.in);
    System.out.print("Enter number: "); 
    Double grade = s.nextDouble();
    
    if (grade > 4.0) {
      System.out.println("Number too big.");
    } else if (grade > 3.8) {
      System.out.println("A");
    } else if (grade > 3.4) {
      System.out.println("A-");
    } else if (grade > 3.0) {
      System.out.println("B+");
    } else if (grade > 2.8) {
      System.out.println("B");
    } else if (grade > 2.4) {
      System.out.println("B-");
    } else if (grade > 2.0) {
      System.out.println("C+");
    } else if (grade > 1.8) {
      System.out.println("C");
    } else if (grade > 1.4) {
      System.out.println("C-");
    } else if (grade > 1.0) {
      System.out.println("D+");
    } else if (grade > 0.8) {
      System.out.println("D");
    } else if (grade > 0.0) {
      System.out.println("D-");
    } else if (grade == 0) {
      System.out.println("F");
    } else if (grade < 0) {
      System.out.println("Input too small");
    } else {
      System.out.println("Invalid input");
    }
    s.close();
  }
}