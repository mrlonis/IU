class Triangle {
  Point p1, p2, p3;
  
  Triangle (Point p1, Point p2, Point p3) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
  }
  
  Triangle () {
    this.p1 = new Point (0, 0);
    this.p2 = new Point (5, 0);
    this.p3 = new Point (2.5, 5);
  }
  
  double area () {
    return Math.abs(((this.p1.x * (this.p2.y - this.p3.y)) + (this.p2.x * (this.p3.y - this.p1.y)) + (this.p3.x * (this.p1.y - this.p2.y))) / 2);
  }
}