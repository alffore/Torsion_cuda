/*
 * Diccionario.hpp
 *
 *  Created on: 31/08/2019
 *      Author: alfonso
 */

#ifndef DICCIONARIO_HPP_
#define DICCIONARIO_HPP_


#include <vector>
#include <string>
#include <iostream>
#include <fstream>

#include "EntradaD.hpp"
#include "Comun.hpp"



using namespace std;

class Diccionario {

private:
    string snomarch;

    void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);

    void cargaDiccionario(vector<EntradaD> &vdiccionario);

public:
    Diccionario(vector<EntradaD> &vdiccionario, string snomarch);


};





#endif /* DICCIONARIO_HPP_ */
