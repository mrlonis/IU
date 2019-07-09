/*
A year with 366 days is called a leap year. A year is a leap year if it is divisible by 4 (for example, the year 1980 
was a leap year), except it is not a leap year if it is divisible by 100 (for example, the year 1900 was not a leap year); 
however, it is a leap year if it is divisible by 400 (for example, the year 2000 was leap year). There were no exceptions 
before the introduction of the Gregorian calendar on Oct 15, 1582 (as an example, the year 1500 was a leap year). Write 
a program that asks the user for a leap year and determines if the year entered by the user is leap or not.

For this you can use this diagram:
*/

import java.util.Scanner; 

class Problem_17 {
  public static void main(String[] args) {
    Scanner s = new Scanner(System.in);
    System.out.print("Enter a year and I will tell you if it is a leap year: "); 
    int year = s.nextInt();
    
    if (year >= 1582) {
    
      if (year % 4 == 0) {
        
        if (year % 100 == 0) {
          
          if (year % 400 == 0) {
            System.out.println(year + " is a leap year.");
          } else {
            System.out.println(year + " is not a leap year.");
          }
          
        } else {
          System.out.println(year + " is a leap year.");
        }
        
      } else {
        System.out.println(year + " is not a leap year.");
      }
      
    } else if (year < 1582) {
      if (year % 4 == 0) {
        System.out.println(year + " is a leap year.");
      }
    }
  }
}