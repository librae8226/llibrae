#include <stdio.h>
#include <stdlib.h>
#include "math/fast_inverse_sqrt.h"

int main(void)
{
    float num;
    int ret;

    printf("Hello, llibrae ~\n");

    ret = scanf("%f", &num);
    while(num != 0)
    {
        printf("%f", InverseSquareRoot(num));
        ret = scanf("%f", &num);
    }

    return 0;
}

