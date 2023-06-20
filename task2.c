#include <stdio.h>

// TODO: Freestyle starts here
int task2(int a, int b, int *sum)
{
     int s = a +b;
     (*sum) = -1;
     if (s < -128)
     (*sum) = 0;
     else
     (*sum) = 1;
     return (*sum);

}
