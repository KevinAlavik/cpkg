#include <stdio.h>
#include <stdlib.h>
#include "lib/lazy.h"

int main()
{
    int numbers[] = { 5, 2, 9, 1, 7 };
    int numCount = sizeof(numbers) / sizeof(numbers[0]);

    printf("Numbers: ");
    lazy_print(numbers, numCount);

    int maxNum = lazy_max(numbers, numCount);
    printf("Biggest number: %d\n", maxNum);

    int minNum = lazy_min(numbers, numCount);
    printf("Smallest number: %d\n", minNum);

    lazy_sort(numbers, numCount);
    printf("Sorted numbers: ");
    lazy_print(numbers, numCount);

    return 0;
}
