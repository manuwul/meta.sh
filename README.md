# Meta.sh
Simple bash script for compile-time code evaluation

## Example
main.c:
```c
#define FOUR `print(2+2)`
int main() {
    return 0;
}
```
After executing `meta.sh` gen_main.c generated:
```c
#define FOUR 4
int main() {
    return 0;
}
```

## Limitations
- Whole file loads into memory (if this is an issue for you - just buy more RAM).
- You cannot just write `2+2`, you need to print it.
