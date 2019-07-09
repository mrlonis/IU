class PLTest {
  public static void main (String[] args) {
    Point p1 = new Point (0.0, 0.0);
    Point p2 = new Point (10.0, 0.0);
    Point p3 = new Point (5.0, 10.0);
    System.out.println("p1 to p2 Distance: " + p1.distance(p2));
    System.out.println("p2 to p3 Distance: " + p2.distance(p3));
    System.out.println("p3 to p1 Distance: " + p3.distance(p1));
    Line l1 = new Line (p1, p2);
    Line l2 = new Line (p2, p3);
    Line l3 = new Line (p3, p1);
    System.out.println("l1 Length: " + l1.length());
    System.out.println("l2 Length: " + l2.length());
    System.out.println("l3 Length: " + l3.length());
    Triangle t1 = new Triangle (p1, p2, p3);
    System.out.println("t1 Area: " + t1.area());
  }
}