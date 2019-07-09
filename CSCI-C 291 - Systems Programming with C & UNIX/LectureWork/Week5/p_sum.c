#include<stdio.h>
#include<string.h>

typedef struct point {
  int x;
  int y;
} point_t;

struct point p;
struct point q;
p.x = 1;
p.y = 2;
q.y = 3;
q.x = 4;

int p_sum (struct point *p2) {
  p2->x= p2->x + p2->y;
  return (p2->x);
}

struct point a;
a.x = 1;
a.y = 2;

int main(void) {
  printf("%d\n", p_sum(&a));
  printf("%d\n", a.x);
}
