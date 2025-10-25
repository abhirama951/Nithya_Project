// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VLMS__pch.h"

//============================================================
// Constructors

VLMS::VLMS(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VLMS__Syms(contextp(), _vcname__, this)}
    , Clk{vlSymsp->TOP.Clk}
    , Rst{vlSymsp->TOP.Rst}
    , wb_cyc_i{vlSymsp->TOP.wb_cyc_i}
    , wb_stb_i{vlSymsp->TOP.wb_stb_i}
    , wb_we_i{vlSymsp->TOP.wb_we_i}
    , wb_ack_o{vlSymsp->TOP.wb_ack_o}
    , irq_o{vlSymsp->TOP.irq_o}
    , wb_dat_i{vlSymsp->TOP.wb_dat_i}
    , wb_dat_o{vlSymsp->TOP.wb_dat_o}
    , wb_adr_i{vlSymsp->TOP.wb_adr_i}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VLMS::VLMS(const char* _vcname__)
    : VLMS(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VLMS::~VLMS() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VLMS___024root___eval_debug_assertions(VLMS___024root* vlSelf);
#endif  // VL_DEBUG
void VLMS___024root___eval_static(VLMS___024root* vlSelf);
void VLMS___024root___eval_initial(VLMS___024root* vlSelf);
void VLMS___024root___eval_settle(VLMS___024root* vlSelf);
void VLMS___024root___eval(VLMS___024root* vlSelf);

void VLMS::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VLMS::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VLMS___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VLMS___024root___eval_static(&(vlSymsp->TOP));
        VLMS___024root___eval_initial(&(vlSymsp->TOP));
        VLMS___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VLMS___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool VLMS::eventsPending() { return false; }

uint64_t VLMS::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* VLMS::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VLMS___024root___eval_final(VLMS___024root* vlSelf);

VL_ATTR_COLD void VLMS::final() {
    VLMS___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VLMS::hierName() const { return vlSymsp->name(); }
const char* VLMS::modelName() const { return "VLMS"; }
unsigned VLMS::threads() const { return 1; }
void VLMS::prepareClone() const { contextp()->prepareClone(); }
void VLMS::atClone() const {
    contextp()->threadPoolpOnClone();
}
