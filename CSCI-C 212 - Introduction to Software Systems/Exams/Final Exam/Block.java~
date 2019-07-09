import java.awt.*; 

public class Block {

  final static int SIZE = 20; 
  
  private int x, y, w, h;
  private Color c; 
  public Block(int x, int y, Color c) {
    this.x = x;    
    this.y = y;    
    this.w = Block.SIZE;    
    this.h = Block.SIZE;    
    this.c = c;    
  }
  public void draw(Graphics g) {
    g.setColor(this.c); 
    g.fillRect(this.x, this.y, this.w, this.h); 
    g.setColor(Color.BLACK); 
    g.drawRect(this.x, this.y, this.w, this.h); 
  }
  public void moveLeft( ) { this.x -= Block.SIZE; } 
  public void moveRight() { this.x += Block.SIZE; } 
  public void moveUp(   ) { this.y -= Block.SIZE; } 
  public void moveDown( ) { this.y += Block.SIZE; } 
}
