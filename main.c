#include <stdio.h>

void task3(void)
{
    // TODO: Call secret function with correct arguments
 secret(1,-0x21523f22);
}

int main(void)
{
    int sum = 0;
    int underflow = task2(1 << 31, 1 << 31, &sum);
    printf("%d %d\n", underflow, sum);
    task3();
}
