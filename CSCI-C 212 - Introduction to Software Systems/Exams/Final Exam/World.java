import java.awt.*; 

interface World {
  public boolean hasEnded(); 
  public void draw(Graphics g); 
  public void update(); 
  public void keh(String key); 
}