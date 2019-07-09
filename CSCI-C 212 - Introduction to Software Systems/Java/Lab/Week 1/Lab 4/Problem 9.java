/*
Assuming that

int[][] a = { { 1, 2, 3, 4},
              { 2, 3, 4}, 
              { 3, 4},
              { 4}};
              
What does this code do?

- prints 4321

int sum = 0; 
for (int i = 0; i < a.length; i++) 
  System.out.print(a[i].length); 
  
What does this code do?

- Prints 30

int sum = 0; 
for (int i = 0; i < a.length; i++) 
  for (int j = 0; j < a[i].length; j++) 
    sum += a[i][j];
System.out.println(sum);

What does this code do?

- Prints 6

int sum = 0; 
for (int i = 0; i < a.length; i++) 
  for (int j = 0; j < a[i].length; j++) 
    if (a[i][j] % 2 == 0) 
      sum += 1;
System.out.println(sum);

*/

class Problem_9 {
  public static void main(String[] args) {
    int[][] a = { { 1, 2, 3, 4},
              { 2, 3, 4}, 
              { 3, 4},
              { 4}};
    int sum = 0; 
    for (int i = 0; i < a.length; i++) 
      for (int j = 0; j < a[i].length; j++) 
      if (a[i][j] % 2 == 0) 
      sum += 1;
    System.out.println(sum);
  }
}