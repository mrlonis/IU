import java.awt.*; 
import javax.swing.*;

public class Tetris implements World {
  Tetromino current;
  
  public Tetris() {
    super(); 
    this.current = new T (250, 0); 
  }
  
  // Returns a random integer between min (included) and max (included)
  // Using Math.round() will give you a non-uniform distribution!
  public void newPiece(int min, int max) {
    int pieceChoice = (int) Math.floor(Math.random() * (max - min + 1)) + min;
    if (pieceChoice == 1) {
      this.current = new Z (20, 50);
    } else if (pieceChoice == 2) {
      this.current = new T (20, 50);
    } else if (pieceChoice == 3) {
      this.current = new S (20, 50);
    } else if (pieceChoice == 4) {
      this.current = new O (20, 50);
    } else if (pieceChoice == 5) {
      this.current = new L (20, 50);
    } else if (pieceChoice == 6) {
      this.current = new J (20, 50);
    } else if (pieceChoice == 7) {
      this.current = new I (20, 50);
    } else {
    }
  }
  
  public boolean hasEnded() {
    return false; 
  } 
  
  public void draw(Graphics g) { 
    this.current.draw(g); 
  }
  
  private int count;
  
  public void update() { 
    this.count += 1;
    this.keh("down");
    System.out.println( count );
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
      
    }
  }
  
  public static void main(String[] args) {
    JFrame a = new JFrame(); 
    a.setSize(500, 500); 
    a.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    BigBang b = new BigBang( new Tetris() );
    a.addKeyListener( b ); 
    a.getContentPane().add( b );
    a.setVisible(true);
    b.start(); 
  }
  
}