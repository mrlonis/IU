import java.util.*; 
import java.awt.*; 

public class Ground extends ArrayList<Block> {
  public boolean overlaps(Tetromino t) {
    if (t.y > 400)
        return true; 
    for (Block b : this)
      for (Block c : t) 
        if (b.overlaps(c))
          return true; 
    return false; 
  }
  public void draw(Graphics g) {
    for (Block b : this)
      b.draw(g); 
  }
}