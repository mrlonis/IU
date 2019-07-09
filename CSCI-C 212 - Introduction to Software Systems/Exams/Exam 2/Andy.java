import javax.swing.JFrame;

public class Andy extends JFrame {
  public Andy() {
    super(); 
    this.setVisible(true);   
    this.setSize(200, 400); 
  }
  public static void main(String[] args) {
    JFrame a = new Andy();  
    // System.out.println( a ); 
    a.addKeyListener( new KeyboardEventsExample() ); 
  }
}