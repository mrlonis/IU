/*
Consider the following code fragment when embedded in a complete program.
if (x > 3) {
 if (x <= 5)
   y = 1;
 else if (x != 6)
   y = 2;
} else
 y = 3;
Assume that x has a value of 6 at the beginning of fragment.
What value does the variable y hold after the fragment gets executed? Why?

y = 3 because (x <= 5) is false and (x != 6) is false, therefore only the else case "y =3" gets executed.

Same question if you remove the curly braces. Explain your answer(s).

I don't understand what is being asked of me
*/

class Problem_7 {
  public static void main(String[] args){
    int x;
    int y;
    x = 6;
    if (x > 3) {
      if (x <= 5) 
        y = 1;
      else if (x != 6)
        y = 2;
    } else 
      y = 3;
  }
}