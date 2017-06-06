/**
 * gcc main.c -D_CALCUL_AIRE && ./a.out
 * gcc main.c && ./a.out
 */

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/random.h>

#define H 3.35
#define I 2.55
#define J 3.59
#define K 2.80
#define L 3.49
#define M 0.22
#define N 0.28
#define O 1.36
#define P 2.04

#define M1  (M * I)
#define M2  (M * J)
#define N1  (N * K)
#define N2  (N * L)
#define MIN (M * I + N * K + O)
#define MAX (M * J + N * L + P)

double f3(double h) {
    if(O <= h && h <= P)
        return 1/(P-O);
    else
        return 0;
}

double ft(double h) {
    int n = 900;
    int m = 900;

#ifdef _CALCUL_AIRE
    /* calcul si les domaines sont D4 et D5 */
    double dx = (M2-M1)/m;
    double dy = (N2-N1)/n;
#else
    /* calcul si les domaines sont H4 et H5 */
    double dx = (M*H-M1)/m;
    double dy = (N*H-N1)/n;
#endif
    double sum = 0;
    for(int j = 0; j < n; j++) {
        for(int i = 0; i < m; i++) {
            double x = M1 + i * dx;
            double y = N1 + j * dy;

            sum += f3(h-x-y)*dx*dy;
        }
    }

    return (1/(M2-M1))*(1/(N2-N1))*sum;
}

double Ft(double h) {
    int n = 2000;

    double dh = (h-MIN)/n;
    double sum = 0;
    for(int i = 0; i < n; i++) {
        double t = MIN + i * dh;

        sum += ft(t)*dh;
    }

    return sum;
}

double simulate(uint64_t n) {
    uint32_t* buf1 = malloc(sizeof(uint32_t)*n);
    uint32_t* buf2 = malloc(sizeof(uint32_t)*n);
    uint32_t* buf3 = malloc(sizeof(uint32_t)*n);

    getrandom((void*) buf1, sizeof(uint32_t)*n, 0);
    getrandom((void*) buf2, sizeof(uint32_t)*n, 0);
    getrandom((void*) buf3, sizeof(uint32_t)*n, 0);

    uint64_t count = 0;
    for(int i = 0; i < n; i++) {
        double t1 = buf1[i];
        double t2 = buf2[i];
        double t3 = buf3[i];

        double h1 = t1*((J-I)/0xFFFFFFFF)+I;
        double h2 = t2*((L-K)/0xFFFFFFFF)+K;
        double h3 = t3*((P-O)/0xFFFFFFFF)+O;

        double ht = M*h1+N*h2+h3;
        if(ht <= H && h1 <= H && h2 <= H)
            count++;
    }

    free(buf1);
    free(buf2);
    free(buf3);

    return ((double) count)/((double) n);
}



int main() {
#ifdef _CALCUL_AIRE
    printf("%f\n", Ft(MAX));
#else
    printf("%f\n", simulate(8000000));
    printf("%f\n", Ft(H));
#endif

    return 0;
}
