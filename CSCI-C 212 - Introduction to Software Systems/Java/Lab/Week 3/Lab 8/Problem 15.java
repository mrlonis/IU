/*
You attempt to compile and run this code:

class Vegetable { } 
class Cabbage extends Vegetable { }
class Kohlrabi extends Cabbage { } 
class Kroger {
  public static void main(String[] args) {
    Cabbage a = new Kohlrabi(); 
  }
}

What is the outcome?

- Compiles but prints Static Error: This class does not have a static void main method accepting String[]. when run
*/

class Vegetable { } 
class Cabbage extends Vegetable { }
class Kohlrabi extends Cabbage { } 
class Kroger {
  public static void main(String[] args) {
    Cabbage a = new Kohlrabi(); 
  }
}