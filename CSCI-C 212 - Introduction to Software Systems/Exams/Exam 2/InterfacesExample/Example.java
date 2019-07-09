class Example {
  public static void main(String[] args) {
    Alpha a = new Alpha();
    Beta b = new Beta();
    Gamma g = new Gamma();
    int n = 5, m = 3;
    System.out.println(n + " * " + m + " = " + a.mul(n,m) + " (by Alpha)");
    System.out.println(n + " * " + m + " = " + b.mul(n,m) + " (by Beta)");
    System.out.println(n + " * " + m + " = " + g.mul(n,m) + " (by Gamma)");
  }
}