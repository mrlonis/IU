class Point {
    double x, y;
    Point(double x, double y) { this.x = x; this.y = y; }
    Point() { this(0, 0); }
    static Point origin = new Point(); 
    double distanceTo(Point other) {
        double dx = this.x - other.x;
        double dy = this.y - other.y;
        return Math.sqrt(dx * dx + dy * dy);
    }
    public static void main(String[] args) {
        Point a = new Point(3, 0); 
        Point b = new Point(0, 4); 
        System.out.println(a.distanceTo(b)); 
        System.out.println((new Point(1, 1)).distanceTo(new Point())); 
    }
}
