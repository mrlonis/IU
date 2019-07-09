import java.awt.Graphics; 
import java.util.ArrayList; 

public class Ground extends ArrayList<Tetromino> {
  public void draw(Graphics g) {
    for (Tetromino t : this)
      t.draw(g); 
  }
}