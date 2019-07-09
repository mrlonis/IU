/*Write a program that demonstrates event handling:

Original:

import java.awt.*

public class KeyboardEventsExample implements KeyListener {
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
*/

/*Below is the correct implementation of this:*/

import java.awt.event.*; //Had to add .event and a ;

public class KeyboardEventsExample1 implements KeyListener { //This is only called ...Example1 due to already have a LeyboardEventsExample class
  public void keyPressed(KeyEvent e){ 
    System.out.println("You pressed: " + e); 
  }  
  public void keyReleased(KeyEvent e) { 
  System.out.println("You released: " + e);
  }
  public void keyTyped(KeyEvent e) { }
}

/*I also need to connect this to a main fucntion outside of this class to use it. I forgot this. Here is a connector:

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

*/

/*Since i forgot the correct import name and did not connect this to a main i feel i deserve 0.5/1 however due to my original KeyEventExample being
 * fairly close accurate and with a main i feel i could argue a 0.6/1 for this problem*/
