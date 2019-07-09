import javax.swing.*;
import java.awt.event.*; 
import java.util.*; 
import java.awt.*;

public class Ripples implements World {
  ArrayList<Circle> circles = new ArrayList<Circle>(); 
  public void update() {
    for (Circle c : this.circles) 
      c.enlarge(); 
  }
  public void draw(Graphics g) {
    for (Circle c : this.circles) 
      c.draw(g); 
  }
  public void mousePressed(MouseEvent e) { 
    int x = e.getX(), y = e.getY(); 
    this.circles.add( new Circle( x, y, 1, Color.RED ) ); 
  } 
  public void keyPressed(KeyEvent e) { }
  public static void main(String[] args) {
    BigBang game = new BigBang(30, new Ripples());  
    JFrame frame = new JFrame("Ripples"); 
    frame.getContentPane().add( game ); 
    game.addMouseListener( game ); 
    frame.setVisible(true); 
    frame.setSize(400, 400); 
    frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE ); 
    game.start(); 
  }
  public boolean hasEnded() {
    return false; // never!! 
  }
}