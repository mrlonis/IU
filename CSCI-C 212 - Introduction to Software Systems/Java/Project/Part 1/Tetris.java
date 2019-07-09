import java.awt.Graphics;
import javax.swing.JFrame;

public class Tetris implements World {
  int count = 0; 
  public void update() {
    this.count += 1; 
    System.out.println("I am getting older... " + count + " timer counts old"); 
  }
  public boolean hasEnded() {
    return false;   
  }
  public void draw(Graphics g) {
    g.drawString("Welcome to Tetris!", 50, 50);
    g.drawString("Count is: " + this.count, 50, 100);
  }
  public void keyPressed(String what) {
    this.count -= 10;;
  }
  public static void main(String[] args) {
    JFrame j = new JFrame();
    j.setVisible(true);
    j.setSize(200, 500);
    
     BigBang a = new BigBang(new Tetris()); 
     a.start();
     
     j.addKeyListener(a);
     j.getContentPane().add(a);
  }
}