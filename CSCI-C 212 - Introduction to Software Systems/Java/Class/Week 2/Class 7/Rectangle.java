import java.util.Scanner;

public class Rectangle {
  static double distance;
  
  static void overlaps(double X1, double Y1, double X2, double Y2) {
    double distance = Math.pow((X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2), 0.5);
  }
  
  public static void main(String[] args){
    Scanner input = new Scanner(System.in);
    
    System.out.print("Enter Rectangle 1 x-coordinate: ");
    double X1 = input.nextDouble();
    System.out.print("Enter Rectangle 1 y-coordinate: ");
    double Y1 = input.nextDouble();
    System.out.print("Enter Rectangle 1 length: ");
    double length1 = input.nextDouble();
    length1 = length1/2;
    System.out.print("Enter Rectangle 1 width: ");
    double width1 = input.nextDouble();
    width1 = width1/2;
    
    System.out.print("Enter Rectangle 2 x-coordinate: ");
    double X2 = input.nextDouble();
    System.out.print("Enter Rectangle 2 y-coordinate: ");
    double Y2 = input.nextDouble();
    System.out.print("Enter Rectangle 2 length: ");
    double length2 = input.nextDouble();
    length2 = length2/2;
    System.out.print("Enter Rectangle 2 width: ");
    double width2 = input.nextDouble(); 
    width2 = width2/2;
    
    overlaps (X1, Y1, X2, Y2);
    
    if (length2 >= length1 && distance <= (length2 - length1)){
      System.out.println("Rectangle 1 is inside Rectangle 2.");
    }
    else if (length1 >= length2 && distance <= (length1 - length2) ) {
      System.out.println("Rectangle 2 is inside Rectangle 1.");
    }
    else if (distance > (length1 + length2)){
      System.out.println("Rectangle 2 does not overlap Rectangle 1.");
    }
    else {
      System.out.println("Rectangle 2 overlaps Rectangle 1.");
    }
    
    input.close();
  }
}