//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Sat Nov  7 22:32:24 2020
//Host        : wrijfbedrijf running 64-bit Arch Linux
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (aclk_0,
    aresetn_0,
    state_0);
  input aclk_0;
  input aresetn_0;
  output [1:0]state_0;

  wire aclk_0;
  wire aresetn_0;
  wire [1:0]state_0;

  design_1 design_1_i
       (.aclk_0(aclk_0),
        .aresetn_0(aresetn_0),
        .state_0(state_0));
endmodule
