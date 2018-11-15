----------------------------------------------------------------------------------
-- Company: ENGS31
-- Engineer: Graham Hazlett
-- 
-- Create Date: 08/20/2018 12:05:24 PM
-- Design Name: 
-- Module Name: debouncer - Behavioral
-- Project Name: Etch-a-Sketch
-- Target Devices: Diligent Baysis3 (Atrix 7)
-- Tool Versions: Vivado 2016.1
-- Description: Module to debounce a generic signal for the number of clock cycles
--          specified by the 'cycles' input.
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
use IEEE.numeric_std.ALL;
use IEEE.math_real.all;		-- needed for arithmetic

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    Port (  clk: in std_logic;
            input: in std_logic;
            output: out std_logic;
            cycles: in std_logic_vector(19 downto 0)
     );
end debouncer;

architecture Behavioral of debouncer is

type db_state_type is (high,db_high,low,db_low);
signal curr_state, next_state: db_state_type := low;
signal cycle_count: unsigned(19 downto 0) := (others => '0');
signal count_up, count_reset: std_logic := '0';

begin

-- combinatorial logic denoting state changes based on inputs:
debounce: process(input, cycle_count, cycles, curr_state)
begin
    count_up <= '0';
    count_reset <= '0';
    case curr_state is
        when high =>
            output <= '1';
            if input = '0' then
                next_state <= db_high;
            else
                next_state <= high;
            end if;
        when db_high =>
            output <= '1';
            if input = '0' then
                if unsigned(cycle_count) = unsigned(cycles) - 1 then
                    count_reset <= '1';
                    next_state <= low;
                else
                    count_up <= '1';
                    next_state <= db_high;
                end if;
            else
                count_reset <= '1';
                next_state <= high;
            end if;
            
        when low =>
            output <= '0';
            if input = '1' then
                next_state <= db_low;
            else
                next_state <= low;
            end if;
        when db_low =>
            output <= '0';
            if input = '1' then
                if unsigned(cycle_count) = unsigned(cycles) - 1 then
                    count_reset <= '1';
                    next_state <= high;
                else
                    count_up <= '1';
                    next_state <= db_low;
                end if;
            else
                count_reset <= '1';
                next_state <= low;
            end if;
    end case;
end process debounce;

-- synchronous process updating count based on count_up and count_reset
count_update: process(clk, count_up, count_reset)
begin
    if rising_edge(clk) then
        if count_up = '1' then
            cycle_count <= cycle_count + 1;
        elsif count_reset = '1' then
            cycle_count <= (others => '0');
        end if;
    end if;
end process count_update;
            
-- state update process
debounce_state_update: process(clk)
begin
    if rising_edge(clk) then
        curr_state <= next_state;
    end if;
end process debounce_state_update;

end Behavioral;
