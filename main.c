#include <stdio.h>

static int POWERS[] = {`print(",".join(str(x**2) for x in range(50)))`};

int main() {
	for (int i = 0; i < sizeof(POWERS)/sizeof(POWERS[0]); i++) {
		printf("%d^2 = %d\n", i, POWERS[i]);
	}
	return 0;
}
