import java.util.Scanner;

class HomeworkOne {
  public static void main(String[] args) {
    Scanner s = new Scanner(System.in);
    System.out.println("This funstion will ask for two times. Please input the times in military format. Also, take note the calculation is done by subtracting the first time from the second time.");
    System.out.print("Enter the first time: "); 
    String time1_string = s.nextLine(); 
    System.out.print("Enter the second time: "); 
    String time2_string = s.nextLine(); 
    
    int time1_int, time2_int;
    
    time1_int = ((Integer.valueOf(time1_string.substring(0,2))) * 60) + (Integer.valueOf(time1_string.substring(3,5)));
    time2_int = ((Integer.valueOf(time2_string.substring(0,2))) * 60) + (Integer.valueOf(time2_string.substring(3,5)));
    
    int time_difference;
    
    if (time2_int >= time1_int) {
      time_difference = time2_int - time1_int;
    } else {
      time_difference = time2_int - time1_int + (24*60);
    }
    
    System.out.println("The time difference is " + time_difference/60 + " hours and " + time_difference%60 + " minutes.");
    s.close();
  }
}