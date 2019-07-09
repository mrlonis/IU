public class Clock {
  public int hours;
  public int minutes;

  public Clock (String time) {
    hours = Integer.parseInt(time.substring(0, 2));
    minutes = Integer.parseInt(time.substring(2, 4));
  }
  
  public void report () {
    if (hours < 10 && minutes < 10) {
      System.out.println("0" + hours + ":" + "0" + minutes);
    } else if (hours < 10) {
      System.out.println("0" + hours + ":" + minutes);
    } else if (minutes < 10) {
      System.out.println(hours + ":" + "0" + minutes);
    } else {
      System.out.println(hours + ":" + minutes);
    }
  }
  
  public void tick () {
    if (hours == 23 && minutes == 59) {
      hours = 0;
      minutes = 0;
    } else if (minutes < 59) {
      minutes++;
    } else {
      hours++;
      minutes = 0;
    }
  }
  
  public static void main(String[] args) {
    Clock one = new Clock("2350"); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report(); 
    one.tick(); 
    one.report();
  }
}