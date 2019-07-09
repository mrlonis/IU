/*
Consider the following fragment, what does it print? Why?

int x = 3, y = 11;
x = x + y;
y = x - y;
x = x - y;
System.out.println("(" + x + ", " + y + ")");

It prints out (11, 3). This is because at the end of the caluclations x = 11 and y = 3. It is just printing them out as (11, 3)
*/