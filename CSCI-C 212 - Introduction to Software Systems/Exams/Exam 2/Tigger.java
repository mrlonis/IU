public class Tigger {
  public int x;
  public int y;
  
  public Tigger (int x1, int y1) {
    x = x1;
    y = y1;
  }
  
  public int length (int n) {
    int length = (int)(Math.log10(n)+1);
    return length;
  }
  
  public void report () {
    System.out.println("Tigger just bounced to (" + x + ", " + y + ")");
  }
  
  public void bounce () {
    if (length(x) == 1) {
      x = x * x;
    } else if (length(x) == 2) {
      int i = x;
      String s = Integer.toString(i);
      int x1 = Integer.parseInt(s.substring(0, 1));
      int x2 = Integer.parseInt(s.substring(1, 2));
      x1 = x1 * x1;
      x2 = x2 * x2;
      x = x1 + x2;
    } else if (length(x) == 3) {
      int i = x;
      String s = Integer.toString(i);
      int x1 = Integer.parseInt(s.substring(0, 1));
      int x2 = Integer.parseInt(s.substring(1, 2));
      int x3 = Integer.parseInt(s.substring(2, 3));
      x1 = x1 * x1;
      x2 = x2 * x2;
      x3 = x3 * x3;
      x = x1 + x2 + x3;
    }
    
    if (length(y) == 1) {
      y = y * y;
    } else if (length(y) == 2) {
      int i = y;
      String s = Integer.toString(i);
      int y1 = Integer.parseInt(s.substring(0, 1));
      int y2 = Integer.parseInt(s.substring(1, 2));
      y1 = y1 * y1;
      y2 = y2 * y2;
      y = y1 + y2;
    } else if (length(y) == 3) {
      int i = y;
      String s = Integer.toString(i);
      int y1 = Integer.parseInt(s.substring(0, 1));
      int y2 = Integer.parseInt(s.substring(1, 2));
      int y3 = Integer.parseInt(s.substring(2, 3));
      y1 = y1 * y1;
      y2 = y2 * y2;
      y3 = y3 * y3;
      y = y1 + y2 + y3;
    }
  }
  
  public static void main(String[] args) {
    int a = (int)(Math.random() * 1000), b = (int)(Math.random() * 1000); 
    Tigger u = new Tigger(a, b); 
    for (int i = 0; i < 30; i++) {
      u.bounce(); 
      u.report(); 
    }
  }
}