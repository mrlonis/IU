class Two extends One {
  int mul(int n, int m) {
    if (m == 1) return n;
    else return add(n, mul(n, m-1));
  }
}