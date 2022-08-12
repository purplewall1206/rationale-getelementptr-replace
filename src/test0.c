#include <stdio.h>
#include <stdlib.h>

struct s
{
#ifdef ERA_S
    unsigned long *metadata;
#endif
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

// member: total length, including metadata
// start/end, the randomize index range [start, end]
unsigned long *f_n_y_shuffle(int members, int start, int end) 
{
    if (end > members || start >= end) {
        return NULL;
    } 
    unsigned long *offsets = (unsigned long *) malloc(members * sizeof(unsigned long));
    for (int i = 0;i < members;i++) {
        offsets[i] = i * 8;
    }
    for (int i = start;i < end;i++) {
        int randindex = (rand() % (end - start + 1)) + start;
        if (randindex != i) {
            int tmp = offsets[i];
            offsets[i] = offsets[randindex];
            offsets[randindex] = tmp;
        }
    }
    return offsets;
}

// metadata is the first member, so addr(base) == addr(metadata)
// return an address 
unsigned long get_rand_member_offset(unsigned long base, int index)
{
    unsigned long *metadata = base;
    printf("\t\toutput: %016lx\n", metadata[index] + base);
    return metadata[index] + base;
}

// clang-12 -DERA_S=1 test0.c -o test-define
// clang-12 -DERA_S=1 -emit-llvm -S test0.c -o test0-define.ll

void print(unsigned long x) {
    printf("output: %016lx\n", x);
}

int main()
{
    struct s *x = (struct s *)malloc(sizeof(struct s));
#ifdef ERA_S
    x->metadata = f_n_y_shuffle(5, 1, 3);
#endif

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
