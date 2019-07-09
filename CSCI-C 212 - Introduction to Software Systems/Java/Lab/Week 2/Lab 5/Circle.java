import java.util.Scanner;

public class Circle {
  static double distance;
  
  static void overlaps(double X1, double Y1, double X2, double Y2) {
    double distance = Math.pow((X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2), 0.5);
  }
  
  public static void main(String[] args){
    Scanner input = new Scanner(System.in);
    
    System.out.print("Enter Circle 1 x-coordinate: ");
    double X1 = input.nextDouble();
    System.out.print("Enter Circle 1 y-coordinate: ");
    double Y1 = input.nextDouble();
    System.out.print("Enter Circle 1 radius: ");
    double radius1 = input.nextDouble();
    
    System.out.print("Enter Circle 2 x-coordinate: ");
    double X2 = input.nextDouble();
    System.out.print("Enter Circle 2 y-coordinate: ");
    double Y2 = input.nextDouble();
    System.out.print("Enter Circle 2 radius: ");
    double radius2 = input.nextDouble(); 
    
    overlaps (X1, Y1, X2, Y2);
    
    if (radius2 >= radius1 && distance <= (radius2 - radius1)){
      System.out.println("Circle 1 is inside Circle 2.");
    }
    else if (radius1 >= radius2 && distance <= (radius1 - radius2) ) {
      System.out.println("Circle 2 is inside Circle 1.");
    }
    else if (distance > (radius1 + radius2)){
      System.out.println("Circle 2 does not overlap Circle 1.");
    }
    else {
      System.out.println("Circle 2 overlaps Circle 1.");
    }
    
    input.close();
  }
}