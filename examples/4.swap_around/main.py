big_squares=[`
#include <stdio.h>
#define ull unsigned long long
int main() {
    for (ull i = 100; i < 150; i++) {
        printf("%llu", i * i);
        if (i != 150) printf(",");
    }
    return 0;
}
`]

for square in big_squares:
    print(f"{round(square**0.5)}^2 = {square}")
