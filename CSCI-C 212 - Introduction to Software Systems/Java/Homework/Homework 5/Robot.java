public class Robot {
  public int x;
  public int y;
  public String name;
  public String direction;
  
  public Robot (String name1, int x1, int y1, String direction1) {
    x = x1;
    y = y1;
    name = name1;
    direction = direction1;
  }
  
  public void report () {
    System.out.println("Robot " + name + " located at the cooridnates (" + x + ", " + y + ") facing " + direction);
  }
  
  public void turnLeft() {
    System.out.println("Robot " + name + " now turns left.");
    
    if (direction.equals("North")) {
      direction = "West";
    } else if (direction.equals("South")) {
      direction = "East";
    } else if (direction.equals("East")) {
      direction = "North";
    } else if (direction.equals("West")){
      direction = "South";
    }
  }
  
  public void moveForward () {
    System.out.println("Robot " + name + " now moves forward.");
    
    if (direction.equals("North")) {
      y--;
    } else if (direction.equals("South")) {
      y++;
    } else if (direction.equals("East")) {
      x++;
    } else if (direction.equals("West")){
      x--;
    }
  }
  
  public static void main(String[] args) {
    Robot a = new Robot("Alice", 2, 3, "North"); 
    a.report(); 
    
    Robot q = new Robot("Queen", -4, -1, "West"); 
    q.report(); 
    
    a.turnLeft(); 
    a.report(); 
    
    a.moveForward(); 
    a.report(); 
    
    a.turnLeft(); 
    a.report(); 
    
    a.moveForward();
    a.report(); 
    
    a.moveForward();
    a.report();  
    
    a.moveForward();
    a.report(); 
    
    q.moveForward();
    q.report(); 
    
    q.turnLeft(); 
    q.report(); 
  }
}