import javax.swing.JFrame; 
import java.awt.Container;

public class MouseEventsOne extends JFrame {
  public MouseEventsOne() {
    super(); // constructor chaining
    this.setSize(400, 400); // inheritance
    this.setVisible(true); // inheritance
  }
  public static void main(String[] args) {
    JFrame f = new MouseEventsOne(); // polymorphism 
    Container c = f.getContentPane(); // composition 
    c.add(new MouseEventsTwo()); // composition 
  }
} 