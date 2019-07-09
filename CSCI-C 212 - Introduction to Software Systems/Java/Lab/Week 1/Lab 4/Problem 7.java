/*
Consider the following program:
class Eleventy
{
  public static void main(String[] args)
  {
    int count = 10;
    for (count = count - 1; (count > 0); count = count + 1)
    {
      System.out.println(count);
      count = count - 2;
    }
  }
}
It's almost identical to the one before it (just one character is missing).
What does it do when you compile it and run it?

It counts down from 9 all the way to 1
*/

class Eleventy
{
  public static void main(String[] args)
  {
    int count = 10;
    for (count = count - 1; (count > 0); count = count + 1)
    {
      System.out.println(count);
      count = count - 2;
    }
  }
}