-makelib ies_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../Etch-a-Sketch.srcs/sources_1/ip/Block_Ram/Block_Ram_sim_netlist.vhdl" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

