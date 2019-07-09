import java.awt.*; 
import java.util.*; 

class SetOfBlocks extends ArrayList<Block> {
  
  void draw(Graphics g) {
    for (Block b : this) { 
      b.draw(g);
    }
  }
  
  void move(int dx, int dy) {
    for (Block b : this) { 
      b.move(dx, dy);
    }
  }
  
  void rotateCW(Point center) { // clockwise 
    for (Block b : this) {
      b.rotateCW(center);
    }
  }
  
  boolean contains(Block block) {
    if (this.size() != 0) { 
      for (Block b : this) {
        if (b.equals(block)) {
          return true;
        }
      }
    }
    return false; 
  }
  
  boolean subset(SetOfBlocks blocks) {
    if (this.size() != 0) {
      for (Block b : this) {
        if (! blocks.contains(b)) {
          return false;
        }
      }
    }
    return true; 
  }
  
  boolean equals(SetOfBlocks blocks) {
    return this.subset(blocks) && blocks.subset(this);  
  }
  
  SetOfBlocks intersect(SetOfBlocks other) {
    SetOfBlocks result = new SetOfBlocks(); 
    for (Block b : this)
      if (other.contains(b))
        result.add(b); 
    return result; 
  }
  
  SetOfBlocks union(SetOfBlocks other) {
    SetOfBlocks result = new SetOfBlocks(); 
    for (Block b : this)
      if (! result.contains(b) )
        result.add(b); 
    for (Block b : other)
      if (! result.contains(b) )
        result.add(b); 
    return result; 
  }
  
  int count() {
    return this.size(); 
  }
  
  int maxY() {
    int result = 0; 
    for (Block b : this)
      if (b.y > result) 
        result = b.y; 
    return result; 
  }
  
  int minX() {
    int result = Tetris.COLUMNS; 
    for (Block b : this)
      if (b.x < result)
        result = b.x; 
    return result; 
  }
  
  int maxX() {
    int result = 0; 
    for (Block b : this)
      if (b.x > result)
        result = b.x; 
    return result; 
  }
  
  void changeColor(Color color) {
    for (Block b : this) 
      b.setColor(color); 
  }
  
  boolean overflow() {
    for (Block b : this)
      if (b.y <= 0)
        return true;
    return false;
  }
  
  SetOfBlocks row(int row) {
    SetOfBlocks result = new SetOfBlocks(); 
    for (Block b : this)
      if (b.y == Tetris.ROWS - row)
        result.add(b); 
    return result; 
  }
  
  boolean fullRow(int row) {
    int a = this.row(row).count(); 
    int b = Tetris.COLUMNS; 
    // System.out.println( a + " vs " + b ); 
    return a == b; 
  }
  
  void eliminateRow(int i) { // i == 0 indicates bottom row 
    SetOfBlocks row = new SetOfBlocks(); 
    for (Block b : this) 
      if (b.y == (Tetris.ROWS - i))
        row.add(b); 
    for (Block b : row)
      this.remove(b); 
    for (Block b : this) 
      if (b.y < (Tetris.ROWS - i))
        b.move(0, 1); 
  }
  
  void eliminateFullRows() {
    for (int i = 0; i < Tetris.ROWS;    ) {
      if (this.fullRow(i)) {
        // System.out.println("Eliminating: " + i); 
        this.eliminateRow(i); 
      } else i++; 
    }
  }
  
}