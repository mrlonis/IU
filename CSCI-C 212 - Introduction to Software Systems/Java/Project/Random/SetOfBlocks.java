import java.awt.*; 
import java.util.*; 

class SetOfBlocks extends ArrayList<Block> {
  void draw(Graphics g) {
    for (Block b : this) 
      b.draw(g); 
  }
  void move(int dx, int dy) {
    for (Block b : this) 
      b.move(dx, dy); 
  }
  void rotateCW(Point center) { // clockwise 
    for (Block b : this)
      b.rotateCW(center); 
  }
}