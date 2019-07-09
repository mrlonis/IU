import javax.swing.JComponent;
import java.awt.Graphics; 
import java.awt.Color;
import java.awt.event.MouseMotionListener; 
import java.awt.event.MouseEvent;

public class MouseEventsTwo extends JComponent implements MouseMotionListener {
  public MouseEventsTwo() {
    super(); 
    this.addMouseMotionListener( this ); 
  }
  int x, y; 
  public void mouseDragged(MouseEvent e) { 
    this.x = e.getX(); 
    this.y = e.getY(); 
    // this.getGraphics().drawString("(" + x + ", " + y + ")", x, y); 
    // System.out.println("Mouse being dragged..."); 
    this.repaint(); 
  }
  public void mouseMoved(MouseEvent e) { 
    System.out.println("Mouse MOVED!!"); 
  }
  int count = 0;   
  public void paintComponent(Graphics g) { 
    // dynamic method lookup (overriding) 
    this.count += 1;
    System.out.println("I am painting...(" + this.count + ")"); 
    g.setColor(Color.YELLOW); 
    g.fillOval(50, 50, 100, 100);
    g.setColor(Color.BLACK);
    g.drawOval(50, 50, 100, 100);

    g.drawString("(" + this.x + ", " + this.y + ")", this.x, this.y); 
  
  }
}