class Calculator {
  public static void main(String[] args) {
    Three calc = new Three();
    int n = 3, m = 5;
    System.out.println(n + " + " + m + " = " + calc.add(n, m));
    System.out.println(n + " * " + m + " = " + calc.mul(n, m));
    System.out.println(n + " ^ " + m + " = " + calc.pow(n, m));
  }
}