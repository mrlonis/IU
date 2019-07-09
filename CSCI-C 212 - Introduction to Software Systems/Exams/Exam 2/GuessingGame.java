import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;

class GuessingGame {
  public static void main(String[] args) {
    System.out.println("Welcome to the guessing game. I will randomly pick a number between 1 and 100 and you will try to guess it in 6 tries or less. Here we go:");
    Scanner in = new Scanner(System.in);
    int SecretNumber; // declaration
    SecretNumber = ThreadLocalRandom.current().nextInt(0, 100 + 1);
    int count = 0;
    
    int TriesLeft = 6 - count;
    
    if (args.length == 0) {
      while (count != 6) {
        System.out.print("Please enter a guess: ");
        int guess = in.nextInt();
        if (guess > SecretNumber && count != 5) {
          count = count + 1;
          TriesLeft = 6 - count;
          System.out.println("The secret number is smaller than that. You have " + TriesLeft + " tries left.");
        } else if (guess < SecretNumber && count != 5) {
          count = count + 1;
          TriesLeft = 6 - count;
          System.out.println("The secret number is bigger than that. You have " + TriesLeft + " tries left.");
        } else if (guess == SecretNumber) {
          count = count + 1;
          System.out.println("That's it! You guessed it, the number was: " + SecretNumber + " and it took you " + count + " tries.");
          count = 6;
        } else if (count == 5){
          count = count + 1;
          System.out.println("Sorry, you just ran out of attempts. The secret number was: " + SecretNumber);
          count = 6;
        }
      }
    } else if (args[0].equals("debug")) {
      while (count != 6) {
        System.out.print("(" + SecretNumber + ") Please enter a guess: ");
        int guess = in.nextInt();
        if (guess > SecretNumber && count != 5) {
          count = count + 1;
          TriesLeft = 6 - count;
          System.out.println("The secret number is smaller than that. You have " + TriesLeft + " tries left.");
        } else if (guess < SecretNumber && count != 5) {
          count = count + 1;
          TriesLeft = 6 - count;
          System.out.println("The secret number is bigger than that. You have " + TriesLeft + " tries left.");
        } else if (guess == SecretNumber) {
          count = count + 1;
          System.out.println("That's it! You guessed it, the number was: " + SecretNumber + " and it took you " + count + " tries.");
          count = 6;
        } else if (count == 5){
          count = count + 1;
          System.out.println("Sorry, you just ran out of attempts. The secret number was: " + SecretNumber);
          count = 6;
        }
      }
    } else {
      while (count != 6) {
        System.out.print("Please enter a guess: ");
        int guess = in.nextInt();
        if (guess > SecretNumber && count != 5) {
          count = count + 1;
          TriesLeft = 6 - count;
          System.out.println("The secret number is smaller than that. You have " + TriesLeft + " tries left.");
        } else if (guess < SecretNumber && count != 5) {
          count = count + 1;
          TriesLeft = 6 - count;
          System.out.println("The secret number is bigger than that. You have " + TriesLeft + " tries left.");
        } else if (guess == SecretNumber) {
          count = count + 1;
          System.out.println("That's it! You guessed it, the number was: " + SecretNumber + " and it took you " + count + " tries.");
          count = 6;
        } else if (count == 5){
          count = count + 1;
          System.out.println("Sorry, you just ran out of attempts. The secret number was: " + SecretNumber);
          count = 6;
        }
      }
    }
    in.close();
  }
}