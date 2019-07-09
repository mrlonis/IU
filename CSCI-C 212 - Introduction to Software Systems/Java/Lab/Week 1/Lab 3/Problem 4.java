/*
What is the output of this program and why?
public class Four {
    public static void main(String[] args) {
      boolean p = false, q = false;
      System.out.println( ! p && q );
    }
}

Tnis prints out false because the program takes the ! and applies it to the p making the expression (true && false)
which is false

Would anything change if the program printed ! (p && q) instead?

It would print true still

Why or why not?

(p && q) would be (false && false) which makes a false. but the ! outside the ( ) makes it true

*/

class Four {
    public static void main(String[] args) {
      boolean p = false, q = false;
      System.out.println(!(p && q));
    }
}