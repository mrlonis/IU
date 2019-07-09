import java.net.URL; 
import javax.swing.ImageIcon; 
import javax.swing.JOptionPane; 

public class Nine {
  public static void main(String[] args) throws Exception {
     URL imageLocation = new URL("http://r.ddmcdn.com/s_f/o_1/w_1024/h_682/APL/uploads/2012/05/TooCute-CuteKittens.jpg"); 
     JOptionPane.showMessageDialog(null, "Hello, do you like cute kittens too?", "Cute Kittens", JOptionPane.PLAIN_MESSAGE, new ImageIcon(imageLocation));      
  }
}