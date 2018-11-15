----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2018 06:57:35 PM
-- Design Name: 
-- Module Name: debouncer_tb - Behavioral
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

entity debouncer_tb is
--  Port ( );
end debouncer_tb;

architecture testbench of debouncer_tb is

component debouncer is
    Port (  clk: in std_logic;
            input: in std_logic;
            output: out std_logic;
            cycles: in std_logic_vector(19 downto 0)
     );
end component;

-- Datatype "time" is OK in simulation
constant clk_period: time := 10 ns;	-- 100 MHz
signal clk,input,output: std_logic := '0';
signal cycles: std_logic_vector(19 downto 0) := X"00010";

begin

dut: debouncer
    port map (
        clk => clk,
        input => input,
        output => output,
        cycles => cycles );
        
clkgen_proc: process
begin
	clk <= not(clk);		-- toggle clk signal
    wait for clk_period/2;	-- OK to use "wait" in testbench
end process clkgen_proc;

sel_stim: process
begin
wait for clk_period;
    
    
    input <= '1';
    wait for 5 * clk_period;
    

    input <= '0';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '0';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 * clk_period;
    
    input <= '0';
    wait for 5 * clk_period;
    input <= '0';
    wait for 5 * clk_period;
    input <= '0';
    wait for 5 * clk_period;
    input <= '0';
    wait for 5 * clk_period;
    input <= '0';
    wait for 5 * clk_period;
    input <= '0';
    wait for 5 * clk_period;
    
    input <= '1';
    wait for 5 *clk_period;
    

end process sel_stim;

end testbench;
