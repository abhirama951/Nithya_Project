`timescale 1ns/1ps
module LMS_TB;

    reg Clk, Rst;
    reg mode_train;
    reg signed [15:0] x_in;
    reg signed [15:0] d_in;
    wire signed [15:0] y_out, err, w0, w1, w2, w3;

    integer i;
    reg signed [15:0] x_data[0:99];
    reg signed [15:0] d_data[0:99];

    integer csv_file;

    // Scaling factor for Q4.12
    real SF = 1.0/4096.0;

    // Instantiate LMS
    LMS dut (
        .Clk(Clk),
        .Rst(Rst),
        .mode_train(mode_train),
        .x_in(x_in),
        .d_in(d_in),
        .y_out(y_out),
        .err(err),
        .w0(w0), .w1(w1), .w2(w2), .w3(w3)
    );

    // Clock
    initial Clk = 0;
    always #5 Clk = ~Clk;  // 10ns period

    initial begin
        $dumpfile("LMS_tb.vcd");
        $dumpvars(0, LMS_TB);

        // Open CSV file
        csv_file = $fopen("lms_output.csv","w");
        $fwrite(csv_file,"time,x_in,y_out,d_in,err,w0,w1,w2,w3\n");

        // Reset
        Rst = 1; mode_train = 0; x_in = 0; d_in = 0;
        #20;
        Rst = 0;

        // Load input and desired data
        $readmemb("x_input.txt", x_data);
        $readmemb("d_input.txt", d_data);

        // -----------------------------
        // Training mode
        // -----------------------------
        mode_train = 1;
        for (i=0;i<100;i=i+1) begin
            x_in = x_data[i];
            d_in = d_data[i];
            #10; // wait 1 clock
            $fwrite(csv_file,"%0t,%d,%d,%d,%d,%d,%d,%d,%d\n",
                    $time, x_in, y_out, d_in, err, w0, w1, w2, w3);
        end

        // -----------------------------
        // Filter mode
        // -----------------------------
        mode_train = 0;
        for (i=0;i<100;i=i+1) begin
            x_in = x_data[i];
            d_in = 0; // not used
            #10;
            $fwrite(csv_file,"%0t,%d,%d,%d,%d,%d,%d,%d,%d\n",
                    $time, x_in, y_out, 0, 0, w0, w1, w2, w3);
        end

        $fclose(csv_file);
        $finish;
    end
endmodule

