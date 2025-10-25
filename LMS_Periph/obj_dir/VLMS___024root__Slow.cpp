// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLMS.h for the primary calling header

#include "VLMS__pch.h"
#include "VLMS__Syms.h"
#include "VLMS___024root.h"

void VLMS___024root___ctor_var_reset(VLMS___024root* vlSelf);

VLMS___024root::VLMS___024root(VLMS__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VLMS___024root___ctor_var_reset(this);
}

void VLMS___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

VLMS___024root::~VLMS___024root() {
}
