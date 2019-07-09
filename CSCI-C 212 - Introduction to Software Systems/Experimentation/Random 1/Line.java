class Line {
  Point start, end;
  
  Line (Point p1, Point p2) {
    this.start = p1;
    this.end = p2;
  }
  
  Line () {
    this.start = new Point (0, 0);
    this.end = new Point (0, 0);
  }
  
  double length () {
    return this.start.distance(this.end);
  }
}