# Meta.sh
Simple bash script for compile-time code evaluation

# Usage
```
script usage: meta.sh [-m metalang] [-p paren_char] [-i input_file] [-o output_file]
-m	Set metalanguage execution command. Default: python
-p	Set parenthesis character around metacode block. Default: `
-i	Set input file. Default: main.c
-o	Set output file. Default: gen_main.c
Example: meta.sh -m python -p ` -i main.c -o gen_main.c
```
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

See [examples](./examples/) to learn more.
## Limitations
- Whole file loads into memory (if this is an issue for you - just buy more RAM).
- You cannot just write `2+2`, you need to print it.
