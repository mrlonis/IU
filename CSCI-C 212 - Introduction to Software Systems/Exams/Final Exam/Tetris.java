import java.awt.*; 
import javax.swing.*;
import java.util.*;

public class Tetris implements World {
  Tetromino current;
  
  public Tetris() {
    super(); 
    this.current = new T (100, 0); 
  }
  
  public boolean hasEnded() {
    return false; 
  } 
  
  public void draw(Graphics g) { 
    this.current.draw(g); 
  }
  
  public void update() { 
    this.keh("down");
  }
  
  public void keh(String key) { 
    if (key.equals("left")) {
      this.current.moveLeft(); 
    } else if (key.equals("right")) {
      this.current.moveRight(); 
    } else if (key.equals("up")) {
      this.current.moveUp();       
    } else if (key.equals("down")) {
      this.current.moveDown(); 
    } else if (key.equals("rotate")) {
      this.current.rotate(); 
    } else {
      this.current.moveDown();
    }
  }
  
  public static void main(String[] args) {
    JFrame a = new JFrame(); 
    a.setSize(200, 500); 
    BigBang b = new BigBang( new Tetris() );
    a.getContentPane().add( b );
    a.addKeyListener( b ); 
    b.start();
    a.setVisibility(true);
  }
}