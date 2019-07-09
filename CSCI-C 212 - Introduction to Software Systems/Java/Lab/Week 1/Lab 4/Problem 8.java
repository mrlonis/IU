/*
I remove two more characters to obtain:
class Twelve
{
  public static void main(String[] args)
  {
    int count = 10;
    for (count = count - 1; (count > 0); count = count + 1)
      System.out.println(count);
      count = count - 2;
  }
}
What does this program do when you compile and run it?

Creates an infinite loop of numbers that keep counting upwards
*/

class Twelve
{
  public static void main(String[] args)
  {
    int count = 10;
    for (count = count - 1; (count > 0); count = count + 1)
      System.out.println(count);
      count = count - 2;
  }
}