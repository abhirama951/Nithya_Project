module wb_lms (
    input  wire        Clk,
    input  wire        Rst,
    input  wire        wb_cyc_i,
    input  wire        wb_stb_i,
    input  wire        wb_we_i,
    input  wire [31:0] wb_adr_i,
    input  wire [15:0] wb_dat_i,
    output reg  [15:0] wb_dat_o,
    output reg         wb_ack_o,
    output reg         irq_o
);

    // -----------------------------
    // LMS interface signals
    // -----------------------------
    reg signed [15:0] x_in_reg, d_in_reg;
    reg mode_train_reg;
    wire signed [15:0] y_out, err, w0, w1, w2, w3;

    LMS dut (
        .Clk(Clk),
        .Rst(Rst),
        .mode_train(mode_train_reg),
        .x_in(x_in_reg),
        .d_in(d_in_reg),
        .y_out(y_out),
        .err(err),
        .w0(w0),
        .w1(w1),
        .w2(w2),
        .w3(w3)
    );

    // -----------------------------
    // Wishbone logic
    // -----------------------------
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            wb_ack_o       <= 0;
            wb_dat_o       <= 0;
            irq_o          <= 0;
            x_in_reg       <= 0;
            d_in_reg       <= 0;
            mode_train_reg <= 0;
        end else begin
            wb_ack_o <= 0;
            irq_o    <= 0;
            if (wb_cyc_i && wb_stb_i && !wb_ack_o) begin
                wb_ack_o <= 1;
                if (wb_we_i) begin
                    case (wb_adr_i[5:2])
                        4'h0: x_in_reg       <= wb_dat_i;
                        4'h1: d_in_reg       <= wb_dat_i;
                        4'h2: mode_train_reg <= wb_dat_i[0]; // only LSB
                    endcase
                    irq_o <= 1; // optional interrupt on write
                end else begin
                    case (wb_adr_i[5:2])
                        4'h3: wb_dat_o <= y_out;
                        4'h4: wb_dat_o <= err;
                        4'h5: wb_dat_o <= w0;
                        4'h6: wb_dat_o <= w1;
                        4'h7: wb_dat_o <= w2;
                        4'h8: wb_dat_o <= w3;
                        default: wb_dat_o <= 16'd0;
                    endcase
                end
            end
        end
    end

endmodule

