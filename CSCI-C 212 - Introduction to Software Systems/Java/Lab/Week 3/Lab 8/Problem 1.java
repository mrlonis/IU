/*
You attempt to compile and run this code:

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta();
  }
  Alpha(int i) {  }
}
class Beta extends Alpha { }

What is the outcome?

Possible answers:

(a) The code does not compile because Beta does not define a no-args constructor. 
(b) The code does not compile because Beta does not define any constructors whatsoever. 
(c) The code compiles and runs succesfully, with no output. 
(d) The code does not compile because Alpha doesn't define a no-args constructor. 
(e) None of the above.

- Option d
*/

class Alpha {
  public static void main(String[] args) {
    Beta f = new Beta();
  }
  Alpha(int i) {  }
}
class Beta extends Alpha { }