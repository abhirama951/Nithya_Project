// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLMS.h for the primary calling header

#include "VLMS__pch.h"
#include "VLMS__Syms.h"
#include "VLMS___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__act(VLMS___024root* vlSelf);
#endif  // VL_DEBUG

void VLMS___024root___eval_triggers__act(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_triggers__act\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.setBit(0U, ((IData)(vlSelfRef.Clk) 
                                          & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__Clk__0))));
    vlSelfRef.__VactTriggered.setBit(1U, ((IData)(vlSelfRef.Rst) 
                                          & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__Rst__0))));
    vlSelfRef.__Vtrigprevexpr___TOP__Clk__0 = vlSelfRef.Clk;
    vlSelfRef.__Vtrigprevexpr___TOP__Rst__0 = vlSelfRef.Rst;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        VLMS___024root___dump_triggers__act(vlSelf);
    }
#endif
}
