# LazyPeoplePackage - lazy.h

LazyPeoplePackage is a lightweight library that provides convenient functions for lazy people to perform common operations on arrays in C.

## Functions

The package includes the following functions:

- `void lazy_print(const int* array, int size)`: Prints the elements of an array.
- `int lazy_max(const int* array, int size)`: Finds the maximum element in an array.
- `int lazy_min(const int* array, int size)`: Finds the minimum element in an array.
- `void lazy_sort(int* array, int size)`: Sorts an array in ascending order.

## Usage

1. Include the "lazy.h" header file in your C program:

```c
#include "lazy.h"
```

2. Use the functions in your program as needed. Here's an example:

```c
#include <stdio.h>
#include "lazy.h"

int main()
{
    int numbers[] = {5, 2, 9, 1, 7};
    int size = sizeof(numbers) / sizeof(numbers[0]);

    printf("Numbers: ");
    lazy_print(numbers, size);

    int maxNum = lazy_max(numbers, size);
    printf("Maximum number: %d\n", maxNum);

    int minNum = lazy_min(numbers, size);
    printf("Minimum number: %d\n", minNum);

    lazy_sort(numbers, size);
    printf("Sorted numbers: ");
    lazy_print(numbers, size);

    return 0;
}
```
