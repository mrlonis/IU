class Two {
  public static void main(String[] args) {
    System.out.println(1); // this is a Java comment
    System.out.println(1 + 1); // everything to the end of this line is ignored by the compiler
    System.out.println(2 * 3); // I sometimes color comments to make them more visible in notes
    System.out.println(1 + 2 * 3); // there's no need for them to be colored though, of course
    System.out.println(2 * 3 + 1); 
    System.out.println(2 * (3 + 1));                     // comments can facilitate reading the code
    System.out.println(2 / 3);                           // this expression evaluates to 0 and not to 0.66
    System.out.println(3.14);                            // you see the difference between an integer and a floating-point number
    System.out.println(2.0);                             // this is how you'd write an integer as a floating point number
    System.out.println(2.0 / 3.0);                       // now this does evaluate to 0.66 as expected
    System.out.println(4 * 2 / 3); 
    System.out.println(4.0 * 2.0 / 3.0); 
    System.out.println(2 / 3 * 4);                // careful with the order of operations!
    System.out.println(2.0 / 3.0 * 4.0); 
    System.out.println(1 - 2 + 3); 
    System.out.println(1 - (2 + 3)); 
    
    /* here's another type of comment, the one that cannot be nested (see p. 40 in the book) 
     but that can span several lines; the two examples above demonstrate how important it is
     to know the order of operations and how parentheses change it. 1 - 2 + 3 is evaluated left
     to right since + and - have the same precedence (priority). Thus 1 - 2 + 3 = (1 - 2) + 3 = 
     = -1 + 3 = 2 while 1 - (2 + 3) is 1 - 5 which in turns evaluates to -4. Same for 1 - 2 * 3
     which evaluates to -5 since * and / have (same) higher precedence than + and -. 
     
     If you have trouble reading a comment in lightgrey you can always highlight it with your mouse. */ 
    

    System.out.println(1 + 2 - 3); // Prints 0
    System.out.println(1 + (2 - 3)); // Prints 0
    System.out.println(7 % 3); // Prints 1
    System.out.println(4 % 5); // Prints 4
    System.out.println(1 < 2); // Prints True
    System.out.println(1 > 2); // Prints False
    System.out.println(1 == 2); // Prints False
    System.out.println(2 == 2); // Prints True
    System.out.println(2 <= 2); // Prints True
    System.out.println(2 >= 2); // Prints True
    System.out.println("Larry" + "Bird"); // wow: strings being concatenated!
    System.out.println("a" + "1"); // Prints "a1"
    System.out.println("a" + 1); // Prints "a1"
    System.out.println("1" + "1"); // Prints "11"
    System.out.println("1" + 1); // Prints "1"1
    System.out.println(1 + 1); // Prints 2
    System.out.println("1" + (1 + 1)); // Prints "1"2
  }
}