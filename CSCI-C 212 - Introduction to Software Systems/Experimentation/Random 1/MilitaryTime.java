class MilitaryTime {
  public static void main(String[] args) {
    // read user input: 
    String time1, time2; 
    java.util.Scanner in = new java.util.Scanner(System.in); 
    System.out.print("Enter the first time: "); 
    time1 = in.nextLine(); 
    System.out.print("Enter the second time: "); 
    time2 = in.nextLine();

    // calculate difference
    int h1, m1, h2, m2; 
    int t1, t2, d; 
    h1 = Integer.parseInt(time1.substring(0, 2));
    m1 = Integer.parseInt(time1.substring(2));
    t1 = h1 * 60 + m1; 
    h2 = Integer.parseInt(time2.substring(0, 2));
    m2 = Integer.parseInt(time2.substring(2));
    t2 = h2 * 60 + m2; 
    d = (t2 - t1 + 24 * 60) % (24 * 60);

    System.out.println(d / 60 + "hours" + d % 60 + "minutes");
    
  }
}