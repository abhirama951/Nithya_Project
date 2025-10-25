#include "Vwb_lms.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);
    Vwb_lms* tb = new Vwb_lms;

    VerilatedVcdC* tfp = new VerilatedVcdC;
    tb->trace(tfp, 99);
    tfp->open("wave.vcd");

    tb->Clk = 0;
    tb->Rst = 1;
    tb->wb_cyc_i = 0;
    tb->wb_stb_i = 0;
    tb->wb_we_i = 0;

    // Reset
    for (int i=0; i<5; i++) {
        tb->Clk = !tb->Clk;
        tb->eval();
        tfp->dump(i);
    }
    tb->Rst = 0;

    // Drive inputs
    for (int i=0; i<20; i++) {
        tb->x_in = i;
        tb->d_in = 2*i;  // example desired output
        tb->training_en = 1;

        tb->Clk = 1; tb->eval(); tfp->dump(10+i*2);
        tb->Clk = 0; tb->eval(); tfp->dump(11+i*2);

        printf("Time %d: y=%d, err=%d, w0=%d\n", i, tb->y_out, tb->err, tb->w0);
    }

    tfp->close();
    delete tb;
    return 0;
}

