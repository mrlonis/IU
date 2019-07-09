class Gamma implements Multiplier {
  public int mul(int n, int m) {
    if (m == 1) return n;
    else return n + mul(n, m-1);
  }
}