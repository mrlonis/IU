import static org.junit.Assert.*;
import org.junit.Test;

/**
 * The following table shows the first ten numbers in the
 * Fibonacci sequence:
 * 
 *      n  :  0  1  2  3  4  5  6  7  8  9 ...
 *  Fib(n) :  1  1  2  3  5  8 13 21 34 55 ...
 * 
 * @author Matthew Lonis
 */

public class Fibonacci {
	/**
	 * TODO: Implement the recursive definition directly.
	 */
	public static int fib1(int n) {
		if ((n == 0) || (n == 1)) {
			return 1;
		} else {
			return fib1(n - 1) + fib1(n - 2);
		}
	}

	/**
	 * TODO: Implement recursively by calling a tail-recursive helper.
	 */
	public static int fib2(int n){
		if ((n == 0) || (n == 1)) {
			return 1;
		} else {
			return fibTail(n, 2, 1, 2);
		}
	}
  
	public static int fibTail(int n, int count, int previousNum, int currentNum) {
		if (n == count) {
			return currentNum;
		} else {
			return fibTail(n, (count + 1) , currentNum, (previousNum + currentNum) );
		}
	}

	/**
	 * TODO: Run this class as an application.
	 */
	public static void main(String... args) {
		assert fib1(9) == 55;
		assert fib2(9) == 55;
	}
  
	/**
	 * TODO: Run this class as a JUnit test. Add additional tests to
	 * the following methods.
	 */
  
	@Test
	public void testFib1() {
		assertEquals(1, fib1(0));
		assertEquals(1, fib1(1));
		assertEquals(2, fib1(2));
		assertEquals(3, fib1(3));
		assertEquals(5, fib1(4));
		assertEquals(8, fib1(5));
		assertEquals(13, fib1(6));
		assertEquals(21, fib1(7));
		assertEquals(34, fib1(8));
		assertEquals(55, fib1(9));
	}
  
	@Test
	public void testFib2() {
		assertEquals(1, fib2(0));
		assertEquals(1, fib2(1));
		assertEquals(2, fib2(2));
		assertEquals(3, fib2(3));
		assertEquals(5, fib2(4));
		assertEquals(8, fib2(5));
		assertEquals(13, fib2(6));
		assertEquals(21, fib2(7));
		assertEquals(34, fib2(8));
		assertEquals(55, fib2(9));
	}
}
