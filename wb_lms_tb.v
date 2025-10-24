`timescale 1ns/1ps
module wb_lms_tb;
  reg Clk, Rst;
  reg         wb_cyc_i, wb_stb_i, wb_we_i;
  reg  [31:0] wb_adr_i;
  reg  [15:0] wb_dat_i;
  wire [15:0] wb_dat_o;
  wire        wb_ack_o;
  wire        irq_o;

  reg signed [15:0] x_vec [0:99];
  reg signed [15:0] d_vec [0:99];
  integer i, csv_fd;
  localparam SF = 2.0**-12.0;

  wb_lms #(.FIFO_DEPTH(256)) dut (
    .Clk(Clk), .Rst(Rst),
    .wb_cyc_i(wb_cyc_i), .wb_stb_i(wb_stb_i), .wb_we_i(wb_we_i),
    .wb_adr_i(wb_adr_i), .wb_dat_i(wb_dat_i),
    .wb_dat_o(wb_dat_o), .wb_ack_o(wb_ack_o),
    .irq_o(irq_o),
    .dbg_x_in(), .dbg_d_in(), .dbg_y_out(), .dbg_err(),
    .dbg_w0(), .dbg_w1(), .dbg_w2(), .dbg_w3()
  );

  always #5 Clk = ~Clk;

  task wb_write;
    input [31:0] addr;
    input [15:0] data;
    begin
      @(negedge Clk);
      wb_adr_i = addr;
      wb_dat_i = data;
      wb_we_i  = 1;
      wb_cyc_i = 1;
      wb_stb_i = 1;
      @(posedge Clk);
      while (!wb_ack_o) @(posedge Clk);
      @(negedge Clk);
      wb_cyc_i = 0;
      wb_stb_i = 0;
      wb_we_i  = 0;
    end
  endtask

  task log_csv;
    input integer fd;
    input integer idx;
    reg signed [15:0] x, d, y, e, w0, w1, w2, w3;
    begin
      x  = dut.dbg_x_in;
      d  = dut.dbg_d_in;
      y  = dut.dbg_y_out;
      e  = dut.dbg_err;
      w0 = dut.dbg_w0;
      w1 = dut.dbg_w1;
      w2 = dut.dbg_w2;
      w3 = dut.dbg_w3;
      $fwrite(fd, "%0t,%0d,%f,%f,%f,%f,%f,%f,%f,%f\n",
        $time, idx,
        $itor(x)*SF, $itor(d)*SF, $itor(y)*SF, $itor(e)*SF,
        $itor(w0)*SF, $itor(w1)*SF, $itor(w2)*SF, $itor(w3)*SF
      );
    end
  endtask

  initial begin
    Clk = 0; Rst = 1;
    wb_cyc_i = 0; wb_stb_i = 0; wb_we_i = 0; wb_adr_i = 0; wb_dat_i = 0;
    repeat(2) @(negedge Clk);
    Rst = 0;

    $readmemb("LMS_inputs.txt", x_vec);
    $readmemb("LMS_expected.txt", d_vec);

    csv_fd = $fopen("lms_log.csv", "w");
    $fwrite(csv_fd, "time_ns,index,x,d,y,err,w0,w1,w2,w3\n");

    wb_write(32'h08, 16'b0000001100110011); // gamma
    wb_write(32'h00, 16'h0008); // clear

    for (i=0; i<100; i=i+1) begin
      wb_write(32'h0C, x_vec[i]);
      wb_write(32'h10, d_vec[i]);
    end

    wb_write(32'h00, 16'h0005); // enable training

    for (i=0; i<100; i=i+1) begin
      @(posedge Clk);
      log_csv(csv_fd, i);
    end

    wb_write(32'h00, 16'h0004); // disable training
    wb_write(32'h00, 16'h0008); // clear

    for (i=0; i<100; i=i+1) begin
      wb_write(32'h0C, x_vec[i]);
    end

    for (i=0; i<100; i=i+1) begin
      @(posedge Clk);
      log_csv(csv_fd, i+100);
    end

    $fclose(csv_fd);
    repeat(20) @(negedge Clk);
    $finish;
  end

  initial begin
    $dumpfile("dump_wb_lms.vcd");
    $dumpvars(0, wb_lms_tb);
  end
endmodule

