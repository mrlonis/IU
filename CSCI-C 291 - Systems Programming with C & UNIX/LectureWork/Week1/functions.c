#include <stdio.h>

int square(int x);
void test();

void main(){
	int m, n;
	printf("Enter some number for finding square \n");
	scanf("%d", &m);
	n = square(m);
	test();
	printf("Square of the given number %d is %d\n",m,n);
}

int square(int a){
	int p ;
	p = a * a ;
	return p ;
}

void test() {
	printf("Hello\n");
}
