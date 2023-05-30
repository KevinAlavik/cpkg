#ifndef LAZY_H
#define LAZY_H

#include <stdio.h>

// Function to print elements of an array
void lazy_print(const int* array, int size)
{
    for (int i = 0; i < size; ++i)
    {
        printf("%d ", array[i]);
    }
    printf("\n");
}

// Function to find the maximum element in an array
int lazy_max(const int* array, int size)
{
    int maxElement = array[0];
    for (int i = 1; i < size; ++i)
    {
        if (array[i] > maxElement)
        {
            maxElement = array[i];
        }
    }
    return maxElement;
}

// Function to find the minimum element in an array
int lazy_min(const int* array, int size)
{
    int minElement = array[0];
    for (int i = 1; i < size; ++i)
    {
        if (array[i] < minElement)
        {
            minElement = array[i];
        }
    }
    return minElement;
}

// Function to sort an array (using selection sort algorithm)
void lazy_sort(int* array, int size)
{
    for (int i = 0; i < size - 1; ++i)
    {
        int minIndex = i;
        for (int j = i + 1; j < size; ++j)
        {
            if (array[j] < array[minIndex])
            {
                minIndex = j;
            }
        }
        int temp = array[i];
        array[i] = array[minIndex];
        array[minIndex] = temp;
    }
}

#endif // LAZY_H
