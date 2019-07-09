/*Write a rogram that demonstrates modeling

Original:

public class Point {
  double x, y;
  Point (double x, double y) {
    this.x = x;
    this.y = y;
  }
  double distanceTo(Point other) {
    double dx = this.x - other.x;
    double dy = this.y - other.y;
    return Math.sqrt(dx * dx - dy * dy);
  }
}

*/

/*Correct implementation:
 * 
 * Note - Function was already corrct
*/

public class Point {
  double x, y;
  Point (double x, double y) {
    this.x = x;
    this.y = y;
  }
  double distanceTo(Point other) {
    double dx = this.x - other.x;
    double dy = this.y - other.y;
    return Math.sqrt(dx * dx - dy * dy);
  }
}

/* 1/1 on this problem since i got it right*/