#include "Rts.h"

void printObj( StgClosure *obj );

void c_printClosure(StgClosure *p) {
    printObj(p);
}
