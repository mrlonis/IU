import java.awt.*; 
import java.util.*; 

public abstract class Tetromino extends ArrayList<Block> {
  int x, y; 
  
  public Tetromino(int x, int y) {
    this.x = x; 
    this.y = y; 
  }
  
  public void draw(Graphics g) { 
  }
  
  public void moveLeft() {
    this.x -= Block.SIZE;  
  }
    public void moveRight() {
    this.x += Block.SIZE;  
  }
  public void moveUp() {
    this.y -= Block.SIZE;  
  } 
  public void moveDown() {
    this.y += Block.SIZE;  
  }

  public void rotate(); 
}