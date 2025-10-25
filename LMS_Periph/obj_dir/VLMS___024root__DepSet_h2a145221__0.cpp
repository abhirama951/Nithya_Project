// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VLMS.h for the primary calling header

#include "VLMS__pch.h"
#include "VLMS___024root.h"

void VLMS___024root___eval_act(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_act\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void VLMS___024root___nba_sequent__TOP__0(VLMS___024root* vlSelf);

void VLMS___024root___eval_nba(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_nba\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VLMS___024root___nba_sequent__TOP__0(vlSelf);
    }
}

VL_INLINE_OPT void VLMS___024root___nba_sequent__TOP__0(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___nba_sequent__TOP__0\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __Vdly__wb_ack_o;
    __Vdly__wb_ack_o = 0;
    SData/*15:0*/ __Vdly__wb_lms__DOT__dut__DOT__err_reg;
    __Vdly__wb_lms__DOT__dut__DOT__err_reg = 0;
    CData/*0:0*/ __VdlySet__wb_lms__DOT__dut__DOT__x__v0;
    __VdlySet__wb_lms__DOT__dut__DOT__x__v0 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__x__v4;
    __VdlyVal__wb_lms__DOT__dut__DOT__x__v4 = 0;
    CData/*0:0*/ __VdlySet__wb_lms__DOT__dut__DOT__x__v4;
    __VdlySet__wb_lms__DOT__dut__DOT__x__v4 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__x__v5;
    __VdlyVal__wb_lms__DOT__dut__DOT__x__v5 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__x__v6;
    __VdlyVal__wb_lms__DOT__dut__DOT__x__v6 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__x__v7;
    __VdlyVal__wb_lms__DOT__dut__DOT__x__v7 = 0;
    CData/*0:0*/ __VdlySet__wb_lms__DOT__dut__DOT__wn__v0;
    __VdlySet__wb_lms__DOT__dut__DOT__wn__v0 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__wn__v4;
    __VdlyVal__wb_lms__DOT__dut__DOT__wn__v4 = 0;
    CData/*0:0*/ __VdlySet__wb_lms__DOT__dut__DOT__wn__v4;
    __VdlySet__wb_lms__DOT__dut__DOT__wn__v4 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__wn__v5;
    __VdlyVal__wb_lms__DOT__dut__DOT__wn__v5 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__wn__v6;
    __VdlyVal__wb_lms__DOT__dut__DOT__wn__v6 = 0;
    SData/*15:0*/ __VdlyVal__wb_lms__DOT__dut__DOT__wn__v7;
    __VdlyVal__wb_lms__DOT__dut__DOT__wn__v7 = 0;
    // Body
    __Vdly__wb_ack_o = vlSelfRef.wb_ack_o;
    __Vdly__wb_lms__DOT__dut__DOT__err_reg = vlSelfRef.wb_lms__DOT__dut__DOT__err_reg;
    __VdlySet__wb_lms__DOT__dut__DOT__wn__v0 = 0U;
    __VdlySet__wb_lms__DOT__dut__DOT__wn__v4 = 0U;
    __VdlySet__wb_lms__DOT__dut__DOT__x__v0 = 0U;
    __VdlySet__wb_lms__DOT__dut__DOT__x__v4 = 0U;
    if (vlSelfRef.Rst) {
        __Vdly__wb_lms__DOT__dut__DOT__err_reg = 0U;
        __VdlySet__wb_lms__DOT__dut__DOT__wn__v0 = 1U;
        __VdlySet__wb_lms__DOT__dut__DOT__x__v0 = 1U;
        __Vdly__wb_ack_o = 0U;
        vlSelfRef.wb_dat_o = 0U;
        vlSelfRef.irq_o = 0U;
        vlSelfRef.wb_lms__DOT__x_in_reg = 0U;
        vlSelfRef.wb_lms__DOT__d_in_reg = 0U;
        vlSelfRef.wb_lms__DOT__mode_train_reg = 0U;
    } else {
        if (vlSelfRef.wb_lms__DOT__mode_train_reg) {
            __Vdly__wb_lms__DOT__dut__DOT__err_reg 
                = (0xffffU & ((IData)(vlSelfRef.wb_lms__DOT__d_in_reg) 
                              - (IData)(vlSelfRef.wb_lms__DOT__y_out)));
            __VdlyVal__wb_lms__DOT__dut__DOT__wn__v4 
                = vlSelfRef.wb_lms__DOT__dut__DOT__wn_u0;
            __VdlySet__wb_lms__DOT__dut__DOT__wn__v4 = 1U;
            __VdlyVal__wb_lms__DOT__dut__DOT__wn__v5 
                = vlSelfRef.wb_lms__DOT__dut__DOT__wn_u1;
            __VdlyVal__wb_lms__DOT__dut__DOT__wn__v6 
                = vlSelfRef.wb_lms__DOT__dut__DOT__wn_u2;
            __VdlyVal__wb_lms__DOT__dut__DOT__wn__v7 
                = vlSelfRef.wb_lms__DOT__dut__DOT__wn_u3;
        } else {
            __Vdly__wb_lms__DOT__dut__DOT__err_reg = 0U;
        }
        __VdlyVal__wb_lms__DOT__dut__DOT__x__v4 = vlSelfRef.wb_lms__DOT__dut__DOT__x
            [2U];
        __VdlySet__wb_lms__DOT__dut__DOT__x__v4 = 1U;
        __VdlyVal__wb_lms__DOT__dut__DOT__x__v5 = vlSelfRef.wb_lms__DOT__dut__DOT__x
            [1U];
        __VdlyVal__wb_lms__DOT__dut__DOT__x__v6 = vlSelfRef.wb_lms__DOT__dut__DOT__x
            [0U];
        __VdlyVal__wb_lms__DOT__dut__DOT__x__v7 = vlSelfRef.wb_lms__DOT__x_in_reg;
        __Vdly__wb_ack_o = 0U;
        vlSelfRef.irq_o = 0U;
        if ((((IData)(vlSelfRef.wb_cyc_i) & (IData)(vlSelfRef.wb_stb_i)) 
             & (~ (IData)(vlSelfRef.wb_ack_o)))) {
            __Vdly__wb_ack_o = 1U;
            if (vlSelfRef.wb_we_i) {
                if ((0U == (0xfU & (vlSelfRef.wb_adr_i 
                                    >> 2U)))) {
                    vlSelfRef.wb_lms__DOT__x_in_reg 
                        = vlSelfRef.wb_dat_i;
                } else if ((1U == (0xfU & (vlSelfRef.wb_adr_i 
                                           >> 2U)))) {
                    vlSelfRef.wb_lms__DOT__d_in_reg 
                        = vlSelfRef.wb_dat_i;
                } else if ((2U == (0xfU & (vlSelfRef.wb_adr_i 
                                           >> 2U)))) {
                    vlSelfRef.wb_lms__DOT__mode_train_reg 
                        = (1U & (IData)(vlSelfRef.wb_dat_i));
                }
                vlSelfRef.irq_o = 1U;
            } else {
                vlSelfRef.wb_dat_o = ((0x20U & vlSelfRef.wb_adr_i)
                                       ? ((0x10U & vlSelfRef.wb_adr_i)
                                           ? 0U : (
                                                   (8U 
                                                    & vlSelfRef.wb_adr_i)
                                                    ? 0U
                                                    : 
                                                   ((4U 
                                                     & vlSelfRef.wb_adr_i)
                                                     ? 0U
                                                     : 
                                                    vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                    [3U])))
                                       : ((0x10U & vlSelfRef.wb_adr_i)
                                           ? ((8U & vlSelfRef.wb_adr_i)
                                               ? ((4U 
                                                   & vlSelfRef.wb_adr_i)
                                                   ? 
                                                  vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                  [2U]
                                                   : 
                                                  vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                  [1U])
                                               : ((4U 
                                                   & vlSelfRef.wb_adr_i)
                                                   ? 
                                                  vlSelfRef.wb_lms__DOT__dut__DOT__wn
                                                  [0U]
                                                   : (IData)(vlSelfRef.wb_lms__DOT__dut__DOT__err_reg)))
                                           : ((8U & vlSelfRef.wb_adr_i)
                                               ? ((4U 
                                                   & vlSelfRef.wb_adr_i)
                                                   ? (IData)(vlSelfRef.wb_lms__DOT__y_out)
                                                   : 0U)
                                               : 0U)));
            }
        }
    }
    if (__VdlySet__wb_lms__DOT__dut__DOT__x__v0) {
        vlSelfRef.wb_lms__DOT__dut__DOT__x[0U] = 0U;
        vlSelfRef.wb_lms__DOT__dut__DOT__x[1U] = 0U;
        vlSelfRef.wb_lms__DOT__dut__DOT__x[2U] = 0U;
        vlSelfRef.wb_lms__DOT__dut__DOT__x[3U] = 0U;
    }
    if (__VdlySet__wb_lms__DOT__dut__DOT__x__v4) {
        vlSelfRef.wb_lms__DOT__dut__DOT__x[3U] = __VdlyVal__wb_lms__DOT__dut__DOT__x__v4;
        vlSelfRef.wb_lms__DOT__dut__DOT__x[2U] = __VdlyVal__wb_lms__DOT__dut__DOT__x__v5;
        vlSelfRef.wb_lms__DOT__dut__DOT__x[1U] = __VdlyVal__wb_lms__DOT__dut__DOT__x__v6;
        vlSelfRef.wb_lms__DOT__dut__DOT__x[0U] = __VdlyVal__wb_lms__DOT__dut__DOT__x__v7;
    }
    vlSelfRef.wb_ack_o = __Vdly__wb_ack_o;
    vlSelfRef.wb_lms__DOT__dut__DOT__err_reg = __Vdly__wb_lms__DOT__dut__DOT__err_reg;
    if (__VdlySet__wb_lms__DOT__dut__DOT__wn__v0) {
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[0U] = 0U;
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[1U] = 0U;
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[2U] = 0U;
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[3U] = 0U;
    }
    if (__VdlySet__wb_lms__DOT__dut__DOT__wn__v4) {
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[0U] = __VdlyVal__wb_lms__DOT__dut__DOT__wn__v4;
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[1U] = __VdlyVal__wb_lms__DOT__dut__DOT__wn__v5;
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[2U] = __VdlyVal__wb_lms__DOT__dut__DOT__wn__v6;
        vlSelfRef.wb_lms__DOT__dut__DOT__wn[3U] = __VdlyVal__wb_lms__DOT__dut__DOT__wn__v7;
    }
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

void VLMS___024root___eval_triggers__act(VLMS___024root* vlSelf);

bool VLMS___024root___eval_phase__act(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_phase__act\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<2> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    VLMS___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        VLMS___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool VLMS___024root___eval_phase__nba(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_phase__nba\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        VLMS___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__nba(VLMS___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void VLMS___024root___dump_triggers__act(VLMS___024root* vlSelf);
#endif  // VL_DEBUG

void VLMS___024root___eval(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY(((0x64U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            VLMS___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("wb_lms.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY(((0x64U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                VLMS___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("wb_lms.v", 1, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (VLMS___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (VLMS___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void VLMS___024root___eval_debug_assertions(VLMS___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VLMS___024root___eval_debug_assertions\n"); );
    VLMS__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY(((vlSelfRef.Clk & 0xfeU)))) {
        Verilated::overWidthError("Clk");}
    if (VL_UNLIKELY(((vlSelfRef.Rst & 0xfeU)))) {
        Verilated::overWidthError("Rst");}
    if (VL_UNLIKELY(((vlSelfRef.wb_cyc_i & 0xfeU)))) {
        Verilated::overWidthError("wb_cyc_i");}
    if (VL_UNLIKELY(((vlSelfRef.wb_stb_i & 0xfeU)))) {
        Verilated::overWidthError("wb_stb_i");}
    if (VL_UNLIKELY(((vlSelfRef.wb_we_i & 0xfeU)))) {
        Verilated::overWidthError("wb_we_i");}
}
#endif  // VL_DEBUG
