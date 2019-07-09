class Experiment {
  public static void main(String[] args) {
      Triangle a = new Triangle(new Point(0, 3), 
                                new Point(4, 0), 
                                Point.origin); 
      System.out.println(a.area()); // should be 6.0 
  }
}

class Triangle {
    Line a, b, c; 
    Triangle (Point a, Point b, Point c) {
        this.a = new Line(a, b); 
        this.b = new Line(a, c); 
        this.c = new Line(b, c); 
    }
    double area() {
        double s = (this.a.length() + this.b.length() + this.c.length()) / 2; 
        return Math.sqrt(s * (s - a.length()) * 
                             (s - b.length()) * 
                             (s - c.length())); 
    }
}

