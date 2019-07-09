import javax.swing.*; 
import java.awt.event.*;
import java.awt.*;
import java.util.*;

class BigBang extends ActionListener implements ActionEvent, 
                                KeyEvent {
  World world; 
  Timer timer;
  
  public BigBang(World w) {
    super();
    this.world = w;     
    this.timer = new Timer(1000);

  }
  
  public void start() {
    this.timer.start();
    update();
  }
  
  public void update() {
    repaint();
  }
  
  public void draw (Graphics g) {
    this.world.draw(g);
  }
  
  public void keyPressed(KeyEvent e) { 
    int code; 
    switch (code) {
      case 37: this.world.keh( "left" ); 
               break;
      case 38: this.world.keh( "right" ); 
               break;
      case 39: this.world.keh( "up" ); 
               break;
      case 40: this.world.keh( "down" ); 
               break;
      case 41: this.world.keh( "rotate" );                    
               break; 
    }
  }
  public void keyReleased(KeyEvent e) { }
  public void keyReleased(KeyEvent e) { }
}
