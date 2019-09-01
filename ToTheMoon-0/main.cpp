#include <iostream>
#include "LunarRover.h"
using namespace std;

int main() {

    LunarRover rover344B = LunarRover();

    while(true) {
        rover344B.obtenerTipoSuelo();
        rover344B.obtenerMuestra();
    }

    return 0;
}