public class Parrot extends Bird {
  public void fly () { 
    System.out.println("I can fly as a Parrot");
  }
  
  public void swim () {
    System.out.println("I cannot swim as a Parrot");
  }
  
  public void deep_dive () { 
    System.out.println("I cannot deep dive as a Parrot");
  }
  
  public void talk() { 
    System.out.println("I can talk as a Parrot");
  }
  
  public String toString() {
    super.toString();
    return " -- all of this comes from a Parrot\n";
  }
}