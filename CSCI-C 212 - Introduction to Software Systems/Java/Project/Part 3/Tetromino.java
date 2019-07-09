import java.awt.*; 
import java.util.*; 

public abstract class Tetromino extends ArrayList<Block> {
  
  public static Tetromino random() {
    int i = (int)(Math.random() * 7);    
    switch (i) {
      case 0: return new T(20, 50, 1); 
      case 1: return new Z(20, 50, 1); 
      default: 
              return new L(20, 50, 1); 
    }
  }
  
  protected int x, y; 
  protected int direction; // will take values 0, 1, 2, 3
  public Tetromino(int x, int y, int direction) {
    super(); // since I am in fact an ArrayList of Blocks
    this.x = x; 
    this.y = y; 
    this.direction = direction; 
  }
  public void draw(Graphics g) {
    for (Block b : this)
      b.draw(g); 
  }
  public abstract Tetromino moveLeft(); //  {
    // return new Tetromino
    // this.x -= Block.SIZE;  
    // for (Block b : this) b.moveLeft(); 
  // }
  public abstract Tetromino moveRight(); // {
    // this.x += Block.SIZE; 
    // for (Block b : this) b.moveRight(); 
  // }
  public abstract Tetromino moveUp(); // {
    // this.y -= Block.SIZE;  
    // for (Block b : this) b.moveUp(); 
  // } 
  public abstract Tetromino moveDown(); // {
    // this.y += Block.SIZE;  
    // for (Block b : this) b.moveDown(); 
  // }
  public abstract Tetromino rotate(); 
}