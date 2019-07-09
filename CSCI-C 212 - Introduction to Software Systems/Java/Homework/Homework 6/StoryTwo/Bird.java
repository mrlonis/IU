public abstract class Bird {
  public abstract void fly ();
  public abstract void swim ();
  public abstract void deep_dive ();
  public abstract void talk();
  
  public String toString() {
    this.fly();
    this.swim();
    this.deep_dive();
    this.talk();
    return "";
  }
}