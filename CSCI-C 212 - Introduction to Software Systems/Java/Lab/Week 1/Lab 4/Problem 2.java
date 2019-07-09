/*
What is the output of this program and why?\

- output:

4 -> 2+2=4
2 versus 2 -> prints 2 versus 2 
123 -> prints string "123" because of data types
15 -> prints "1"5 (appears as 15)
199 ->
2 

class Whoa {
  public static void main(String[] args) {

    {
      int x, y;
      x = 2; y = 3;
      y = x;
      System.out.println(x + y);
    }

    {
      int x, y;
      x = 2; y = 3;
      y = x;
      System.out.println(x + " versus " + y);
    }

    {
      int x, y;
      x = 2; y = 3;
      System.out.println("1" + x + y);
    }

    {
      int x, y;
      x = 2; y = 3;
      System.out.println("1" + (x + y));
    }

    {
      char a, b, c;
      a = 'B'; b = 'C'; c = a;
      System.out.println(a + c + 'C');
    }

    {
      int a; a = 'C' - 'A';
      System.out.println(a);
    }

  }
}
How does this work?

I'm not sure. I think its because in the last two we aren't specifying for the system to return a string type so its 
return the decimal or whatever value that the variables are holding
*/

class Whoa {
  public static void main(String[] args) {

    {
      int x, y;
      x = 2; y = 3;
      y = x;
      System.out.println(x + y);
    }

    {
      int x, y;
      x = 2; y = 3;
      y = x;
      System.out.println(x + " versus " + y);
    }

    {
      int x, y;
      x = 2; y = 3;
      System.out.println("1" + x + y);
    }

    {
      int x, y;
      x = 2; y = 3;
      System.out.println("1" + (x + y));
    }

    {
      char a, b, c;
      a = 'B'; b = 'C'; c = a;
      System.out.println(a + c + 'C');
    }

    {
      int a; a = 'C' - 'A';
      System.out.println(a);
    }

  }
}

