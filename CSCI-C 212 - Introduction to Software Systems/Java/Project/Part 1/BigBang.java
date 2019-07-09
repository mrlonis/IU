import java.awt.event.ActionListener; 
import java.awt.event.ActionEvent; 
import javax.swing.Timer;
import javax.swing.JComponent;
import java.awt.Graphics;
import java.awt.event.KeyListener;
import java.awt.event.KeyEvent;

public class BigBang extends JComponent implements ActionListener, KeyListener {
  Timer timer; 
  World world; 
  public BigBang(World world) {
    this.world = world;
    this.timer = new Timer(1000, this); 
  }
  public void start() {
    this.timer.start();  
  }
  public void actionPerformed(ActionEvent e) {
    this.world.update();
    this.repaint();
  }
  public void paintComponent(Graphics g) {
    this.world.draw(g);
  }
  public void keyPressed(KeyEvent e) {
    this.world.keyPressed("whatever");
    this.repaint();
  }
  public void keyReleased(KeyEvent e) {
  }
  public void keyTyped(KeyEvent e) {
  }
}