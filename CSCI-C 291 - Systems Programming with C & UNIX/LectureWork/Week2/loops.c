#include<stdio.h>

void main (){

	int num, value, sum;
	printf("Enter any number");
	scanf("%d",&num);

	while (num>0){
		value = num%10;
		sum = sum+value;
		num = num/10;
	}
	printf("The given number is an armstrong number");
}
