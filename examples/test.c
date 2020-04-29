#include <stdio.h>

int x;

int main()
{
    int n;
    get(n);
    while (n >= 0)
    {
        put(n);
        n = n - 1;
    }
}