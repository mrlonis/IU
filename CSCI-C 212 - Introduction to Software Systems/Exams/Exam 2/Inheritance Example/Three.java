class Three extends Two {
  int pow(int n, int m) {
    if (m == 0) return 1;
    else return mul(n, pow(n, m-1));
  }
}