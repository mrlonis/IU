import java.awt.*; 
import javax.swing.*;

public class Tetris implements World {
  public Tetris() {
    super(); 
    this.current = new L( 20, 50, 1 ); // just because now I can 
    this.ground = new Ground(); // this will be side-effected
  }
  Tetromino current; 
  Ground ground; 
  public boolean hasEnded() { 

    return false; 
  } 
  public void draw(Graphics g) { 
    this.current.draw(g); 
    this.ground.draw(g); 
  }
  private int count;
  public void update() { 
    this.count += 1; 
    Tetromino future = this.current.moveDown(); 
    if (this.ground.overlaps( future )) {
      for (Block b : this.current)
        this.ground.add(b); 
      this.current = Tetromino.random();   
    } else {
      this.current = future; 
    }
    System.out.println( count ); 
  }
  public void keh(String key) { 
    if (key.equals("left")) {
      Tetromino future = this.current.moveLeft(); 
      if (this.ground.overlaps( future )) {
        
      } else {
        this.current = future; 
      }
    } else if (key.equals("right")) {
      Tetromino future = this.current.moveRight(); 
      if (this.ground.overlaps( future )) {
        
      } else {
        this.current = future; 
      }
    } else if (key.equals("up")) {
      Tetromino future = this.current.moveUp(); 
      if (this.ground.overlaps( future )) {
        
      } else {
        this.current = future; 
      }
    } else if (key.equals("down")) {
      Tetromino future = this.current.moveDown(); 
      if (this.ground.overlaps( future )) {
        
      } else {
        this.current = future; 
      }
    } else if (key.equals("rotate")) {
      Tetromino future = this.current.rotate(); 
      if (this.ground.overlaps( future )) {
        
      } else {
        this.current = future; 
      }
    } else {
      int code = Integer.parseInt(key); 
      switch (code) {
        case 'L': this.current = new L(this.current.x, 
                                       this.current.y, 
                                       this.current.direction);  
                  break; 
        case 'Z': this.current = new Z(this.current.x, 
                                       this.current.y, 
                                       this.current.direction);  
                  break; 
        case 'T': this.current = new T(this.current.x, 
                                       this.current.y, 
                                       this.current.direction);  
                  break; 
        case 'X': for (Block b : this.current)
                    this.ground.add(b); 
                  this.current = Tetromino.random(); 
                  break; 
        default:  break; 
      }
    }

  }
  public static void main(String[] args) {
    JFrame a = new JFrame(); 
    a.setSize(200, 500);
    a.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    BigBang b = new BigBang( new Tetris() );
    a.addKeyListener( b ); 
    a.getContentPane().add( b ); 
    b.start();
    a.setVisible(true);
  }
}