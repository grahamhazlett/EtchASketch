-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.3.1 (win64) Build 2035080 Fri Oct 20 14:20:01 MDT 2017
-- Date        : Tue Aug 21 22:38:13 2018
-- Host        : MECHA-7 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               P:/18summer/engs031/G19/Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/ip/Block_Ram/Block_Ram_stub.vhdl
-- Design      : Block_Ram
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Block_Ram is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 14 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 14 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end Block_Ram;

architecture stub of Block_Ram is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,wea[0:0],addra[14:0],dina[3:0],clkb,enb,addrb[14:0],doutb[3:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_0,Vivado 2017.3.1";
begin
end;
