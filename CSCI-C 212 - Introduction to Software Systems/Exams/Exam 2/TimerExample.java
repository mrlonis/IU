import javax.swing.Timer; 

public class TimerExample {
  public static void main(String[] args) {
    Umpire a = new Umpire(); // instantiate the class create an object 
    Timer t = new Timer(1000, a); 
    t.start(); 
  }
}