public class Line {
  public Point point1;
  public Point point2;
  
  public Line (Point point1_x, Point point2_x) {
    point1 = point1_x;
    point2 = point2_x;
  }
  
  public double length () {
    return point1.distanceTo(point2);
  }
  
  public static void main(String[] args) {
    Line a = new Line(new Point(0, 0), new Point (1, 1)); 
    System.out.println(a.length());
  }
}