import java.util.Scanner; 

class Gallons {
  public static void main(String[] args) {
    Scanner s = new Scanner(System.in);
    System.out.print("How many gallons does your car tank hold? "); 
    Double gallons = s.nextDouble();
    System.out.print("What is the fuel efficiency in miles per gallon? "); 
    Double mpg = s.nextDouble();
    System.out.print("What is cost per gallon of gas? "); 
    Double cost = s.nextDouble();
    System.out.println("The cost per 100 miles is " + ((100/mpg) * cost) + " and the car can travel " + (gallons * mpg) + " miles per tank!");
  }
}