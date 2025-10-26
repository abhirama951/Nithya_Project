// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLMS.h for the primary calling header

#include "VLMS__pch.h"
#include "VLMS___024root.h"

VL_ATTR_COLD void VLMS___024root___eval_static(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_static\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__Clk__0 = vlSelfRef.Clk;
    vlSelfRef.__Vtrigprevexpr___TOP__Rst__0 = vlSelfRef.Rst;
}

VL_ATTR_COLD void VLMS___024root___eval_initial(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_initial\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

VL_ATTR_COLD void VLMS___024root___eval_final(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_final\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__stl(VLMS___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool VLMS___024root___eval_phase__stl(VLMS___024root* vlSelf);

VL_ATTR_COLD void VLMS___024root___eval_settle(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_settle\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY(((0x64U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            VLMS___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("wb_lms.v", 1, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (VLMS___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelfRef.__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__stl(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___dump_triggers__stl\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VstlTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VLMS___024root___stl_sequent__TOP__0(VLMS___024root* vlSelf);

VL_ATTR_COLD void VLMS___024root___eval_stl(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_stl\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        VLMS___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void VLMS___024root___stl_sequent__TOP__0(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___stl_sequent__TOP__0\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.wb_lms__DOT__y_out = (0xffffU & ((VL_MULS_III(32, 
                                                            VL_EXTENDS_II(32,16, 
                                                                          vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                                          [0U]), 
                                                            VL_EXTENDS_II(32,16, 
                                                                          vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                          [0U])) 
                                                + (
                                                   VL_MULS_III(32, 
                                                               VL_EXTENDS_II(32,16, 
                                                                             vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                                             [1U]), 
                                                               VL_EXTENDS_II(32,16, 
                                                                             vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                             [1U])) 
                                                   + 
                                                   (VL_MULS_III(32, 
                                                                VL_EXTENDS_II(32,16, 
                                                                              vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                                              [2U]), 
                                                                VL_EXTENDS_II(32,16, 
                                                                              vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                              [2U])) 
                                                    + 
                                                    VL_MULS_III(32, 
                                                                VL_EXTENDS_II(32,16, 
                                                                              vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                                              [3U]), 
                                                                VL_EXTENDS_II(32,16, 
                                                                              vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                              [3U]))))) 
                                               >> 0xcU));
    vlSelfRef.wb_lms__DOT__dut__DOT__wn_u0 = (0xffffU 
                                              & (vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                 [0U] 
                                                 + 
                                                 (VL_MULS_III(32, (IData)(0x800U), 
                                                              VL_EXTENDS_II(32,16, 
                                                                            (0xffffU 
                                                                             & (VL_MULS_III(32, 
                                                                                VL_EXTENDS_II(32,16, (IData)(vlSelfRef.wb_lms__DOT__dut__DOT__err_reg)), 
                                                                                VL_EXTENDS_II(32,16, 
                                                                                vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                                [0U])) 
                                                                                >> 0xcU)))) 
                                                  >> 0xcU)));
    vlSelfRef.wb_lms__DOT__dut__DOT__wn_u1 = (0xffffU 
                                              & (vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                 [1U] 
                                                 + 
                                                 (VL_MULS_III(32, (IData)(0x800U), 
                                                              VL_EXTENDS_II(32,16, 
                                                                            (0xffffU 
                                                                             & (VL_MULS_III(32, 
                                                                                VL_EXTENDS_II(32,16, (IData)(vlSelfRef.wb_lms__DOT__dut__DOT__err_reg)), 
                                                                                VL_EXTENDS_II(32,16, 
                                                                                vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                                [1U])) 
                                                                                >> 0xcU)))) 
                                                  >> 0xcU)));
    vlSelfRef.wb_lms__DOT__dut__DOT__wn_u2 = (0xffffU 
                                              & (vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                 [2U] 
                                                 + 
                                                 (VL_MULS_III(32, (IData)(0x800U), 
                                                              VL_EXTENDS_II(32,16, 
                                                                            (0xffffU 
                                                                             & (VL_MULS_III(32, 
                                                                                VL_EXTENDS_II(32,16, (IData)(vlSelfRef.wb_lms__DOT__dut__DOT__err_reg)), 
                                                                                VL_EXTENDS_II(32,16, 
                                                                                vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                                [2U])) 
                                                                                >> 0xcU)))) 
                                                  >> 0xcU)));
    vlSelfRef.wb_lms__DOT__dut__DOT__wn_u3 = (0xffffU 
                                              & (vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                 [3U] 
                                                 + 
                                                 (VL_MULS_III(32, (IData)(0x800U), 
                                                              VL_EXTENDS_II(32,16, 
                                                                            (0xffffU 
                                                                             & (VL_MULS_III(32, 
                                                                                VL_EXTENDS_II(32,16, (IData)(vlSelfRef.wb_lms__DOT__dut__DOT__err_reg)), 
                                                                                VL_EXTENDS_II(32,16, 
                                                                                vlSelfRef.wb_lms__DOT__dut__DOT__x
                                                                                [3U])) 
                                                                                >> 0xcU)))) 
                                                  >> 0xcU)));
}

VL_ATTR_COLD void VLMS___024root___eval_triggers__stl(VLMS___024root* vlSelf);

VL_ATTR_COLD bool VLMS___024root___eval_phase__stl(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_phase__stl\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    VLMS___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelfRef.__VstlTriggered.any();
    if (__VstlExecute) {
        VLMS___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__act(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___dump_triggers__act\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge Clk)\n");
    }
    if ((2ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(posedge Rst)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__nba(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___dump_triggers__nba\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge Clk)\n");
    }
    if ((2ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(posedge Rst)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VLMS___024root___ctor_var_reset(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___ctor_var_reset\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelf->Clk = VL_RAND_RESET_I(1);
    vlSelf->Rst = VL_RAND_RESET_I(1);
    vlSelf->wb_cyc_i = VL_RAND_RESET_I(1);
    vlSelf->wb_stb_i = VL_RAND_RESET_I(1);
    vlSelf->wb_we_i = VL_RAND_RESET_I(1);
    vlSelf->wb_adr_i = VL_RAND_RESET_I(32);
    vlSelf->wb_dat_i = VL_RAND_RESET_I(16);
    vlSelf->wb_dat_o = VL_RAND_RESET_I(16);
    vlSelf->wb_ack_o = VL_RAND_RESET_I(1);
    vlSelf->irq_o = VL_RAND_RESET_I(1);
    vlSelf->wb_lms__DOT__x_in_reg = VL_RAND_RESET_I(16);
    vlSelf->wb_lms__DOT__d_in_reg = VL_RAND_RESET_I(16);
    vlSelf->wb_lms__DOT__mode_train_reg = VL_RAND_RESET_I(1);
    vlSelf->wb_lms__DOT__y_out = VL_RAND_RESET_I(16);
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->wb_lms__DOT__dut__DOT__wn[__Vi0] = VL_RAND_RESET_I(16);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->wb_lms__DOT__dut__DOT__x[__Vi0] = VL_RAND_RESET_I(16);
    }
    vlSelf->wb_lms__DOT__dut__DOT__err_reg = VL_RAND_RESET_I(16);
    vlSelf->wb_lms__DOT__dut__DOT__wn_u0 = VL_RAND_RESET_I(16);
    vlSelf->wb_lms__DOT__dut__DOT__wn_u1 = VL_RAND_RESET_I(16);
    vlSelf->wb_lms__DOT__dut__DOT__wn_u2 = VL_RAND_RESET_I(16);
    vlSelf->wb_lms__DOT__dut__DOT__wn_u3 = VL_RAND_RESET_I(16);
    vlSelf->__Vtrigprevexpr___TOP__Clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__Rst__0 = VL_RAND_RESET_I(1);
}
