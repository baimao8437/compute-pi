#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "computepi.h"

int main(int argc, char const *argv[])
{
    double diff(double pi) {
        return (pi - M_PI > 0) ? pi - M_PI : M_PI - pi;
    }

    if (argc < 2) return -1;

    int N = atoi(argv[1]);

    // Baseline
    printf("%lf,", diff(compute_pi_baseline(N)) / M_PI);

    // OpenMP with 2 threads
    printf("%lf,", diff(compute_pi_openmp(N, 2)) / M_PI);

    // OpenMP with 4 threads
    printf("%lf,", diff(compute_pi_openmp(N, 4)) / M_PI);

    // AVX SIMD
    printf("%lf,", diff(compute_pi_avx(N)) / M_PI);

    // AVX SIMD + Loop unrolling
    printf("%lf,", diff(compute_pi_avx_unroll(N)) / M_PI);

    // Leibniz
    printf("%lf,", diff(compute_pi_leibniz(N)) / M_PI);

    // Leibniz avx
    printf("%lf,", diff(compute_pi_leibniz_avx(N)) / M_PI);

    //Nilakantha
    printf("%lf,", diff(compute_pi_nilakantha(N)) / M_PI);

    //Nilakantha avx
    printf("%lf\n", diff(compute_pi_nilakantha_avx(N)) / M_PI);
    return 0;
}
