/*
 * EntradaR.hpp
 *
 *  Created on: 31/08/2019
 *      Author: alfonso
 */

#ifndef ENTRADAR_HPP_
#define ENTRADAR_HPP_


#include <vector>
#include <string>

#include "Comun.hpp"

class EntradaR{
public:
    std::string stabla;
    int id;

    std::vector<std::string> voracion;


    std::vector<std::vector<size_t>> vvidc;

    std::vector<float> vtorsion;

    EntradaR():vtorsion(TAMV,0.0),id(0){};

};

struct EntradaRmin{
	size_t inicio;
	size_t fin;

};

typedef EntradaRmin* PEntradaRmin;

#endif /* ENTRADAR_HPP_ */
