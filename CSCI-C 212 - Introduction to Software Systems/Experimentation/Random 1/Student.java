class Student {
  String fName;
  String lName;
  int id;
  Fraction grade;
  
  Student (String fName, String lName, int id, Fraction grade) {
    this.fName = fName;
    this.lName = lName;
    this.id = id;
    this.grade = grade;
  }
  
  void report () {
    System.out.println("Hello, my name is " + this.fName + " " + this.lName +".");
    System.out.print("My ID number is " + this.id + " & my grade is ");
    this.grade.fractionPrint();
  }
}