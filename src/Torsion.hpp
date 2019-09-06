/*
 * Torsion.hpp
 *
 *  Created on: 31/08/2019
 *      Author: alfonso
 */


#include <iostream>
#include <vector>
#include <string>
#include <cmath>
#include <algorithm>

#include <boost/algorithm/string.hpp>

#include <cuda.h>




#include "Comun.hpp"
#include "EntradaD.hpp"
#include "EntradaR.hpp"



#ifndef TORSION_HPP_
#define TORSION_HPP_



using namespace std;

class Torsion {

public:

	Torsion(int avance, int paso, vector<EntradaR> &vrec,
			vector<EntradaD> &dicc, vector<string> &vscl);

	void calculaTorsion();

	void split(vector<string>& theStringVector, const string& theString, const string& theDelimiter);

	virtual ~Torsion();

private:
	int avance;
	int paso;
	size_t idc;

	vector<EntradaR>& vrec;
	vector<EntradaD>& vdiccionario;

	vector<string>& vscl;

	//puntero a diccionario minimo en host
	float *pdm_host;

	//puntero a recurso vector torsion en host
	float *prec_host;

	//puntero a oraciones para cada recurso
	size_t **proracion_host;

	//total de oraciones en todos los registros
	size_t num_oraciones;

	PEntradaRmin pentradarmin_host;


	size_t concepto2id(string &scad);

    void remueveCarL(string &scad);

    void calculaTorsionC();

    void generaDiccionarioMin();

    size_t generaOraciones();
};

#endif /* TORSION_HPP_ */
