----------------------------------------------------------------------------------
-- Company: ENGS31
-- Engineer: Graham Hazlett
-- 
-- Create Date: 08/14/2018 03:41:31 PM
-- Design Name: 
-- Module Name: encoder_logic - Behavioral
-- Project Name: Etch-a-Sketch
-- Target Devices: Diligent Baysis3 (Atrix 7)
-- Tool Versions: Vivado 2016.1
-- Description: Module to interpret encoder signals, and output signals denoting
-- a rotation, and the direction of that rotation
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

entity encoder_logic is
  Port (  A: in std_logic;
          B: in std_logic;
          clk: in std_logic;
          Enable: out std_logic; -- 1 means has detected turn, 0 no turn detected this tick
          Direction: out std_logic -- 1 is clockwise, 0 counterclockwise
  );
end encoder_logic;

architecture Behavioral of encoder_logic is

type state_type is (Ahigh, Alow, AhighCW, AhighCCW, AlowCW, AlowCCW);
signal curr_state, next_state: state_type := Alow;

begin

-- state update process
state_update: process(clk)
begin
    if rising_edge(clk) then
        curr_state <= next_state;
    end if;
end process;

-- combinatorial process detnoting state changes and output assertions
main: process(clk, A, B)
begin
    Enable <= '0';
    Direction <= '0';
    next_state <= curr_state;
    case curr_state is
    
        when Ahigh =>
            if A = '0' then
                if B = '0' then
                    next_state <= AhighCW;
                else
                    next_state <= AhighCCW;
                end if;
            end if;
            
        when AhighCCW =>
            Enable <= '1';
            Direction <= '0';
            next_state <= Alow;
            
        when AhighCW =>
            Enable <= '1';
            Direction <= '1';
            next_state <= Alow;
            
        when Alow =>
            if A = '1' then
                if B = '0' then
                    next_state <= AlowCCW;
                else
                    next_state <= AlowCW;
                end if;
            end if;
            
        when AlowCCW =>
            Enable <= '1';
            Direction <= '0';
            next_state <= Ahigh;
            
        when AlowCW =>
            Enable <= '1';
            Direction <= '1';
            next_state <= Ahigh;
            
    end case;
end process;
                

end Behavioral;
