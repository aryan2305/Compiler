#include <stdio.h>

int x;

main()
{
    int n;
    get(n);
    while (n >= 0)
    {
        put(n);
        n = n - 1;
    }
}