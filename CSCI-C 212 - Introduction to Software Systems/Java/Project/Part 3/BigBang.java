import javax.swing.*; 
import java.awt.event.*;
import java.awt.*; 

public class BigBang extends JComponent
                     implements ActionListener, 
                                KeyListener {
  World world; 
  Timer timer; 
  public BigBang(World w) {
    this.world = w;     
    this.timer = new Timer(1000, this);

  }
  public BigBang(int delay, World w) {
    this.world = w;     
    this.timer = new Timer(delay, this);
     
  }
  public void start() {
    this.timer.start();  
  }
  public void keyPressed(KeyEvent e) { 
    int code = e.getKeyCode(); 
    switch (code) {
      case 37: // left 
               this.world.keh( "left" ); 
               break;
      case 38: // up 
               this.world.keh( "up" ); 
               break;
      case 39: // right
               this.world.keh( "right" ); 
               break;
      case 40: // down 
               this.world.keh( "down" ); 
               break;
      case 32: this.world.keh( "rotate" );                    
               break;
      default: // what?!
               this.world.keh( code + "" );                    
               break; 
    }
    this.repaint(); 
  }
  public void keyReleased(KeyEvent e) { }
  public void keyTyped(KeyEvent e) { }
  public void actionPerformed(ActionEvent e) { 
    this.world.update(); 
    this.repaint(); 
  }
  public void paintComponent(Graphics g) {
    this.world.draw(g);  
  }
}