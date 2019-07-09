/*Write a rogram that demonstrates modeling

Original:

public class Line {
  Point a, b;
  Line (Point a, Point b) {
    this.a = a;
    this.b = b;
  }
  double length() {
    this.a.distanceTo(this.b);
  }
}

*/

/* correct implementation:*/

public class Line {
  Point a, b;
  Line (Point a, Point b) {
    this.a = a;
    this.b = b;
  }
  double length() {
    return this.a.distanceTo(this.b); // added the word return because this origially returned nothing
  }
}

/*Since i only forgot the word return i feel i deserve 0.9/1 for this problem*/