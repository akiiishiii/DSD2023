// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Nov 29 16:04:36 2023
// Host        : LAPTOP-F6HMT211 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {d:/FPGA
//               Projects/DSD2023/DSD2023.srcs/sources_1/ip/triangle_rom/triangle_rom_stub.v}
// Design      : triangle_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *)
module triangle_rom(a, clk, qspo)
/* synthesis syn_black_box black_box_pad_pin="a[7:0],clk,qspo[7:0]" */;
  input [7:0]a;
  input clk;
  output [7:0]qspo;
endmodule
