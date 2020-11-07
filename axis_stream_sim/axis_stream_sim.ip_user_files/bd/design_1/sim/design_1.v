//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Sat Nov  7 22:32:17 2020
//Host        : wrijfbedrijf running 64-bit Arch Linux
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (aclk_0,
    aresetn_0,
    state_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK_0, ASSOCIATED_RESET aresetn_0, CLK_DOMAIN design_1_aclk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input aclk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input aresetn_0;
  output [1:0]state_0;

  wire aclk_0_1;
  wire aresetn_0_1;
  wire [31:0]axi4stream_vip_0_M_AXIS_TDATA;
  wire [0:0]axi4stream_vip_0_M_AXIS_TLAST;
  wire axi4stream_vip_0_M_AXIS_TREADY;
  wire [3:0]axi4stream_vip_0_M_AXIS_TSTRB;
  wire [0:0]axi4stream_vip_0_M_AXIS_TVALID;
  wire [31:0]shifter2_0_M00_AXIS_TDATA;
  wire shifter2_0_M00_AXIS_TLAST;
  wire [0:0]shifter2_0_M00_AXIS_TREADY;
  wire [3:0]shifter2_0_M00_AXIS_TSTRB;
  wire shifter2_0_M00_AXIS_TVALID;
  wire [1:0]shifter2_0_state;

  assign aclk_0_1 = aclk_0;
  assign aresetn_0_1 = aresetn_0;
  assign state_0[1:0] = shifter2_0_state;
  design_1_axi4stream_vip_0_0 axi4stream_vip_master
       (.aclk(aclk_0_1),
        .aresetn(aresetn_0_1),
        .m_axis_tdata(axi4stream_vip_0_M_AXIS_TDATA),
        .m_axis_tlast(axi4stream_vip_0_M_AXIS_TLAST),
        .m_axis_tready(axi4stream_vip_0_M_AXIS_TREADY),
        .m_axis_tstrb(axi4stream_vip_0_M_AXIS_TSTRB),
        .m_axis_tvalid(axi4stream_vip_0_M_AXIS_TVALID));
  design_1_axi4stream_vip_1_0 axi4stream_vip_slave
       (.aclk(aclk_0_1),
        .aresetn(aresetn_0_1),
        .s_axis_tdata(shifter2_0_M00_AXIS_TDATA),
        .s_axis_tlast(shifter2_0_M00_AXIS_TLAST),
        .s_axis_tready(shifter2_0_M00_AXIS_TREADY),
        .s_axis_tstrb(shifter2_0_M00_AXIS_TSTRB),
        .s_axis_tvalid(shifter2_0_M00_AXIS_TVALID));
  design_1_shifter2_0_0 shifter2_0
       (.m00_axis_aclk(aclk_0_1),
        .m00_axis_aresetn(aresetn_0_1),
        .m00_axis_tdata(shifter2_0_M00_AXIS_TDATA),
        .m00_axis_tlast(shifter2_0_M00_AXIS_TLAST),
        .m00_axis_tready(shifter2_0_M00_AXIS_TREADY),
        .m00_axis_tstrb(shifter2_0_M00_AXIS_TSTRB),
        .m00_axis_tvalid(shifter2_0_M00_AXIS_TVALID),
        .s00_axis_aclk(aclk_0_1),
        .s00_axis_aresetn(aresetn_0_1),
        .s00_axis_tdata(axi4stream_vip_0_M_AXIS_TDATA),
        .s00_axis_tlast(axi4stream_vip_0_M_AXIS_TLAST),
        .s00_axis_tready(axi4stream_vip_0_M_AXIS_TREADY),
        .s00_axis_tstrb(axi4stream_vip_0_M_AXIS_TSTRB),
        .s00_axis_tvalid(axi4stream_vip_0_M_AXIS_TVALID),
        .state(shifter2_0_state));
endmodule
