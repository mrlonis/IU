import java.awt.*; 
import java.awt.event.*; 
import javax.swing.*; 

class Tetris implements World {
  Tetromino t; 
  SetOfBlocks blocks; 
  Tetris(Tetromino t, SetOfBlocks s) {
    this.t = t;
    this.blocks = s; 
  }
  public void draw(Graphics g) { // world->image
    // System.out.println("World being drawn."); 
    t.draw(g); 
  } 
  public void update() { 
    // System.out.println("World getting older."); 
  }
  public boolean hasEnded() { return false; } 
  public void keyPressed(KeyEvent e) { // world-key-move
    // System.out.println("Ouch."); 
    if (e.getKeyCode() == KeyEvent.VK_UP) { 
      this.t.move( 0, -1); 
    } else if (e.getKeyCode() == KeyEvent.VK_DOWN) { 
      this.t.move( 0,  1); 
    } else if (e.getKeyCode() == KeyEvent.VK_LEFT) { 
      this.t.move(-1,  0); 
    } else if (e.getKeyCode() == KeyEvent.VK_RIGHT) { 
      this.t.move( 1,  0); 
    } else if (e.getKeyChar() == 'q') {      // sQuare
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.sQuare()   ; 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 'n') {    // liNe
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.liNe()     ; 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 'l') {    // L
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.l()        ; 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 'm') {    // Mirrored l
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.MirroredL(); 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 't') {    // T
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.t()        ; 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 's') {    // S
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.s()        ; 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 'z') {    // Z
      int dx = this.t.dx, dy = this.t.dy; 
      this.t = Tetromino.z()        ; 
      this.t.move(dx, dy); 
    } else if (e.getKeyChar() == 'r') {    // Rotate CW
      this.t.rotateCW();  
    } else this.t.move( 0, 0 ); 
    System.out.println( t ); // debug 
  } 
  public static void main(String[] args) {
    BigBang game = new BigBang(200, new Tetris(Tetromino.sQuare(), new SetOfBlocks())); 
    JFrame frame = new JFrame("Tetris"); 
    frame.getContentPane().add( game ); 
    frame.addKeyListener( game ); 
    frame.setVisible(true); 
    frame.setSize(400, 400); 
    frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE ); 
    game.start(); 
  }
}