#ifndef TP1_BRAZOEXCAVADOR_H
#define TP1_BRAZOEXCAVADOR_H

#include <string>
#include "TipoSuelo.h"

#include <iostream>


using namespace std;


class BrazoExcavador {
private:
    int velocidadActualEnRPM;
    int tiempoGiroEnMinutos;
    bool giroSentidoAgujasReloj;

    void girarMecha();
    void accionarCierrePinza();
public:

    void tomarMuestra(tipoSuelo sueloActual);

};


#endif //TP1_BRAZOEXCAVADOR_H
