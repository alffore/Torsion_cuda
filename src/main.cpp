/*
 * main.cpp
 *
 *  Created on: 31/08/2019
 *      Author: alfonso
 */


#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <algorithm>



#include "Comun.hpp"
#include "EntradaD.hpp"
#include "DBOper.hpp"
#include "Torsion.hpp"
#include "Diccionario.hpp"




using namespace std;


vector<EntradaD> vdiccionario;

vector<EntradaR> vrec;


vector<string> vscl={"<br>","</br>","\n","\t","</b>","<b>","<li>","</li>",",",":",";","/",
		"\\","#","$","!","(",")",">","<","¿","?","|","^","'","\""};





/**
 *
 * @return
 */
int main() {

    string smodulo="museo";

    cout << "Se carga el vdiccionario" << endl;
    Diccionario dicc(vdiccionario, "/home/alfonso/NetBeansProjects/renic/utiles/texto_todos/vectors_sic.txt");

    cout <<"Total de entradas Diccionario: "<<vdiccionario.size()<<endl;

    cout << "Se recuperan los registros para "<<smodulo << " de la BD" << endl;
    DBOper mdb("dbrenic.txt");

    mdb.recuperaContenidos(smodulo, vrec);
    cout << "Tam. vrec: " << vrec.size() << endl;


    cout << "Se calcula la torsion para los registros" << endl;

    Torsion mit(0,1,vrec,vdiccionario,vscl);

    mit.calculaTorsion();


    ofstream miarchivo(smodulo+"_sal.sql");
    for (EntradaR e: vrec) {
        miarchivo << "INSERT INTO ideas VALUES('" << e.stabla << "'," << e.id << ",{";


        miarchivo<<e.vtorsion[0];
        for(size_t i=1;i<TAMV;i++){
            miarchivo<<","<<e.vtorsion[i];
        }

        miarchivo << "});";
        miarchivo << "\n";
    }
    miarchivo.close();

    return 0;
}

