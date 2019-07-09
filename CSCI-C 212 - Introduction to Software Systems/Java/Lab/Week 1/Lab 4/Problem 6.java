/*
Is this an example of an infinite loop?

- no because in the code, when we get to "! (count > 0)" this will instantly process as "! (9 >0)" which is false so 
the loop never gets going

class Ten
{
  public static void main(String[] args)
  {
    int count = 10;
    for (count = count - 1; ! (count > 0); count = count + 1)
    {
      System.out.println(count);
      count = count - 2;
    }
  }
}
*/

class Ten {
  public static void main(String[] args) {
    int count = 10;
    for (count = count - 1; ! (count > 0); count = count + 1) {
      System.out.println(count);
      count = count - 2;
    }
  }
}