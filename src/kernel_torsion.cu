


#include "Comun.hpp"


/**
 * Funcion que calcula el valor de tensor de Levi-Civita (en espacios de dimensionalidad arbitraria)
 * https://en.wikipedia.org/wiki/Levi-Civita_symbol
 * https://www.johndcook.com/blog/2018/09/16/permutation-tensor/
 * @param i
 * @param j
 * @param k
 * @return
 */
__device__ float klcfat(float i,float j,float k){

    if (i == j || j == k || k == i) {
        return 0.0;
    }
    float aux = (j - i) * (k - i) * (k - j);

    return aux / fabs(aux);
}

/**
 *
 */
__global__ void kcalculaTorsion(){

}
