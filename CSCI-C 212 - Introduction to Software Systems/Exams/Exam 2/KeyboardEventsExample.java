import java.awt.event.KeyListener; 
import java.awt.event.KeyEvent;

public class KeyboardEventsExample implements KeyListener {
  public void keyPressed(KeyEvent e){ 
    System.out.println("Ouch: " + e); 
  }  
  public void keyReleased(KeyEvent e) { }
  public void keyTyped(KeyEvent e) { }
}