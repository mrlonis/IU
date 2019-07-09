class Point {
  double x, y;
  
  Point (double x, double y) {
    this.x = x;
    this.y = y;
  }
  
  Point () {
    this.x = 0.0;
    this.y = 0.0;
  }
  
  double distance (Point other) {
    return Math.sqrt(Math.pow((this.x - other.x), 2) + Math.pow((this.y - other.y), 2));
  }
}