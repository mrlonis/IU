class Circle extends Shape {
  int radius;
  Circle(Point center, int radius) {
    super(center);
    this.radius = radius;
  }
  double area() {
    return Math.PI * Math.pow(this.radius, 2);
  }
}