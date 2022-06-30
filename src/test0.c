#include <stdio.h>
#include <stdlib.h>

struct s
{
    unsigned long a;
    int b;
    char c;
    char d[10];
};


unsigned long func(struct s *st)
{
    // unsigned long a = st->a;
    st->a = 2;
    st->b = 6;
    st->c = 'a';
    char *d = st->d;
    d[0] = 'b';
    d[1] = 'c';

    return st->a;
}

int main()
{
    struct s *x = (struct s *)malloc(sizeof(struct s));

    unsigned long ret = func(x);

    printf("x->a: %lu\n", x->a);
    printf("x->b: %d\n", x->b);
    printf("x->c: %c\n", x->c);
    x->d[2] = 'd';
    x->d[3] = 'e';
    struct s *y = x;
    free(y);

    return 0;
}
