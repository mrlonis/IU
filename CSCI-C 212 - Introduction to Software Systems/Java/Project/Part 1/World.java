/*The three methods in world represent the engine for tetris
 * This is the engine
 */

import java.awt.Graphics;

interface World {
  public boolean hasEnded(); 
  public void draw(Graphics g); 
  public void update();
  public void keyPressed(String what);
}