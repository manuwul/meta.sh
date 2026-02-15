#include <stdio.h>
#define ull unsigned long long

static ull POWERS[] = {`print(",".join(str(x**2) for x in range(50)))`};

int main() {
	for (ull i = 0; i < sizeof(POWERS)/sizeof(POWERS[0]); i++) {
		printf("%llu^2 = %llu\n", i, POWERS[i]);
	}
	return 0;
}
