import java.awt.*; 

class T extends Tetromino {
  
  final int[][][] shape = 
  {
    { { 0, 1, 0 },
      { 1, 1, 1 },
      { 0, 0, 0 }
    },
    { { 0, 1, 0 },
      { 0, 1, 1 },
      { 0, 1, 0 }
    },
    { { 0, 0, 0 },
      { 1, 1, 1 },
      { 0, 1, 0 }
    },
    { { 0, 1, 0 },
      { 1, 1, 0 },
      { 0, 1, 0 }
    }, 
        
  }; 
  
  public void draw(Graphics g) {
    g.setColor(Red);
    g.fillRect(this.x, this.y, this.w, this.h);
    g.setColor(Black);
    g.makeRect(this.x, this.y, this.w, this.h);
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
  }
  
  public void rotate() { 
  }
  
  public T(int x, int y) {
    super();
    this.x = x; 
    this.y = y;             
  }
}
