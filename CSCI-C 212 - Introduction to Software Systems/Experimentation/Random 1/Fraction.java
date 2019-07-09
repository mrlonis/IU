class Fraction {
  double numerator, denominator;
  
  Fraction (double num, double den) {
    this.numerator = num;
    this.denominator = den;
  }
  
  Fraction () {
    this.numerator = 1.0;
    this.denominator = 2.0;
  }
  
  double toDecimal () {
    return this.numerator / this.denominator;
  }
  
  void fractionPrint () {
    System.out.println(this.numerator + "/" + this.denominator);
  }
  
  void add (Fraction other) {
    if (this.denominator == other.denominator) {
      System.out.println( (this.numerator + other.numerator) + "/" + this.denominator);
    } else {
      System.out.println( ((this.numerator * other.denominator) + (other.numerator * this.denominator)) + "/" + (this.denominator * other.denominator));
    }
  }
}