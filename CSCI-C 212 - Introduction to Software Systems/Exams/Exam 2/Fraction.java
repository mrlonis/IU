public class Fraction {    
  private int num, den; 
  public Fraction add(Fraction other) {
    return new Fraction( this.num * other.den + this.den * other.num , 
                         this.den * other.den ); 
  }
  public Fraction multiply(Fraction other) {        // [8] 
    return new Fraction( this.num * other.num ,     // [8] 
                         this.den * other.den );    // [8] 
  }                                                 // [8] 
  public Fraction(int num, int den) {  
    this.num = num; 
    this.den = den;  
  }  
  public String toString() {                              // extra 
    return this.num + "/" + this.den;                     // extra 
  }                                                       // extra 
  public static void main(String[] args) { 
    Fraction a, b;                          
    a = new Fraction(3, 1); 
    b = new Fraction(5, 1);  
    System.out.println( a );              // see the effect of extra 
    System.out.println( b );                                  
    Fraction c = a.add(b);   
    System.out.println( c );  
    System.out.println( (new Fraction(1, 2)).add(new Fraction(1, 2)) ); 
    System.out.println( (new Fraction(1, 2)).multiply(new Fraction(2, 1)) ); 
    
  }                                        
}   