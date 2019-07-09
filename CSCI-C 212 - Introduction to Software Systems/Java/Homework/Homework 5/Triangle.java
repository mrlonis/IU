public class Triangle {
  public Point point1;
  public Point point2;
  public Point point3;
  
  public Triangle (Point point1_x, Point point2_x, Point point3_x) {
    point1 = point1_x;
    point2 = point2_x;
    point3 = point3_x;
  }
  
  public double area () {
    double length1 = point1.distanceTo(point2);
    double length2 = point1.distanceTo(point3);
    return ( (length1 * length2) / 2);
  }
  
  public static void main(String[] args) {
    Triangle a = new Triangle(new Point(0, 0), 
                              new Point(0, 3), 
                              new Point(4, 0));
    System.out.println(a.area());
  }
}