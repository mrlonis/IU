import java.awt.*; 

public class O extends Tetromino {
  
  final static int[][][] shape = 
  {
    { { 0, 0, 0 },
      { 0, 1, 1 },
      { 0, 1, 1 }
    }, // index 0 in the shape array 
    { { 0, 0, 0 },
      { 1, 1, 0 },
      { 1, 1, 0 }
    }, // index 0 in the shape array 
    { { 1, 1, 0 },
      { 1, 1, 0 },
      { 0, 0, 0 }
    }, // index 0 in the shape array 
    { { 0, 1, 1 },
      { 0, 1, 1 },
      { 0, 0, 0 }
    }, // index 0 in the shape array 
        
  }; 
  
  public void rotate() {
    this.direction += 1; // reminder a op= b; is the same as a = a op b;  
    this.direction %= 4; 
    // what else 
    this.reset(); 
  }
  
  private void reset() {
    this.clear(); 
    for (int i = 0; i < shape[direction].length; i++) 
      for (int j = 0; j < shape[direction][i].length; j++) 
        if (shape[direction][i][j] == 1)
          this.add( new Block( this.x + Block.SIZE * j, 
                               this.y + Block.SIZE * i, 
                               Color.YELLOW
                             ) 
                  );      
  }
  
  public O(int x, int y) {
    super(x, y); 
    this.reset();             
  }
}
