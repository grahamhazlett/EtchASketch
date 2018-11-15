----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2018 03:28:36 PM
-- Design Name: 
-- Module Name: shell_tb - Behavioral
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

entity shell_tb is
--  Port ( );
end shell_tb;

architecture testbench of shell_tb is

component top_level_shell is
port (      clk: in STD_LOGIC;
            hor_a: in STD_LOGIC;
            hor_b: in STD_LOGIC;
            vert_a: in STD_LOGIC;
            vert_b: in STD_LOGIC;
            Vsync: out STD_LOGIC;
            Hsync: out STD_LOGIC;
            pixel_data: out STD_LOGIC_VECTOR(11 downto 0);
            switch_red: in STD_LOGIC; -- red component of cursor color
                        switch_green: in STD_LOGIC; -- green component of cursor color
                        switch_blue: in STD_LOGIC; -- blue component of cursor color
                        background_red: in STD_LOGIC; -- red component of background color
                        background_green: in STD_LOGIC; -- green component of background color
                        background_blue: in STD_LOGIC; -- blue component of background color
                        clear: in STD_LOGIC; -- clear initiating data
                        up_down: in STD_LOGIC);
end component; 

signal clk: std_logic := '0';
signal hor_a: std_logic := '0';
signal hor_b: std_logic := '0';
signal vert_a: std_logic := '0';
signal vert_b: std_logic := '0';
signal vsync: std_logic := '0';
signal hsync: std_logic := '0';
signal pixel_data: std_logic_vector(11 downto 0) := (others => '0');
signal switch_red: std_logic := '0';
signal switch_green: std_logic := '0';
signal switch_blue: std_logic := '0';
signal background_red: std_logic := '0';
signal background_green: std_logic := '0';
signal background_blue: std_logic := '0';
signal clear: std_logic := '0';
signal up_down: std_logic := '0';

-- Datatype "time" is OK in simulation
constant clk_period: time := 10 ns;	-- 100 MHz

begin

dut: top_level_shell 
    port map (
        clk => clk,
        hor_a => hor_a,
        hor_b => hor_b,
        vert_a => vert_a,
        vert_b => vert_b,
        vsync => vsync,
        hsync => hsync,
        pixel_data => pixel_data,
        switch_red => switch_red,
        switch_green => switch_green,
        switch_blue => switch_blue,
        background_red => background_red,
        background_green => background_green,
        background_blue => background_blue,
        clear => clear,
        up_down => up_down
        );
        
        
clkgen_proc: process
begin
    clk <= not(clk);        -- toggle clk signal
    wait for clk_period/2;    -- OK to use "wait" in testbench
end process clkgen_proc;

sel_stim: process
begin


    wait for clk_period;
    
    -- one full CW rotation:
    hor_b <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '0';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '0';
    wait for 5 * clk_period;
    
    -- one full CW rotation:
    hor_b <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '0';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '0';
    wait for 5 * clk_period;
    
    -- one full CW rotation:
    hor_b <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '0';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '0';
    wait for 5 * clk_period;

    -- one full CW rotation:
    hor_a <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '0';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '0';
    wait for 5 * clk_period;

    -- one full CW rotation:
    hor_a <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '1';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_a <= '0';
    wait for 5 * clk_period;


    -- one full CW rotation:
    hor_b <= '0';
    wait for 5 * clk_period;

    
    
end process sel_stim;


end testbench;
