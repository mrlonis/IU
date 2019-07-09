import java.awt.*; 

class Tetromino {
  // please note the centers of rotation CW
  static Tetromino sQuare() { 
    return new Tetromino(new Point(0, -1), makeBlocks(new int[] {0, -1, 0, -2, 1, -1, 1, -2}, Color.GREEN)); 
  }
  
  static Tetromino liNe() { 
    return new Tetromino(new Point(1, -1), makeBlocks(new int[] {0, -1, 1, -1, 2, -1, 3, -1}, Color.BLUE)); 
  }
  
  static Tetromino l() { 
    return new Tetromino(new Point(1, -1), makeBlocks(new int[] {0, -1, 1, -1, 2, -1, 2, -2}, Color.MAGENTA)); 
  }
  
  static Tetromino MirroredL() { 
    return new Tetromino(new Point(1, -1), makeBlocks(new int[] {0, -1, 1, -1, 2, -1, 0, -2}, Color.CYAN)); 
  }
  
  static Tetromino t() { 
    return new Tetromino(new Point(1, -1), makeBlocks(new int[] {0, -1, 1, -1, 2, -1, 1, -2}, Color.ORANGE)); 
  }
  
  static Tetromino s() { 
    return new Tetromino(new Point(1, -1), makeBlocks(new int[] {0, -1, 1, -1, 1, -2, 2, -2}, Color.RED)); 
  }
  
  static Tetromino z() { 
    return new Tetromino(new Point(1, -2), makeBlocks(new int[] {0, -2, 1, -2, 1, -1, 2, -1}, Color.PINK)); 
  } 
  
  static SetOfBlocks makeBlocks(int[] c, Color color) {
    SetOfBlocks a = new SetOfBlocks(); 
    a.add(new Block( c[0],  c[1], color)); 
    a.add(new Block( c[2],  c[3], color)); 
    a.add(new Block( c[4],  c[5], color)); 
    a.add(new Block( c[6],  c[7], color)); 
    return a;
  }
  
  Point center;
  SetOfBlocks blocks;
  
  Tetromino(Point center, SetOfBlocks blocks) {
    this.center = center; 
    this.blocks = blocks; 
  }
  
  void draw(Graphics g) {
    this.blocks.draw(g); 
  }
  
  void move(int dx, int dy) {
    this.center.move(dx, dy); 
    this.blocks.move(dx, dy); 
  }
  
  public String toString() {
    return this.center + " " + this.blocks ;  
  }
  
  void rotateCW() {
    this.blocks.rotateCW(this.center);  
  }
  
  boolean overlapsBlocks(SetOfBlocks blocks) {
    return this.blocks.intersect(blocks).count() > 0;  
  }
  
  void changeColor(Color color) {
    this.blocks.changeColor(color);  
  }
  
  static Tetromino pickRandom() {
    int value = (int)(Math.random() * 7);  
    if (value == 0) return Tetromino.sQuare();
    else if (value == 1) return Tetromino.liNe(); 
    else if (value == 2) return Tetromino.l(); 
    else if (value == 3) return Tetromino.MirroredL(); 
    else if (value == 4) return Tetromino.t(); 
    else if (value == 5) return Tetromino.s(); 
    else return Tetromino.z(); 
  }
  
}