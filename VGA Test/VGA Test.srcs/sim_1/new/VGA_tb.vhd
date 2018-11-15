----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/16/2018 05:09:21 PM
-- Design Name: 
-- Module Name: VGA_tb - testbench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
 
ENTITY VGA_tb IS
END VGA_tb;
 
ARCHITECTURE testbench OF VGA_tb IS 

component VGA_Shell
Port (      mclk: in STD_LOGIC;
            Vsync: out STD_LOGIC;
            Hsync: out STD_LOGIC;
            pixel_data: out STD_LOGIC_VECTOR(11 downto 0));
end component; 

     
   -- Clock period definitions
   constant clk_period : time := 40ns;		-- 100 MHz clock
	
BEGIN 
	-- Instantiate the Unit Under Test (UUT)
 
uut: Lab5 port map(
        mclk => clk, 
        -- SPI bus interface to Pmod AD1
        spi_sclk => spi_sclk,
        spi_cs => spi_cs,
        spi_sdata => spi_sdata);
        
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Stimulus process:  testbench pretends to be the A/D converter
   stim_proc: process(spi_sclk)
   begin
   
   end process;
END;


end testbench;
