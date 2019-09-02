/*
 * DBOper.hpp
 *
 *  Created on: 31/08/2019
 *      Author: alfonso
 */



#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <cctype>
#include <pqxx/pqxx>

#include "EntradaD.hpp"
#include "EntradaR.hpp"
#include "Comun.hpp"


#ifndef DBOPER_HPP_
#define DBOPER_HPP_


using namespace std;


class DBOper {

public:
    DBOper(string sarchconf);
    void recuperaContenidos(string smodulo, vector<EntradaR> &vr);

private:
    string sarchivo;
    vector<string> credenciales;



    void abreConexion(void);

    void abreArchivo();

    void split(vector<string> &theStringVector, const string &theString, const string &theDelimiter);



};


#endif /* DBOPER_HPP_ */
