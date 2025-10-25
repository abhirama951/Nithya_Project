module LMS (
    input Clk,
    input Rst,
    input mode_train,                 // 1 = training, 0 = filter mode
    input signed [15:0] x_in,        // Input sample Q4.12
    input signed [15:0] d_in,        // Desired output (used in training)
    output signed [15:0] y_out,      // LMS output
    output signed [15:0] err,        // Error (d_in - y_out)
    output signed [15:0] w0, w1, w2, w3 // Weights
);

    parameter signed [15:0] gamma = 16'b0000100000000000; // 0.5 in Q4.12

    // -----------------------------
    // Internal registers
    // -----------------------------
    reg signed [15:0] wn[0:3]; // Weights
    reg signed [15:0] x[0:3];  // Delay line
    reg signed [15:0] err_reg;

    // -----------------------------
    // Delay line
    // -----------------------------
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            x[0]<=16'sd0; x[1]<=16'sd0; x[2]<=16'sd0; x[3]<=16'sd0;
        end else begin
            x[3]<=x[2];
            x[2]<=x[1];
            x[1]<=x[0];
            x[0]<=x_in;
        end
    end

    // -----------------------------
    // Compute output
    // -----------------------------
    wire signed [31:0] y_acc = $signed(wn[0])*x[0] +
                               $signed(wn[1])*x[1] +
                               $signed(wn[2])*x[2] +
                               $signed(wn[3])*x[3];

    assign y_out = y_acc[27:12];

    // -----------------------------
    // Compute error (used only in training)
    // -----------------------------
    always @(posedge Clk or posedge Rst) begin
        if (Rst)
            err_reg <= 16'sd0;
        else if (mode_train)
            err_reg <= d_in - y_out;
        else
            err_reg <= 16'sd0;
    end
    assign err = err_reg;

    // -----------------------------
    // LMS weight update
    // -----------------------------
    wire signed [31:0] p0 = $signed(err_reg) * x[0];
    wire signed [31:0] p1 = $signed(err_reg) * x[1];
    wire signed [31:0] p2 = $signed(err_reg) * x[2];
    wire signed [31:0] p3 = $signed(err_reg) * x[3];

    wire signed [15:0] p0_q = p0[27:12];
    wire signed [15:0] p1_q = p1[27:12];
    wire signed [15:0] p2_q = p2[27:12];
    wire signed [15:0] p3_q = p3[27:12];

    wire signed [31:0] m0_long = $signed(gamma) * $signed(p0_q);
    wire signed [31:0] m1_long = $signed(gamma) * $signed(p1_q);
    wire signed [31:0] m2_long = $signed(gamma) * $signed(p2_q);
    wire signed [31:0] m3_long = $signed(gamma) * $signed(p3_q);

    wire signed [15:0] m0 = m0_long[27:12];
    wire signed [15:0] m1 = m1_long[27:12];
    wire signed [15:0] m2 = m2_long[27:12];
    wire signed [15:0] m3 = m3_long[27:12];

    wire signed [15:0] wn_u0 = wn[0] + m0;
    wire signed [15:0] wn_u1 = wn[1] + m1;
    wire signed [15:0] wn_u2 = wn[2] + m2;
    wire signed [15:0] wn_u3 = wn[3] + m3;

    always @(posedge Clk or posedge Rst) begin
        if (Rst)
            {wn[0],wn[1],wn[2],wn[3]} <= 64'sd0;
        else if (mode_train)
            {wn[0],wn[1],wn[2],wn[3]} <= {wn_u0,wn_u1,wn_u2,wn_u3};
    end

    assign w0=wn[0];
    assign w1=wn[1];
    assign w2=wn[2];
    assign w3=wn[3];

endmodule

