----------------------------------------------------------------------------------
-- Company: ENGS31
-- Engineer: Liam Jolley
-- 
-- Create Date: 08/14/2018 01:49:28 PM
-- Design Name: 
-- Module Name: cursor_logic_tb testbench
-- Project Name: Etch-a-Sketch
-- Target Devices: 
-- Tool Versions: 
-- Description: Testing the logic to update the cursor location
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


entity cursor_logic_tb is
end cursor_logic_tb;

architecture testbench of cursor_logic_tb is

component cursor_logic is
    Port (  clk: in STD_LOGIC;
            hor_sig: in STD_LOGIC;
            vert_sig: in STD_LOGIC;
            hor_en: in STD_LOGIC;
            vert_en: in STD_LOGIC;
            cursor_out: out STD_LOGIC_VECTOR(14 downto 0) );
end component;

constant WIDTH : integer:= 128;
constant HEIGHT : integer:= 64;
signal clk: std_logic := '0';
signal hor_sig: std_logic := '0';
signal vert_sig: std_logic := '0';
signal hor_en: std_logic := '0';
signal vert_en: std_logic := '0';
signal cursor_out: STD_LOGIC_VECTOR(14 downto 0) := (others => '0');

-- Datatype "time" is OK in simulation
constant clk_period: time := 10 ns;	-- 100 MHz

begin

dut: cursor_logic
	port map (
    	clk => clk,
        hor_sig => hor_sig,
        vert_sig => vert_sig, 
        hor_en => hor_en,
        vert_en => vert_en,
        cursor_out => cursor_out );
        
clkgen_proc: process
begin
	clk <= not(clk);		-- toggle clk signal
    wait for clk_period/2;	-- OK to use "wait" in testbench
end process clkgen_proc;

sel_stim: process
begin
    wait for clk_period;
    vert_en <= '1';
    wait for (HEIGHT + 2) * clk_period;
    vert_sig <= '1';
    wait for (HEIGHT + 2) * clk_period;
    vert_en <= '0';
    hor_en <= '1';
    hor_sig <= '1';
    wait for (WIDTH + 2) * clk_period;
    hor_sig <= '0';
    wait for (WIDTH + 2) * clk_period;
    
     
end process sel_stim;
end testbench;