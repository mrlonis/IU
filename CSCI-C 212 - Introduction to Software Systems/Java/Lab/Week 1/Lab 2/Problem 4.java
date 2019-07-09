/*
Assume you don't know yet how to program decisions yet (if statements).
It turns out that there is a way to fake them using substring.

Write a program that asks a user to input

The number of gallons of gas in the tank
The fuel efficiency in miles per gallon
The distance the user wants to travel
Then print out

You will make it
or
You will not make it
*/

import java.util.Scanner; 

class Problem_4 {
  public static void main(String[] args) {
    Scanner s = new Scanner(System.in);
    System.out.print("How many gallons does your car tank hold? "); 
    Double gallons = s.nextDouble();
    System.out.print("What is the fuel efficiency in miles per gallon? "); 
    Double mpg = s.nextDouble();
    System.out.print("How far do you want to travel? "); 
    Double miles = s.nextDouble();
    
    boolean confirm;
    confirm = true;
    
    if (confirm == ((gallons * mpg) >= miles)) {
      System.out.println("You will make it.");
    } else {
      System.out.println("You will not make it.");
    }
  }
}