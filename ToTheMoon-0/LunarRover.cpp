#include "LunarRover.h"


void LunarRover::obtenerMuestra() {
    this->brazoExcavador.tomarMuestra(this->sueloActual);
}

void LunarRover::obtenerTipoSuelo() {
    cout << "Ingrese la dureza del suelo:"<< endl;
    cin >> this->durezaSuelo;
    cout << "Ingrese la porosidad del suelo:" << endl;
    cin >> this->porosidadSuelo;

    if(this->durezaSuelo < 100) {
        this->sueloActual = polvo;
    } else {
        this->sueloActual = piedra;
    }
}