public class Elevator {
  public int floor = 0;
  
  public Elevator (int x) {
    floor = x;
  }
  
  public void up (int x) {
    if (x <= floor) {
      System.out.println("Sorry, from floor " + floor + " we can't go up to floor " + x + ".");
    } else {
      System.out.println("Elevator going up (" + floor + " --> " + x + ")");
      while (floor != (x + 1) ) {
        System.out.println("     The elevator is now on floor " + floor);
        floor++;
      }
      floor--;
     System.out.println("Elevator is now on floor: " + floor);
    }
  }
  
  public void down (int x) {
    if (x >= floor) {
      System.out.println("Sorry, from floor " + floor + " we can't go down to floor " + x + ".");
    } else {
      System.out.println("Elevator going down (" + floor + " --> " + x + ")");
      while (floor != (x - 1) ) {
        System.out.println("     The elevator is now on floor " + floor);
        floor--;
      }
      floor++;
     System.out.println("Elevator is now on floor: " + floor);
    }
  }
  
  public int currentFloor() {
    return floor;
  }
  
  public static void main(String[] args) {
    Elevator newElevator1 = new Elevator (20);
    newElevator1.up(26); 
    newElevator1.down(14); 
    newElevator1.up(10); 
    newElevator1.down(30); 
    newElevator1.up(newElevator1.currentFloor() + 3); 
  }
}