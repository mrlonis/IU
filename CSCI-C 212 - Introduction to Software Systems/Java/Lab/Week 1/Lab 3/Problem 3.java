/*
Assume that p and q are variables of type boolean.
Write a program to prove that:

! (p || q) == !p && !q
Also prove the following equality:
! (p && q) == !p || !q
These are known as DeMorgan's laws.
*/

class Three {
  public static void main(String[] args) {
    boolean p = true;
    boolean q = false;
    
    if (! (p || q) == !p && !q) {
      System.out.println("( ! (p || q) == !p && !q ) is true!");
    } else {
      System.out.println("( ! (p || q) == !p && !q ) is false!");
    }
    
    if (! (p && q) == !p || !q) {
      System.out.println("( ! (p && q) == !p || !q ) is true!");
    } else {
      System.out.println("( ! (p && q) == !p || !q ) is false!");
    }
  }
}