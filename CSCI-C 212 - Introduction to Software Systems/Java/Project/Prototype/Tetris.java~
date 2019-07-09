import java.awt.*; 
import java.awt.event.*; 
import javax.swing.*; 

class Tetris implements World {
  static final int ROWS = 20; 
  static final int COLUMNS = 10; 
  Tetromino t; 
  SetOfBlocks blocks; 
  Tetris(Tetromino t, SetOfBlocks s) {
    this.t = t;
    this.blocks = s; 
  }
  public void draw(Graphics g) { // world->image
    // System.out.println("World being drawn."); 
    t.draw(g); 
    blocks.draw(g); 
    g.drawRect(0, 0, Tetris.COLUMNS * Block.SIZE, Tetris.ROWS * Block.SIZE); 
  } 
  public void update() { 
    // System.out.println("World getting older."); 
    if (this.landed())
      this.touchdown(); 
    else 
      this.t.move(0, 1); 
    // System.out.println( t ); // debug 
    // System.out.println( blocks ); // also debug 
  }
  public boolean hasEnded() { return false; } 
  public void keyPressed(KeyEvent e) { // world-key-move
    if (this.landed()) 
      this.touchdown(); 
    else if (e.getKeyCode() == KeyEvent.VK_LEFT ) { this.t.move(-1,  0); }
    else if (e.getKeyCode() == KeyEvent.VK_RIGHT) { this.t.move( 1,  0); } 
    else if (e.getKeyChar() == ' ') { this.jumpDown(); }
    // else if (e.getKeyChar() == '2') { this.blocks.eliminateRow(2); } // basic test 
    // else if (e.getKeyChar() == '2') { System.out.println( "Row 2 has " + this.blocks.row(2).count() + " blocks currently." ); } // another basic test 
    // else if (e.getKeyChar() == '2') { System.out.println( "Row 2 full? Answer: " + blocks.fullRow(2) ); } // yet another basic test 
    // else if (e.getKeyChar() == 'e') { this.blocks.eliminateFullRows(); } // another basic test 
    else if (e.getKeyChar() == 'r') {    // Rotate CW
      this.t.rotateCW();  
    } else this.t.move( 0, 0 );     
  } 
  public static void main(String[] args) {
    BigBang game = new BigBang(new Tetris(Tetromino.sQuare(), new SetOfBlocks())); 
    JFrame frame = new JFrame("Tetris"); 
    frame.getContentPane().add( game ); 
    frame.addKeyListener( game ); 
    frame.setVisible(true); 
    frame.setSize(Tetris.COLUMNS * Block.SIZE + 20, Tetris.ROWS * Block.SIZE + 40); 
    frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE ); 
    game.start(); 
  }
  void touchdown() {
    this.blocks = this.blocks.union(this.t.blocks);
    this.blocks.eliminateFullRows(); 
    this.t = Tetromino.pickRandom(); 
  }
  void jumpDown() {
    if (! this.landed()) { 
      this.t.move(0, 1); 
      this.jumpDown(); 
    }      
  }
  boolean landedOnBlocks() { // on the strengths of the functional model 
    this.t.move(0, 1); 
    if (this.t.overlapsBlocks(this.blocks)) {
      this.t.move(0, -1); 
      return true; 
    } else {
      this.t.move(0, -1); 
      return false; 
    }
  }
  boolean landedOnFloor() {
    return this.t.blocks.maxY() == Tetris.ROWS - 1; 
  }
  boolean landed() {
    return this.landedOnFloor() || this.landedOnBlocks();  
  }
}