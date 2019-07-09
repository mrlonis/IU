/**
 * @author  mrlonis (Matthew Lonis)
 * @partner Christian Hutslar
 */

import static org.junit.Assert.*;
import org.junit.Test;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

public class Heapsort {

	/**
	 * Sorts the elements of a, in place, in their natural order.
	 */
	public static void sort(int[] a) {
		heapify(a);
		int n = a.length;
		while (n > 0) {
			swap(a, 0, n - 1);
			n--;
			siftDown(a, 0, n);
		}
	}

	/**
	 * Rearranges the elements of a so that they form a heap.
	 */
	public static void heapify(int[] a) {
		int n = a.length;
		int last = getParent(n - 1);
		for (int i = last; i >= 0; i--) {
			siftDown(a, i, n);
		}
	}

	/**
	 * Restores the ordering property at node p so that the first n elements of
	 * a form a heap.
	 */
	public static void siftDown(int[] a, int p, int n) {
		int leftChild = getLeft(p);
		if (leftChild <= n) {
			int maxChild = leftChild;
			int rightChild = getRight(p);

			if (rightChild <= n && a[rightChild] > a[leftChild]) {
				maxChild = rightChild;
			}
			
			if (a[maxChild] > a[p]) {
				swap(a, maxChild, p);
				siftDown(a, maxChild, n);
			}
		}
	}

	/**
	 * Exchanges the elements at indices i and j in the array a.
	 */
	public static void swap(int[] a, int i, int j) {
		int temp = a[i];
		a[i] = a[j];
		a[j] = temp;
	}

	/**
	 * Returns a logical pointer to the left child of node p.
	 */
	public static int getLeft(int p) {
		return (p * 2) + 1;
	}

	/**
	 * Returns a logical pointer to the right child of node p.
	 */
	public static int getRight(int p) {
		return (p * 2) + 2;
	}

	/**
	 * Returns a logical pointer to the parent of node p.
	 */
	public static int getParent(int p) {
		return (p - 1) / 2;
	}

	@Test
	public void gettersTest() {
		/**
		 * 0 / \ 1 2 / \ / 3 4 5
		 */
		assertEquals(1, getLeft(0));
		assertEquals(3, getLeft(1));
		assertEquals(5, getLeft(2));
		assertEquals(2, getRight(0));
		assertEquals(4, getRight(1));
		assertEquals(0, getParent(1));
		assertEquals(0, getParent(2));
		assertEquals(1, getParent(3));
		assertEquals(1, getParent(4));
		assertEquals(2, getParent(5));
	}

	@Test
	public void swapTest() {
		int[] a = new int[] { 5, 9, 8, 2, 0, 3 };
		swap(a, 0, 1);
		assertArrayEquals(new int[] { 9, 5, 8, 2, 0, 3 }, a);
		swap(a, 5, 2);
		assertArrayEquals(new int[] { 9, 5, 3, 2, 0, 8 }, a);
		swap(a, 3, 3);
		assertArrayEquals(new int[] { 9, 5, 3, 2, 0, 8 }, a);
		swap(a, a.length - 1, 0);
		assertArrayEquals(new int[] { 8, 5, 3, 2, 0, 9 }, a);
	}

	@Test
	public void siftDownTest() {
		int[] a = new int[] { 1, 2 };
		siftDown(a, 0, 2);
		assertArrayEquals(new int[] { 2, 1 }, a);
		a = new int[] { 5 };
		siftDown(a, 0, 1);
		assertArrayEquals(new int[] { 5 }, a);
		a = new int[] { 1, 2 };
		siftDown(a, 0, 1);
		assertArrayEquals(new int[] { 1, 2 }, a);
		a = new int[] { 1, 2, 3 };
		siftDown(a, 0, 3);
		assertArrayEquals(new int[] { 3, 2, 1 }, a);
		a = new int[] { 1, 9, 8, 7, 6, 5, 4, 3, 2 };
		siftDown(a, 0, 9);
		assertArrayEquals(new int[] { 9, 7, 8, 3, 6, 5, 4, 1, 2 }, a);
		int[] heap = new int[] { 25, 23, 19, 10, 18, 15, 17, 7, 5, 13, 9, 8, 14, 1, 4, 3, 6, 2 };
		int n = heap.length;
		assertTrue(verifyOrderingProperty(heap));
		heap[0] = 20;
		siftDown(heap, 0, n);
		assertArrayEquals(new int[] { 23, 20, 19, 10, 18, 15, 17, 7, 5, 13, 9, 8, 14, 1, 4, 3, 6, 2 }, heap);
		assertTrue(verifyOrderingProperty(heap));
	}

	@Test
	public void smallHeapify() {
		int[] a = new int[] { 0, 3, 9, 4, 8, 2, 5 };
		heapify(a);
		assertArrayEquals(new int[] { 9, 8, 5, 4, 3, 2, 0 }, a);
	}

	@Test
	public void bigHeapify() {
		int[] a = new int[10000];
		List<Integer> ints = new LinkedList<>();
		for (int i = 0; i < a.length; i++)
			ints.add(i);
		Random gen = new Random();
		for (int i = 0; i < a.length; i++)
			a[i] = ints.remove(gen.nextInt(ints.size()));
		heapify(a);
		assertTrue(verifyOrderingProperty(a));
	}

	@Test
	public void sortTest() {
		int[] a = new int[] { 0, 3, 9, 4, 8, 2, 5 };
		sort(a);
		assertArrayEquals(new int[] { 0, 2, 3, 4, 5, 8, 9 }, a);
		a = new int[10000];
		List<Integer> ints = new LinkedList<>();
		for (int i = 0; i < a.length; i++)
			ints.add(i);
		Random gen = new Random();
		for (int i = 0; i < a.length; i++)
			a[i] = ints.remove(gen.nextInt(ints.size()));
		sort(a);
		assertTrue(isSorted(a));
	}

	public static boolean verifyOrderingProperty(int[] heap) {
		int n = heap.length;
		int last = getParent(n - 1);
		for (int p = last; p >= 0; p--) {
			int leftChild = getLeft(p);
			if (heap[p] < heap[leftChild])
				return false;
			int rightChild = leftChild + 1;
			if (rightChild < n && heap[p] < heap[rightChild])
				return false;
		}
		return true;
	}

	public static boolean isSorted(int[] a) {
		for (int i = 1; i < a.length; i++) {
			if (a[i - 1] > a[i]) {
				return false;
			}
		}
		return true;
	}
}
