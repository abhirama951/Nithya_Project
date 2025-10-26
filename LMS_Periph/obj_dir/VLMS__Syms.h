// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLMS__SYMS_H_
#define VERILATED_VLMS__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "VLMS.h"

// INCLUDE MODULE CLASSES
#include "VLMS___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)VLMS__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    VLMS* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    VLMS___024root                 TOP;

    // CONSTRUCTORS
    VLMS__Syms(VerilatedContext* contextp, const char* namep, VLMS* modelp);
    ~VLMS__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
