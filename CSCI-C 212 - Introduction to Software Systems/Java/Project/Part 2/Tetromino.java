import java.awt.*; 
import java.util.*; 

public abstract class Tetromino extends ArrayList<Block> {
  protected int x, y; 
  protected int direction; // will take values 0, 1, 2, 3
  public Tetromino(int x, int y) {
    super(); // since I am in fact an ArrayList of Blocks
    this.x = x; 
    this.y = y; 
  }
  public void draw(Graphics g) {
    for (Block b : this)
      b.draw(g); 
  }
  public void moveLeft() {
    this.x -= Block.SIZE;  
    for (Block b : this) b.moveLeft(); 
  }
    public void moveRight() {
    this.x += Block.SIZE; 
    for (Block b : this) b.moveRight(); 
  }
  public void moveUp() {
    this.y -= Block.SIZE;  
    for (Block b : this) b.moveUp(); 
  } 
  public void moveDown() {
    this.y += Block.SIZE;  
    for (Block b : this) b.moveDown();
    System.out.println("this.y = " + this.y);
    System.out.println("this.x = " + this.x);
  }
  public abstract void rotate(); 
}