class Rectangle extends Shape {
  int width, height;
  Rectangle(Point topLeftCorner, int wide, int tall) {
    super(topLeftCorner);
    this.width = wide;
    this.height = tall;
  }
  double area() {
    return this.width * this.height;
  }
}