----------------------------------------------------------------------------------
-- Company: ENGS31
-- Engineer: Liam Jolley
-- 
-- Create Date: 08/14/2018 0
-- Design Name: 
-- Module Name: cursor_logic - Behavioral
-- Project Name: Etch-a-Sketch
-- Target Devices: 
-- Tool Versions: 
-- Description: Logic to update the cursor location
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
use IEEE.NUMERIC_STD.ALL;


entity cursor_logic is
    Port (  clk: in STD_LOGIC;
            hor_sig: in STD_LOGIC; -- 1 for clockwise and 0 for counterclockwise
            vert_sig: in STD_LOGIC; -- 1 for clockwise and 0 for counterclockwise
            hor_en: in STD_LOGIC;
            vert_en: in STD_LOGIC;
            cursor_out: out STD_LOGIC_VECTOR(14 downto 0) );
end cursor_logic;

architecture Behavioral of cursor_logic is


constant WIDTH : integer:= 160;
constant HEIGHT : integer:= 120;
signal ucursor_in: unsigned(14 downto 0) := "001000000000000"; --random start location, change to middle


begin

        
update_cursor: process(clk, hor_en, vert_en)
begin
    if rising_edge(clk) then
        if hor_en = '1' then -- horizontal knob turning
            if hor_sig = '0' then -- counter-clockwise
                if (ucursor_in mod WIDTH) > 0 then  -- check to see if in first column
                    ucursor_in <= ucursor_in - 1; -- move left
                end if;
            else -- clockwise
                if (ucursor_in mod WIDTH) < WIDTH-1 then -- check to see if in last column
                    ucursor_in <= ucursor_in + 1; -- move right
                end if;
            end if;
        end if;
        if vert_en = '1' then -- vertical knob turning
            if vert_sig = '0' then --counter-clockwise
                if ucursor_in < ((WIDTH * HEIGHT) - WIDTH) then -- check to see if in bottom row
                    ucursor_in <= ucursor_in + WIDTH; -- move up
                end if;
            else -- clockwise
                if ucursor_in >= (WIDTH) then -- check to see if in top row
                    ucursor_in <= ucursor_in - WIDTH; -- move down
                end if;
            end if;
        end if;
        cursor_out <= std_logic_vector(ucursor_in); -- update cursorr
    end if;
end process update_cursor;

end Behavioral;
