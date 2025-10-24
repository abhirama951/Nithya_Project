// LMS_core.v
module LMS_core (
    input              Clk,
    input              Rst,
    input  signed [15:0] x_in,      // Input sample (Q4.12)
    input  signed [15:0] d_in,      // Desired sample (Q4.12)
    input              training_en, // 1: update weights, 0: freeze
    input  signed [15:0] gamma,     // Step size (Q4.12)
    input  signed [15:0] w0_set,    // External write values (used when load_weights=1)
    input  signed [15:0] w1_set,
    input  signed [15:0] w2_set,
    input  signed [15:0] w3_set,
    input              load_weights, // Pulse: load w*_set into wn[*]
    output signed [15:0] y_out,     // Output (Q4.12)
    output signed [15:0] err,       // Error (Q4.12)
    output signed [15:0] w0, w1, w2, w3 // Current weights
);

  // Tap delay line for x
  reg signed [15:0] x[0:3];
  always @(posedge Clk or posedge Rst) begin
    if (Rst) begin
      x[0] <= 16'sd0; x[1] <= 16'sd0; x[2] <= 16'sd0; x[3] <= 16'sd0;
    end else begin
      x[3] <= x[2];
      x[2] <= x[1];
      x[1] <= x[0];
      x[0] <= x_in;
    end
  end

  // Weights
  reg signed [15:0] wn[0:3];
  // Optional external load
  always @(posedge Clk or posedge Rst) begin
    if (Rst) begin
      wn[0] <= 16'sd0; wn[1] <= 16'sd0; wn[2] <= 16'sd0; wn[3] <= 16'sd0;
    end else if (load_weights) begin
      wn[0] <= w0_set; wn[1] <= w1_set; wn[2] <= w2_set; wn[3] <= w3_set;
    end
  end

  // Output y = sum(wn[i]*x[i]) -> Q4.12
  wire signed [31:0] y_acc = $signed(wn[0])*$signed(x[0]) +
                             $signed(wn[1])*$signed(x[1]) +
                             $signed(wn[2])*$signed(x[2]) +
                             $signed(wn[3])*$signed(x[3]);
  assign y_out = y_acc[27:12];

  // Error
  assign err = d_in - y_out;

  // LMS updates gated by training_en
  // m_i = gamma * (err * x[i]) with truncations to Q4.12
  wire signed [31:0] p0 = $signed(err) * $signed(x[0]);
  wire signed [15:0] p0_q = p0[27:12];
  wire signed [31:0] a0 = $signed(gamma) * $signed(p0_q);
  wire signed [15:0] a0_q = a0[27:12];

  wire signed [31:0] p1 = $signed(err) * $signed(x[1]);
  wire signed [15:0] p1_q = p1[27:12];
  wire signed [31:0] a1 = $signed(gamma) * $signed(p1_q);
  wire signed [15:0] a1_q = a1[27:12];

  wire signed [31:0] p2 = $signed(err) * $signed(x[2]);
  wire signed [15:0] p2_q = p2[27:12];
  wire signed [31:0] a2 = $signed(gamma) * $signed(p2_q);
  wire signed [15:0] a2_q = a2[27:12];

  wire signed [31:0] p3 = $signed(err) * $signed(x[3]);
  wire signed [15:0] p3_q = p3[27:12];
  wire signed [31:0] a3 = $signed(gamma) * $signed(p3_q);
  wire signed [15:0] a3_q = a3[27:12];

  wire signed [15:0] wn_u0 = wn[0] + a0_q;
  wire signed [15:0] wn_u1 = wn[1] + a1_q;
  wire signed [15:0] wn_u2 = wn[2] + a2_q;
  wire signed [15:0] wn_u3 = wn[3] + a3_q;

  always @(posedge Clk or posedge Rst) begin
    if (Rst) begin
      // already reset above
    end else if (training_en) begin
      wn[0] <= wn_u0;
      wn[1] <= wn_u1;
      wn[2] <= wn_u2;
      wn[3] <= wn_u3;
    end
  end

  assign w0 = wn[0];
  assign w1 = wn[1];
  assign w2 = wn[2];
  assign w3 = wn[3];

endmodule

