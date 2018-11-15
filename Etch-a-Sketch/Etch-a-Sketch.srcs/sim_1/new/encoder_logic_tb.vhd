----------------------------------------------------------------------------------
-- Company: ENGS31
-- Engineer: R. Graham Hazlett
-- 
-- Create Date: 08/14/2018 04:14:03 PM
-- Design Name: 
-- Module Name: encoder_logic_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encoder_logic_tb is
end encoder_logic_tb;

architecture testbench of encoder_logic_tb is

component encoder_logic is
    Port (  A: in std_logic;
          B: in std_logic;
          clk: in std_logic;
          Enable: out std_logic; -- 1 means has detected turn, 0 no turn detected this tick
          Direction: out std_logic -- 1 is clockwise, 0 counterclockwise
          );
end component;

signal A: std_logic := '0';
signal B: std_logic := '0';
signal clk: std_logic := '0';
signal Enable: std_logic := '0'; -- 1 means has detected turn, 0 no turn detected this tick
signal Direction: std_logic := '0'; -- 1 is clockwise, 0 counterclockwise

-- Datatype "time" is OK in simulation
constant clk_period: time := 10 ns;	-- 100 MHz

begin

dut: encoder_logic
	port map (
    	A => A,
    	B => B,
    	clk => clk,
    	Enable => Enable,
    	Direction => Direction );
        
clkgen_proc: process
begin
	clk <= not(clk);		-- toggle clk signal
    wait for clk_period/2;	-- OK to use "wait" in testbench
end process clkgen_proc;

sel_stim: process
begin
    wait for clk_period;
    
    -- one full CW rotation:
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '1';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    B <= '0';
    wait for 5 * clk_period;
    
    -- one full CW rotation:
    
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '1';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    B <= '0';
    wait for 5 * clk_period;
    
    -- one full CCW rotation:
    
    B <= '1';
    wait for 5 * clk_period;
    
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '0';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    -- one full CCW rotation:
    
    B <= '1';
    wait for 5 * clk_period;
    
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '0';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    -- edge cases:
    -- a high, then goes back down
    
    A <= '1';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    -- a high, b high, then back down
    
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '1';
    wait for 5 * clk_period;
    
    B <= '0';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    -- a high, b high, a low, then back again
    
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '1';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
    A <= '1';
    wait for 5 * clk_period;
    
    B <= '0';
    wait for 5 * clk_period;
    
    A <= '0';
    wait for 5 * clk_period;
    
     
end process sel_stim;
end testbench;