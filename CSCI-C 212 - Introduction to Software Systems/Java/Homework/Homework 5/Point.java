public class Point {
  public int x;
  public int y;
  
  public Point (int x1, int y1) {
    x = x1;
    y = y1;
  }
  
  public Point () {
    x = 0;
    y = 0;
  }
  
  public double distanceTo(Point point1) {
    double distance1 = Math.hypot(x - point1.x, y - point1.y);
    return distance1;
  }
  
  public static void main(String[] args) {
    Point a = new Point(3, 0); 
    Point b = new Point(0, 4); 
    System.out.println(a.distanceTo(b)); 
    System.out.println((new Point(1, 1)).distanceTo(new Point())); 
  }
}