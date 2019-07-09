import java.awt.*; 

class Circle {
  int x, y; // center
  int radius;
  Color color; 
  Circle(int x, int y, int radius, Color color) {
    this.x = x; 
    this.y = y;
    this.radius = radius;
    this.color = color;
  }
  void draw(Graphics g) {
//    g.setColor(Color.WHITE); 
//    g.fillOval(this.x - this.radius,
//               this.y - this.radius,
//               this.radius * 2,
//               this.radius * 2); 
    g.setColor(this.color); 
    g.drawOval(this.x - this.radius,
               this.y - this.radius,
               this.radius * 2,
               this.radius * 2); 
  }
  void enlarge() {
    this.radius += 1; 
  }
}