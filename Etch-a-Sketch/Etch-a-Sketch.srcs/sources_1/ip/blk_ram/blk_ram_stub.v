// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3.1 (win64) Build 2035080 Fri Oct 20 14:20:01 MDT 2017
// Date        : Wed Aug 15 16:57:32 2018
// Host        : CADLAB-11 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               p:/18summer/engs031/G19/Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/ip/blk_ram/blk_ram_stub.v
// Design      : blk_ram
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_0,Vivado 2017.3.1" *)
module blk_ram(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[12:0],dina[2:0],clkb,enb,addrb[12:0],doutb[2:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [12:0]addra;
  input [2:0]dina;
  input clkb;
  input enb;
  input [12:0]addrb;
  output [2:0]doutb;
endmodule
