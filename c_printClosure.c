#include "Rts.h"

void c_printClosure(StgClosure *p) {
    printf("%p\n", UNTAG_CLOSURE(p));
}
