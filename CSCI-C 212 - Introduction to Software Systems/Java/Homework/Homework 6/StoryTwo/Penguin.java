public class Penguin extends Bird {
  public void fly () { 
    System.out.println("I cannot fly as a Penguin");
  }
  
  public void swim () {
    System.out.println("I can swim as a Penguin");
  }
  
  public void deep_dive () { 
    System.out.println("I can deep dive as a Penguin");
  }
  
  public void talk() { 
    System.out.println("I cannot talk as a Penguin");
  }
  
  public String toString() {
    super.toString();
    return " -- all of this comes from a Penguin\n";
  }
}