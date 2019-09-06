/*
 * Torsion.cpp
 *
 *  Created on: 31/08/2019
 *      Author: alfonso
 */


#include "Torsion.hpp"

Torsion::Torsion(int avance, int paso, vector<EntradaR> &vrec,
		vector<EntradaD> &dicc, vector<string> &vscl) :
		vrec(vrec), vdiccionario(dicc), vscl(vscl), idc(0), pdm_host(nullptr) {
	this->avance = avance;
	this->paso = paso;
}

/**
 *
 */
void Torsion::calculaTorsion() {
	size_t tam = vrec.size();

	for (size_t i = avance; i < tam; i += paso) {

		size_t tamo = vrec[i].voracion.size();
		for (size_t j = 0; j < tamo; j++) {
			vector<string> vcon;
			string &sidea = vrec[i].voracion[j];
			remueveCarL(sidea);
			split(vcon, sidea, " ");
			vector<size_t> vaux;
			for (string scon : vcon) {

				size_t id = concepto2id(scon);
				vaux.push_back(id);

			}
			vrec[i].vvidc.push_back(vaux);
		}
	}

	cout << "Total de conceptos empleados (vectores): " << idc << " ("
			<< idc * sizeof(float) * TAMV << ") bytes" << endl;

	cout << "Total de recursos (vector torsion): " << vrec.size() << " ("
			<< vrec.size() * sizeof(float) * TAMV << ") bytes" << endl;

	calculaTorsionC();
}

/**
 * Metodo que llama al codigo de CUDA para el calculo de la Torsion, aloja memoria y genera los
 * vectores necesarios tanto en Host como en Device
 */
void Torsion::calculaTorsionC() {
	//diccionario
	pdm_host = new float[idc * TAMV];
	generaDiccionarioMin();

	//vectores de torsion (resultados)
	prec_host = new float[vrec.size() * TAMV];



	//array que define la entradas de los recursos inicio y fin (posicion de las oraciones)
	this->pentradarmin_host = new EntradaRmin[vrec.size()];

	size_t tam_total=this->generaOraciones();

	cout << "Tam total size_t: "<<tam_total<<" reportado por oraciones: "<<sizeof(this->proracion_host)<<endl;


	// Se definen memoria para el dispositivo

	float *pdm_device= nullptr;


	//se aloja la memoria en el dispositivo
	cudaMalloc((void**) &(pdm_device), idc*TAMV * sizeof(float));




	//se libera la memoria en el dispositivo
	cudaFree(pdm_device);


	//se libera memoria en el host
	for(size_t i=0;i<this->num_oraciones;i++){
		delete[] this->proracion_host[i];
	}
	delete[] this->proracion_host;

	delete[] this->pentradarmin_host;


	delete[] prec_host;
	delete[] pdm_host;
}

/**
 *
 * @param theStringVector
 * @param theString
 * @param theDelimiter
 */
void Torsion::split(vector<string> &theStringVector, const string &theString,
		const string &theDelimiter) {
	size_t start = 0, end = 0;

	while (end != string::npos) {
		end = theString.find(theDelimiter, start);

		// If at end, use length=maxLength.  Else use length=end-start.
		theStringVector.push_back(
				theString.substr(start,
						(end == string::npos) ? string::npos : end - start));

		// If at end, use start=maxSize.  Else use start=end+delimiter.
		start = (
				(end > (string::npos - theDelimiter.size())) ?
						string::npos : end + theDelimiter.size());
	}
}

Torsion::~Torsion() {

}


/**
 *
 * @param dicc
 * @param scad
 * @return
 */
size_t Torsion::concepto2id(string &scad) {

	boost::trim_right(scad);
	boost::trim_left(scad);

	if (scad.size() > 0) {

		for (EntradaD &e : vdiccionario) {

			if (e.concepto == scad) {
				if (e.idc == -1) {
					e.idc = idc;
					idc++;
				}
				return e.idc;
			}
		}
	}

	return -1;
}


/**
 * @see https://stackoverflow.com/questions/20326356/how-to-remove-all-the-occurrences-of-a-char-in-c-string
 * @param scad
 * @return
 */
void Torsion::remueveCarL(string &scad) {
	for (auto sb : vscl) {
		boost::replace_all(scad, sb, " ");
	}
}

/**
 *
 */
void Torsion::generaDiccionarioMin() {
	cout <<"Se genera el diccionario minimo"<<endl;
	for (auto &vaux : vdiccionario) {
		if (vaux.idc >= 0) {
			for (size_t i = 0; i < TAMV; i++) {
				*(pdm_host + TAMV * vaux.idc + i) = vaux.v[i];
			}
			//cout << vaux.idc<<": "<<vaux.concepto<<endl;
		}
	}
}

size_t Torsion::generaOraciones() {

	num_oraciones = 0;

	for (auto rec_aux : vrec) {
		num_oraciones += rec_aux.voracion.size();
	}

	this->proracion_host = new size_t*[num_oraciones];

	size_t tam_total=0;
	size_t tam_vrec = vrec.size();
	size_t i = 0;
	for (size_t k = 0; k < tam_vrec; k++) {
		(this->pentradarmin_host + k)->inicio = i;
		for (auto v1 : vrec[k].vvidc) {

			size_t tam = v1.size();
			tam_total+=tam;
			this->proracion_host[i] = new size_t[tam];
			for (size_t j = 0; j < tam; j++) {
				this->proracion_host[i][j] = v1[j];
			}
			(this->pentradarmin_host + k)->fin = i;
			i++;
		}

	}

	return tam_total;
}

