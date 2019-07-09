/*
Consider the following two program fragments. Assume that x is an int variable.

// fragment 1                 // fragment 2

if (x == 5)                   if (x == 5)
  x = x + 1;                    x = x + 1; 
else                          if (x != 5)
  x = 8;                        x = 8; 
  
Are these two fragments equivalent? Why or why not?

These two are equivalent because no matter what, in each case if x doesn't equal 5, x will pass both else conditional statements.

Don't forget to include, with your answer(s), evidence that the answer is correct.
*/