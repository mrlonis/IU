import javax.swing.JFrame;

public class KeyboardEventConnector extends JFrame {
  public KeyboardEventConnector() {
    super(); 
    this.setVisible(true);   
    this.setSize(200, 400); 
  }
  public static void main(String[] args) {
    JFrame a = new KeyboardEventConnector();  
    // System.out.println( a ); 
    a.addKeyListener( new KeyboardEventsExample1() ); //Again only has the 1 on the end because of confliciting files
  }
}