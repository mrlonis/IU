/*
Lecture notes 3 contain a program like this:
import java.math.*;

public class Two {
  public static void main(String[] args) {
    BigDecimal a = new BigDecimal("1");
    BigDecimal b = new BigDecimal("2");
    BigDecimal c = new BigDecimal("3");

    System.out.println( c.multiply(a.add(b)) );
  }
}
Compile and run this program. What does it do?

Prints out the number 9

Practice writing expressions with BigDecimals.

Write, compile and run code evaluating the following expressions using BigDecimals:

1 + 2
2 * 3

(1 + (2 + (3 + 4)))

1 + 2 + 3 + 4

2 * 3 + 4 * 5
*/

import java.math.*;

class Two {
  public static void main(String[] args) {
    BigDecimal a = new BigDecimal("1");
    BigDecimal b = new BigDecimal("2");
    BigDecimal c = new BigDecimal("3");
    BigDecimal d = new BigDecimal("4");
    BigDecimal e = new BigDecimal("5");

    System.out.println( c.multiply(a.add(b)) );
    
    System.out.println(a.add(b));
    System.out.println(b.add(c));
    System.out.println(a.add(b.add(c.add(d))));
    System.out.println(a.add(b.add(c.add(d))));
    System.out.println(b.add(c.add(d.add(e))));
  }
}