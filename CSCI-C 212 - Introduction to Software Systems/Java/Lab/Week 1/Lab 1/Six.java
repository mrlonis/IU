import javax.swing.JOptionPane;

public class Six {
  public static void main(String[] args) {
    String name = JOptionPane.showInputDialog("What is your name?"); 
    System.out.print("Hello ");
    System.out.print( name );
    System.out.println("!");
    System.out.println("Hello, my name is Hal. What would you want me to do?");
    String action = JOptionPane.showInputDialog("What do you want me to do?");
    System.out.print("I'm sorry, ");
    System.out.print(name);
    System.out.println(". I'm afraid I can't do that.");
  }
}