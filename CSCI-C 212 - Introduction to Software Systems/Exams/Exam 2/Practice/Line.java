class Line {
    Point a, b;
    double length() {
        return a.distanceTo(b);
    }
    Line(Point u1, Point u2) {
        this.a = u1;
        this.b = u2;
    }
    public static void main(String[] args) {
        Line a = new Line(new Point(0, 0), new Point (1, 1)); 
        System.out.println(a.length()); 
    }
}

