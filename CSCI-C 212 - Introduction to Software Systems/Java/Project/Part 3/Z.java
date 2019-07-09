import java.awt.*; 

public class Z extends Tetromino {
  
  final static int[][][] shape = 
  {
    { { 1, 1, 0 },
      { 0, 1, 1 },
      { 0, 0, 0 }
    }, // index 0 in the shape array 
    { { 0, 0, 1 },
      { 0, 1, 1 },
      { 0, 1, 0 }
    }, // index 0 in the shape array 
    { { 0, 0, 0 },
      { 1, 1, 0 },
      { 0, 1, 1 }
    }, // index 0 in the shape array 
    { { 0, 1, 0 },
      { 1, 1, 0 },
      { 1, 0, 0 }
    }, // index 0 in the shape array 
        
  }; 
  
  public Tetromino moveLeft( ) { return new Z(this.x - Block.SIZE, 
                                              this.y, 
                                              this.direction ); }
  public Tetromino moveRight() { return new Z(this.x + Block.SIZE, 
                                              this.y, 
                                              this.direction ); }
  public Tetromino moveUp(   ) { return new Z(this.x, 
                                              this.y - Block.SIZE, 
                                              this.direction ); }
  public Tetromino moveDown( ) { return new Z(this.x, 
                                              this.y + Block.SIZE, 
                                              this.direction ); }
  
  public Tetromino rotate() {
    // this.direction += 1; // reminder a op= b; is the same as a = a op b;  
    // this.direction %= 4; 
    int newDirection = (this.direction + 1) % 4; 
    // // what else 
    // this.reset(); 
    return new Z(this.x, this.y, newDirection); 
  }
  
  private void reset() {
    // this.clear(); 
    for (int i = 0; i < shape[direction].length; i++) 
      for (int j = 0; j < shape[direction][i].length; j++) 
        if (shape[direction][i][j] == 1)
          this.add( new Block( this.x + Block.SIZE * j, 
                               this.y + Block.SIZE * i, 
                               Color.GREEN
                             ) 
                  );      
  }
  
  public Z(int x, int y, int d) {
    super(x, y, d); 
    this.reset();             
  }
}