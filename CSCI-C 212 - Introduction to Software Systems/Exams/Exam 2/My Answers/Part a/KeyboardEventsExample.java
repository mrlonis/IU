/*Write a program that demonstrates event handling:

Original:*/

import java.awt.event.KeyListener; 
import java.awt.event.KeyEvent;

public class KeyboardEventsExample1 implements KeyListener {
  public void keyPressed(KeyEvent e){ 
    System.out.println("You pressed: " + e); 
  }  
  public void keyReleased(KeyEvent e) { 
  System.out.println("You released: " + e);
  }
  public void keyTyped(KeyEvent e) { }
  
  public static void main(String[] args) {
    System.out.println("Press any key and see what happens!");
  }
}