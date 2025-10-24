module wb_lms #(
  parameter FIFO_DEPTH = 256
)(
  input  wire        Clk,
  input  wire        Rst,
  input  wire        wb_cyc_i,
  input  wire        wb_stb_i,
  input  wire        wb_we_i,
  input  wire [31:0] wb_adr_i,
  input  wire [15:0] wb_dat_i,
  output reg  [15:0] wb_dat_o,
  output reg         wb_ack_o,
  output reg         irq_o,

  // Debug outputs
  output wire [15:0] dbg_x_in,
  output wire [15:0] dbg_d_in,
  output wire [15:0] dbg_y_out,
  output wire [15:0] dbg_err,
  output wire [15:0] dbg_w0,
  output wire [15:0] dbg_w1,
  output wire [15:0] dbg_w2,
  output wire [15:0] dbg_w3
);

  reg [15:0] x_in_reg, d_in_reg;
  wire [15:0] y_out, err;
  wire [15:0] w0, w1, w2, w3;

  LMS_core core (
    .Clk(Clk),
    .Rst(Rst),
    .x_in(x_in_reg),
    .d_in(d_in_reg),
    .y_out(y_out),
    .err(err),
    .w0(w0), .w1(w1), .w2(w2), .w3(w3)
  );

  always @(posedge Clk) begin
    if (Rst) begin
      wb_ack_o <= 0;
      wb_dat_o <= 0;
      x_in_reg <= 0;
      d_in_reg <= 0;
      irq_o    <= 0;
    end else begin
      wb_ack_o <= 0;
      irq_o    <= 0;
      if (wb_cyc_i && wb_stb_i && !wb_ack_o) begin
        wb_ack_o <= 1;
        if (wb_we_i) begin
          case (wb_adr_i[5:2])
            4'h3: x_in_reg <= wb_dat_i;
            4'h4: d_in_reg <= wb_dat_i;
          endcase
          irq_o <= 1;
        end else begin
          case (wb_adr_i[5:2])
            4'h3: wb_dat_o <= y_out;
            4'h4: wb_dat_o <= err;
          endcase
        end
      end
    end
  end

  assign dbg_x_in  = x_in_reg;
  assign dbg_d_in  = d_in_reg;
  assign dbg_y_out = y_out;
  assign dbg_err   = err;
  assign dbg_w0    = w0;
  assign dbg_w1    = w1;
  assign dbg_w2    = w2;
  assign dbg_w3    = w3;

endmodule

