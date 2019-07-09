import java.awt.*; 

public class Block {
  public boolean overlaps(Block t) {
    return 
      Math.max(this.x, t.x) < Math.min(this.x + Block.SIZE, t.x + Block.SIZE) 
      && Math.max(this.y, t.y) < Math.min(this.y + Block.SIZE, t.y + Block.SIZE); 
  }
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
  public String toString() { return "(" + this.x + ", " + this.x + ")" ; }
  public void draw(Graphics g) {
    g.setColor(this.c); 
    g.fillRect(this.x, this.y, this.w, this.h); 
    g.setColor(Color.BLACK); 
    g.drawRect(this.x, this.y, this.w, this.h); 
  }
  public Block moveLeft( ) { // this.x -= Block.SIZE; } 
    return new Block(this.x - Block.SIZE, this.y, this.c); }
  public Block moveRight() { // this.x += Block.SIZE; } 
      return new Block(this.x + Block.SIZE, this.y, this.c); }
  public Block moveUp(   ) { // this.y -= Block.SIZE; } 
    return new Block(this.x, this.y - Block.SIZE, this.c); }
  public Block moveDown( ) { // this.y += Block.SIZE; } 
    return new Block(this.x, this.y + Block.SIZE, this.c); }
}