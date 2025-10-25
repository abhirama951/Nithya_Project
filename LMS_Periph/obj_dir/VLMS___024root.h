// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VLMS.h for the primary calling header

#ifndef VERILATED_VLMS___024ROOT_H_
#define VERILATED_VLMS___024ROOT_H_  // guard

#include "verilated.h"


class VLMS__Syms;

class alignas(VL_CACHE_LINE_BYTES) VLMS___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(Clk,0,0);
    VL_IN8(Rst,0,0);
    VL_IN8(wb_cyc_i,0,0);
    VL_IN8(wb_stb_i,0,0);
    VL_IN8(wb_we_i,0,0);
    VL_OUT8(wb_ack_o,0,0);
    VL_OUT8(irq_o,0,0);
    CData/*0:0*/ wb_lms__DOT__mode_train_reg;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__Clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__Rst__0;
    CData/*0:0*/ __VactContinue;
    VL_IN16(wb_dat_i,15,0);
    VL_OUT16(wb_dat_o,15,0);
    SData/*15:0*/ wb_lms__DOT__x_in_reg;
    SData/*15:0*/ wb_lms__DOT__d_in_reg;
    SData/*15:0*/ wb_lms__DOT__y_out;
    SData/*15:0*/ wb_lms__DOT__dut__DOT__err_reg;
    SData/*15:0*/ wb_lms__DOT__dut__DOT__wn_u0;
    SData/*15:0*/ wb_lms__DOT__dut__DOT__wn_u1;
    SData/*15:0*/ wb_lms__DOT__dut__DOT__wn_u2;
    SData/*15:0*/ wb_lms__DOT__dut__DOT__wn_u3;
    VL_IN(wb_adr_i,31,0);
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<SData/*15:0*/, 4> wb_lms__DOT__dut__DOT__wn;
    VlUnpacked<SData/*15:0*/, 4> wb_lms__DOT__dut__DOT__x;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<2> __VactTriggered;
    VlTriggerVec<2> __VnbaTriggered;

    // INTERNAL VARIABLES
    VLMS__Syms* const vlSymsp;

    // CONSTRUCTORS
    VLMS___024root(VLMS__Syms* symsp, const char* v__name);
    ~VLMS___024root();
    VL_UNCOPYABLE(VLMS___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
