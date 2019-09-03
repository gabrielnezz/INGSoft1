#ifndef TP1_LUNARROVER_H
#define TP1_LUNARROVER_H


#include "BrazoExcavador.h"
#include "TipoSuelo.h"
using namespace std;

class LunarRover {


private:
    BrazoExcavador brazoExcavador;
    tipoSuelo sueloActual;
    int durezaSuelo;
    int porosidadSuelo;

public:
    void obtenerTipoSuelo();
    void obtenerMuestra();
};


#endif //TP1_LUNARROVER_H
