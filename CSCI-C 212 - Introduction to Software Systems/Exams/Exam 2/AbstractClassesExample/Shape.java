abstract class Shape {
  Point location;
  Shape(Point where) {
    this.location = where;
  }
  abstract double area();
}