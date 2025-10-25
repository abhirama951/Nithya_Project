`timescale 1ns/1ps

module wb_lms_tb;

  reg wb_clk_i, wb_rst_i;
  reg [3:0] wb_adr_i;
  reg [15:0] wb_dat_i;
  wire [15:0] wb_dat_o;
  reg wb_we_i, wb_stb_i, wb_cyc_i;
  wire wb_ack_o;

  // DUT
  wb_lms dut (
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wb_adr_i(wb_adr_i),
    .wb_dat_i(wb_dat_i),
    .wb_dat_o(wb_dat_o),
    .wb_we_i(wb_we_i),
    .wb_stb_i(wb_stb_i),
    .wb_cyc_i(wb_cyc_i),
    .wb_ack_o(wb_ack_o)
  );

  // Clock generation
  always #5 wb_clk_i = ~wb_clk_i;

  // Wishbone write task
  task wb_write;
    input [3:0] addr;
    input [15:0] data;
    begin
      @(posedge wb_clk_i);
      wb_adr_i = addr;
      wb_dat_i = data;
      wb_we_i  = 1;
      wb_stb_i = 1;
      wb_cyc_i = 1;
      @(posedge wb_clk_i);
      while (!wb_ack_o) @(posedge wb_clk_i);
      wb_stb_i = 0;
      wb_cyc_i = 0;
      wb_we_i  = 0;
    end
  endtask

  // Wishbone read task
  task wb_read;
    input [3:0] addr;
    begin
      @(posedge wb_clk_i);
      wb_adr_i = addr;
      wb_we_i  = 0;
      wb_stb_i = 1;
      wb_cyc_i = 1;
      @(posedge wb_clk_i);
      while (!wb_ack_o) @(posedge wb_clk_i);
      $display("WB READ [%0h] = %0d", addr, wb_dat_o);
      wb_stb_i = 0;
      wb_cyc_i = 0;
    end
  endtask

  initial begin
    wb_clk_i = 0;
    wb_rst_i = 1;
    wb_stb_i = 0;
    wb_cyc_i = 0;
    wb_we_i  = 0;
    #20 wb_rst_i = 0;

    // Write input samples
    repeat (10) begin
      wb_write(4'h0, $random);
      #20;
      wb_read(4'h2); // y_out
      wb_read(4'h3); // err
    end

    #100 $finish;
  end

  initial begin
    $dumpfile("wb_lms.vcd");
    $dumpvars(0, wb_lms_tb);
  end

endmodule

