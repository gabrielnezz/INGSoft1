#include "BrazoExcavador.h"
void BrazoExcavador::accionarCierrePinza() {

    cout << "Accionando el cierre de la pinza." << endl;

}

void BrazoExcavador::girarMecha() {
    string sentido = this->giroSentidoAgujasReloj ? "de las agujas de reloj" : "contrario a las agujas de reloj";
    cout << "Voy a girar " << this->tiempoGiroEnMinutos <<
    " minutos a " << this->velocidadActualEnRPM << " rpm en sentido " << sentido << endl;
}

void BrazoExcavador::tomarMuestra(tipoSuelo sueloActual) {
    bool esSueloIntermedio = false;
    if(sueloActual == piedra){
        this->velocidadActualEnRPM = 150;
        this->tiempoGiroEnMinutos = 10;
        this->giroSentidoAgujasReloj = true;
    } else if(sueloActual == intermedio){
        esSueloIntermedio = true;
        this->velocidadActualEnRPM = 150;
        this->tiempoGiroEnMinutos = 5;
        this->giroSentidoAgujasReloj = true;
    } else {
        this->velocidadActualEnRPM = 100;
        this->tiempoGiroEnMinutos = 5;
        this->giroSentidoAgujasReloj = false;
    }

    this->girarMecha();

    this->accionarCierrePinza();

    this->giroSentidoAgujasReloj = !this->giroSentidoAgujasReloj;

    if(esSueloIntermedio){
        this->velocidadActualEnRPM = 100;
        this->tiempoGiroEnMinutos = 10;
    }

    this->girarMecha();

}