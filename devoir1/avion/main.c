#include <stdio.h>
#include <stdint.h>
#include <sys/random.h>

#define A 30
#define B 12
#define C 18
#define D  2

#define P (A - D)
#define R (2 * C)
#define S (R - P)

#define SIZE 1024
#define K 1000000

int fill(uint8_t* siege) {
    uint32_t buf[SIZE];

    /* on recommence à nouveau */
    for(int k = 0; k < 3*R; k++)
        siege[k] = 0;

    /* on génère des bons nombres aléatoires */
    getrandom((void*) buf, sizeof(uint32_t)*SIZE, 0);

    /* on assigne des places */
    int i = B; int j = 0;
    do {
        /*
         * possibilité d'aller chercher des
         * nombres extras aléatoires avec
         * un buffer overflow
         */
        double s = (double) buf[j++];
        int r = (int) (3*R*s/0xFFFFFFFF);

        /* on alloue un siège si possible */
        if(siege[r] == 0)
            siege[r] = 1;
        else
            continue;

        i--;
    } while(i > 0);

    /* on compte les paires libres */
    int sum = 0;
    for(int k = 0; k < R; k++)
        if((siege[3*k+0] == 0 && siege[3*k+1] == 0)
        || (siege[3*k+1] == 0 && siege[3*k+2] == 0))
            sum++;

    return sum;
}


int main() {
    uint8_t siege[3*R];

    /* on exécute la simulation plusieurs fois */
    int cas = 0;
    for(int k = 0; k < K; k++)
        if (fill(siege) == P)
            cas++;

    /* on calcule la probabilité */
    printf("%f\n", ((double) cas)/((double) K));

    return 0;
}
