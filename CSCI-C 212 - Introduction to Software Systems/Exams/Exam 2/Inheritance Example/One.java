class One {
  int add(int n, int m) {
    if (m == 0) return n;
    else return add(n+1, m-1);
  }
}