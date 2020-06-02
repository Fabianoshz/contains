#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main() {
int *p;
int i = 1;
while(i++) {
    int inc=1024*1024*sizeof(char);
    p=(int*) calloc(1,inc);
    if(!p) break;
    }
}
