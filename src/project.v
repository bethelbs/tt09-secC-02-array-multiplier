/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_c_2_array_mult (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
wire [3:0] a,b;
assign m = ui_in[3:0];
assign q = ui_in [7:4];


  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

assign uo_out [7:0];
assign uo_out[3:0] = p;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

   wire [10:0] w; 
   wire [5:0]inter;
and (p[0], m[0],q[0]);
fulladder stage1 (q[0]&m[1], q[1]&m[0],1'b0, p[1], w[0]);
fulladder stage2 (q[0]&m[2], q[1]&m[1],w[0], inter[0], w[1]);
fulladder stage3 (q[0]&m[3], q[1]&m[2],w[1], inter[1], w[2]);
fulladder stage4 (0, q[1]&m[3],w[2], inter[2], w[3]);

fulladder stage5 (q[2]&m[0], inter[0],1'b0, p[2], w[4]);
fulladder stage6 (q[2]&m[1], inter[1],w[4], inter[3], w[5]);
fulladder stage7 (q[2]&m[2], inter[2],w[5], inter[4], w[6]);
fulladder stage8 (w[3], q[2]&m[3],w[6], inter[5], w[7]);

fulladder stage9 (q[3]&m[0], inter[3],1'b0, p[3], w[8]);
fulladder stage10 (q[3]&m[1], inter[4],w[8], p[4], w[9]);
fulladder stage11 (q[3]&m[2], inter[5],w[9],p[5], w[10]);
fulladder stage12 (w[7], q[3]&m[3],w[10], p[6], p[7]);


endmodule

module fulladder(
input a,b, c,
output z,carry_out
);
 wire int_sig1;
    wire int_sig2;
    wire int_sig3;
    wire int_sig4;
    wire int_sig5;
    wire int_sig6;
    wire int_sig7;
    wire int_sig8;
        
    assign int_sig1 = a & ~b;
    assign int_sig2 = ~a & b;
    assign int_sig3 = int_sig1 + int_sig2;
    assign int_sig4 = int_sig3 & ~c;
    assign int_sig5 = ~int_sig3 & c;
    assign z = int_sig4 + int_sig5; 
    assign int_sig6 = a & b;
    assign int_sig7 = b & c;
    assign int_sig8 = c & a;    
    assign carry_out = int_sig6 | int_sig7 | int_sig8;

endmodule