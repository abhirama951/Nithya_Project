// Wishbone wrapper for original LMS module
module wb_lms #(
  parameter DATA_WIDTH = 16,
  parameter ADDR_WIDTH = 4
)(
  input                    wb_clk_i,
  input                    wb_rst_i,
  input      [ADDR_WIDTH-1:0] wb_adr_i,
  input      [DATA_WIDTH-1:0] wb_dat_i,
  output reg [DATA_WIDTH-1:0] wb_dat_o,
  input                    wb_we_i,
  input                    wb_stb_i,
  input                    wb_cyc_i,
  output reg               wb_ack_o
);

  // --- Internal control and status registers ---
  reg signed [15:0] x_in;
  reg signed [15:0] gamma;
  wire signed [15:0] y_out, err;
  wire signed [15:0] w0, w1, w2, w3;

  // LMS core instance (original version)
  LMS lms_inst (
    .Clk(wb_clk_i),
    .Rst(wb_rst_i),
    .x_in(x_in),
    .y_out(y_out),
    .w0(w0),
    .w1(w1),
    .w2(w2),
    .w3(w3),
    .err(err)
  );

  // Write operation
  always @(posedge wb_clk_i) begin
    if (wb_rst_i) begin
      x_in  <= 0;
      gamma <= 16'b0000001100110011; // default 0.2
    end else if (wb_stb_i && wb_cyc_i && wb_we_i && !wb_ack_o) begin
      case (wb_adr_i)
        4'h0: x_in  <= wb_dat_i;        // Input sample
        4'h1: gamma <= wb_dat_i;        // gamma parameter
      endcase
    end
  end

  // Read operation
  always @(*) begin
    wb_dat_o = 0;
    case (wb_adr_i)
      4'h0: wb_dat_o = x_in;   // input
      4'h1: wb_dat_o = gamma;  // step size
      4'h2: wb_dat_o = y_out;  // output
      4'h3: wb_dat_o = err;    // error
      4'h4: wb_dat_o = w0;
      4'h5: wb_dat_o = w1;
      4'h6: wb_dat_o = w2;
      4'h7: wb_dat_o = w3;
    endcase
  end

  // Simple acknowledge
  always @(posedge wb_clk_i) begin
    if (wb_rst_i)
      wb_ack_o <= 1'b0;
    else if (wb_stb_i && wb_cyc_i && !wb_ack_o)
      wb_ack_o <= 1'b1;
    else
      wb_ack_o <= 1'b0;
  end

endmodule

