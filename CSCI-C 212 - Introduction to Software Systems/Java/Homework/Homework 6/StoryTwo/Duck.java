public class Duck extends Bird {
  public void fly () { 
    System.out.println("I can fly as a Duck");
  }
  
  public void swim () {
    System.out.println("I can swim as a Duck");
  }
  
  public void deep_dive () { 
    System.out.println("I cannot deep dive as a Duck");
  }
  
  public void talk() { 
    System.out.println("I cannot talk as a Duck");
  }
  
  public String toString() {
    super.toString();
    return " -- all of this comes from a Duck\n";
  }
}