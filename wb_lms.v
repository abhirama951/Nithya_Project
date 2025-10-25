module wb_lms(
    input           wb_clk_i,
    input           wb_rst_i,
    input  [31:0]   wb_adr_i,
    input  [15:0]   wb_dat_i,
    output reg [15:0] wb_dat_o,
    input           wb_we_i,
    input           wb_stb_i,
    input           wb_cyc_i,
    output reg      wb_ack_o
);

    reg signed [15:0] reg_x_in, reg_d_in;
    reg reg_mode_train;
    wire signed [15:0] y_out, err, w0, w1, w2, w3;

    LMS lms_core(
        .Clk(wb_clk_i),
        .Rst(wb_rst_i),
        .mode_train(reg_mode_train),
        .x_in(reg_x_in),
        .d_in(reg_d_in),
        .y_out(y_out),
        .err(err),
        .w0(w0), .w1(w1), .w2(w2), .w3(w3)
    );

    // Wishbone write
    always @(posedge wb_clk_i or posedge wb_rst_i) begin
        if (wb_rst_i) begin
            reg_x_in <= 16'sd0;
            reg_d_in <= 16'sd0;
            reg_mode_train <= 1'b0;
            wb_ack_o <= 1'b0;
        end else begin
            wb_ack_o <= 1'b0;
            if (wb_stb_i & wb_cyc_i) begin
                wb_ack_o <= 1'b1;
                if (wb_we_i) begin
                    case(wb_adr_i[4:2])
                        3'b000: reg_x_in <= wb_dat_i;
                        3'b001: reg_d_in <= wb_dat_i;
                        3'b010: reg_mode_train <= wb_dat_i[0];
                        default: ;
                    endcase
                end
            end
        end
    end

    // Wishbone read
    always @(*) begin
        wb_dat_o = 16'd0;
        case(wb_adr_i[4:2])
            3'b011: wb_dat_o = y_out;
            3'b100: wb_dat_o = err;
            3'b101: wb_dat_o = w0;
            3'b110: wb_dat_o = w1;
            3'b111: wb_dat_o = w2;
            3'b000: wb_dat_o = w3;
        endcase
    end

endmodule

