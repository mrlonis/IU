import java.awt.*;
import java.util.*;

public class Block {

  final static int SIZE = 30; 
  int x, y, w, h;
  Color c; 
  
  public Block(int x, int y, Color c) {
    this.x = x;    
    this.y = y;    
    this.w = Block.SIZE;    
    this.h = Block.SIZE;    
    this.c = c;    
  }
  
  public void moveRight() { this.x += Block.SIZE; }
  public void moveLeft( ) { this.x -= Block.SIZE; }  
  public void moveUp(   ) { this.y -= Block.SIZE; } 
  public void moveDown( ) { this.y += Block.SIZE; } 
}
