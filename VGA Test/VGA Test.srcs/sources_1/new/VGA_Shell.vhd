----------------------------------------------------------------------------------
-- Company: ENGS31 18X
-- Engineer: Liam Jolley
-- 
-- Create Date: 08/16/2018 03:18:47 PM
-- Design Name: 
-- Module Name: VGA_Shell - Behavioral
-- Project Name: Etch-a-Sketch
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;			-- needed for arithmetic
use IEEE.math_real.all;

library UNISIM;						-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_Shell is
  Port (    mclk: in STD_LOGIC;
            Vsync: out STD_LOGIC;
            Hsync: out STD_LOGIC;
            pixel_data: out STD_LOGIC_VECTOR(11 downto 0));
end VGA_Shell;


architecture Behavioral of VGA_Shell is
-- COMPONENT DECLARATIONS
-- VGA Component
Component VGA is
    port (  vclk : in STD_LOGIC; --25 MHz clock
            Vsync: out STD_LOGIC;
            Hsync: out STD_LOGIC;
            video_on: out STD_LOGIC;
            pixel_x: out std_logic_vector(9 downto 0);
            pixel_y: out std_logic_vector(9 downto 0));
end Component;

-- VGA Test Patter Component
Component vga_test_pattern is
	port(	row, column			: in  std_logic_vector( 9 downto 0);
			color				: out std_logic_vector(11 downto 0) );
end Component;

-------------------------------------------------
-- SIGNAL DECLARATIONS 
-- Signals for the serial clock divider, which divides the 100 MHz clock down to 25 MHz
constant SCLK_DIVIDER_VALUE: integer := 2;
--constant CLOCK_DIVIDER_VALUE: integer := 5;     -- for simulation
constant COUNT_LEN: integer := integer(ceil( log2( real(SCLK_DIVIDER_VALUE) ) ));
signal sclkdiv: unsigned(COUNT_LEN-1 downto 0) := (others => '0');  -- clock divider counter
signal sclk_unbuf: std_logic := '0';    -- unbuffered serial clock 
signal sclk: std_logic := '0';          -- internal serial clock
signal v_on: std_logic := '0';
signal row_s: std_logic_vector(9 downto 0) := (others => '0');
signal column_s: std_logic_vector(9 downto 0) := (others => '0');

begin

-- Clock buffer for sclk
-- The BUFG component puts the signal onto the FPGA clocking network
Slow_clock_buffer: BUFG
	port map (I => sclk_unbuf,
		      O => sclk );
    
-- Divide the 100 MHz clock down to 50 MHz, then toggling a flip flop gives the final 
-- 25 MHz system clock
Serial_clock_divider: process(mclk)
begin
	if rising_edge(mclk) then
	   	if sclkdiv = SCLK_DIVIDER_VALUE-1 then 
			sclkdiv <= (others => '0');
			sclk_unbuf <= NOT(sclk_unbuf);
		else
			sclkdiv <= sclkdiv + 1;
		end if;
	end if;
end process Serial_clock_divider;

-- Instantiate the VGA
display: VGA port map( 
            vclk => sclk,				-- runs on the 25 MHz clock
           	Vsync => Vsync, 		        
           	Hsync => Hsync,	
           	video_on => v_on, 		
           	pixel_x => column_s,		
           	pixel_y => row_s);	

-- Instantiate the VGA Test Pattern
example: vga_test_pattern port map( 
            row => row_s,				-- runs on the 25 MHz clock
           	column => column_s,		
           	color => pixel_data);	
           	
end Behavioral;
