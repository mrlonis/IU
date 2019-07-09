class Beta implements Multiplier {
  public int mul(int n, int m) {
    int result = 0;
    for (int i = 0; i < m; i++) {
      result += n;
    }
    return result;
  }
}