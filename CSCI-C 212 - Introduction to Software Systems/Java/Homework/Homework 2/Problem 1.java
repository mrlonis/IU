import java.util.Scanner;

class HomeworkTwo1 {
  public static void main(String[] args) {
    Scanner s = new Scanner(System.in);
    System.out.print("Enter letter grade: "); 
    String letter = s.nextLine();
    
    double grade;
    
    if (letter.equals("A+")) {
      grade = 4.0;
      System.out.println(grade);
    } else if (letter.equals("A")) {
      grade = 4.0;
      System.out.println(grade);
    } else if (letter.equals("A-")) {
      grade = 3.7;
      System.out.println(grade);
    } else if (letter.equals("B+")) {
      grade = 3.3;
      System.out.println(grade);
    } else if (letter.equals("B")) {
      grade = 3.0;
      System.out.println(grade);
    } else if (letter.equals("B-")) {
      grade = 2.7;
      System.out.println(grade);
    } else if (letter.equals("C+")) {
      grade = 2.3;
      System.out.println(grade);
    } else if (letter.equals("C")) {
      grade = 2.0;
      System.out.println(grade);
    } else if (letter.equals("C-")) {
      grade = 1.7;
      System.out.println(grade);
    } else if (letter.equals("D+")) {
      grade = 1.3;
      System.out.println(grade);
    } else if (letter.equals("D")) {
      grade = 1.0;
      System.out.println(grade);
    } else if (letter.equals("D-")) {
      grade = 0.7;
      System.out.println(grade);
    } else if (letter.equals("F")) {
      grade = 0.0;
      System.out.println(grade);
    } else {
    }
    s.close();
  }
}