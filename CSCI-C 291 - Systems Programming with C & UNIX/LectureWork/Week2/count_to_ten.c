#include <stdio.h>

int count_to_ten (int count) {
	if (count < 10) {
		printf("%d\n", count);
		count_to_ten (count + 1);
	}
	printf("%d\n", count);
}

int main () {
	count_to_ten (0);
	return 0;
}
