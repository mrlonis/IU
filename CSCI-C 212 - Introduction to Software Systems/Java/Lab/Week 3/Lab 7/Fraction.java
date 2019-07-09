class Fraction {
  public int numerator = 0;
  public int denominator = 0;
  
  public Fraction (int x, int y) {
    numerator = x;
    denominator = y;
  }
  
  public void report () {
    System.out.println("Hi, my numerator is " + numerator + " and my denominator is " + denominator + ".");
  }
  
  public Fraction add (Fraction fraction2) {
    Fraction newFractionAddition = new Fraction( ( (numerator * fraction2.denominator) + (denominator * fraction2.numerator) ), (denominator * fraction2.denominator));
    return newFractionAddition;
  }
  
  public Fraction multiply (Fraction fraction2) {
    Fraction newFractionMultiplication = new Fraction( ( (numerator * fraction2.numerator) ), (denominator * fraction2.denominator));
    return newFractionMultiplication;
  }
  
  public static void main(String[] args) {
    Fraction newFraction1 = new Fraction(1, 2);
    Fraction newFraction2 = new Fraction(10, 33);
    Fraction newFraction3 = new Fraction(12, 76);
    
    System.out.print("Fraction 1: ");
    newFraction1.report();
    
    System.out.print("Fraction 2: ");
    newFraction2.report();
    
    System.out.print("Fraction 3: ");
    newFraction3.report();
    
    System.out.print("New fraction after performing addition on fraction 1 and fraction 2: ");
    Fraction addition1 = newFraction1.add(newFraction2);
    System.out.print(addition1.numerator);
    System.out.print("/");
    System.out.println(addition1.denominator);
    
    System.out.print("New fraction after performing multiplication on fraction 1 and fraction 2: ");
    Fraction multiply1 = newFraction1.multiply(newFraction2);
    multiply1.report();
  }
}