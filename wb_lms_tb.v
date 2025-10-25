`timescale 1ns/1ps
module wb_lms_tb;

    reg Clk, Rst;
    reg wb_cyc_i, wb_stb_i, wb_we_i;
    reg [31:0] wb_adr_i;
    reg [15:0] wb_dat_i;
    wire [15:0] wb_dat_o;
    wire wb_ack_o, irq_o;

    integer i;
    reg signed [15:0] x_data[0:99];
    reg signed [15:0] d_data[0:99];
    integer csv_file;

    real SF = 1.0/4096.0; // Q4.12 scaling

    // Instantiate WB-LMS
    wb_lms dut (
        .Clk(Clk),
        .Rst(Rst),
        .wb_cyc_i(wb_cyc_i),
        .wb_stb_i(wb_stb_i),
        .wb_we_i(wb_we_i),
        .wb_adr_i(wb_adr_i),
        .wb_dat_i(wb_dat_i),
        .wb_dat_o(wb_dat_o),
        .wb_ack_o(wb_ack_o),
        .irq_o(irq_o)
    );

    // Clock generation
    initial Clk = 0;
    always #5 Clk = ~Clk;

    // -----------------------------
    // Tasks for WB access
    // -----------------------------
    task wb_write(input [31:0] addr, input [15:0] data);
    begin
        @(negedge Clk);
        wb_cyc_i <= 1; wb_stb_i <= 1; wb_we_i <= 1;
        wb_adr_i <= addr;
        wb_dat_i <= data;
        @(posedge wb_ack_o);
        @(negedge Clk);
        wb_cyc_i <= 0; wb_stb_i <= 0; wb_we_i <= 0;
    end
    endtask

    task wb_read(input [31:0] addr, output [15:0] data_out);
    begin
        @(negedge Clk);
        wb_cyc_i <= 1; wb_stb_i <= 1; wb_we_i <= 0;
        wb_adr_i <= addr;
        @(posedge wb_ack_o);
        data_out = wb_dat_o;
        @(negedge Clk);
        wb_cyc_i <= 0; wb_stb_i <= 0;
    end
    endtask

    // -----------------------------
    // Main test
    // -----------------------------
    initial begin
        $dumpfile("wb_lms_tb.vcd");
        $dumpvars(0, wb_lms_tb);

        // Open CSV
        csv_file = $fopen("wb_lms_output.csv","w");
        $fwrite(csv_file,"time,x_in,y_out,d_in,err,w0,w1,w2,w3\n");

        // Reset
        Clk <= 0;
        Rst <= 1; wb_cyc_i=0; wb_stb_i=0; wb_we_i=0;
        wb_adr_i=0; wb_dat_i=0;
        #20;
        Rst <= 0;

        // Load data
        $readmemb("x_input.txt", x_data);
        $readmemb("d_input.txt", d_data);

        // -----------------------------
        // Training Mode
        // -----------------------------
        wb_write(32'h08, 16'd1); // mode_train = 1

        for(i=0;i<100;i=i+1) begin
            wb_write(32'h00, x_data[i]); // x_in
            wb_write(32'h04, d_data[i]); // d_in

            // Read outputs for logging
            #(10);
            log_csv(i);
        end

        // -----------------------------
        // Filter Mode
        // -----------------------------
        wb_write(32'h08, 16'd0); // mode_train = 0

        for(i=0;i<100;i=i+1) begin
            wb_write(32'h00, x_data[i]); // x_in
            wb_write(32'h04, 16'd0);     // d_in unused

            #(10);
            log_csv(i);
        end

        $fclose(csv_file);
        $finish;
    end

    // -----------------------------
    // Logging task
    // -----------------------------
    task log_csv(input integer idx);
        reg signed [15:0] y, e, w_0, w_1, w_2, w_3;
    begin
        wb_read(32'h0C, y);
        wb_read(32'h10, e);
        wb_read(32'h14, w_0);
        wb_read(32'h18, w_1);
        wb_read(32'h1C, w_2);
        wb_read(32'h20, w_3);

        $fwrite(csv_file,"%0t,%d,%d,%d,%d,%d,%d,%d,%d\n",
                $time, x_data[idx], y, d_data[idx], e, w_0, w_1, w_2, w_3);
    end
    endtask

endmodule

