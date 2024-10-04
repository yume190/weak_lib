#include <stdio.h>

extern int test() __attribute__((weak_import));


int main() {
	printf("hello world\n");

	if (test != NULL) {
		printf("lib: %d\n", test());
	}
	return 0;
}