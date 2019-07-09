import java.awt.event.ActionListener; 
// https://docs.oracle.com/javase/8/docs/api/java/awt/event/ActionListener.html
import java.awt.event.ActionEvent; 

public class Umpire implements ActionListener {
  int i; // initialized at zero
  public void actionPerformed(ActionEvent e) {
    this.i += 1; 
    System.out.println("The count is: " + this.i);  
  }
}