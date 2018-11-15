-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.3.1 (win64) Build 2035080 Fri Oct 20 14:20:01 MDT 2017
-- Date        : Wed Aug 15 16:57:32 2018
-- Host        : CADLAB-11 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               p:/18summer/engs031/G19/Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/ip/blk_ram/blk_ram_stub.vhdl
-- Design      : blk_ram
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity blk_ram is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 12 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );

end blk_ram;

architecture stub of blk_ram is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,wea[0:0],addra[12:0],dina[2:0],clkb,enb,addrb[12:0],doutb[2:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_0,Vivado 2017.3.1";
begin
end;
