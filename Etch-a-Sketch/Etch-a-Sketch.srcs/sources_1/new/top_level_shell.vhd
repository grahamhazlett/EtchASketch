----------------------------------------------------------------------------------
-- Company: 			Engs 31 18X
-- Engineer: 			Liam Jolley / Graham Hazlett
-- 
-- Create Date:    	 	08/15/18
-- Design Name: 		
-- Module Name:    		top_level_shell 
-- Project Name: 		Etch-a-Sketch
-- Target Devices: 		Digilent Basys3 (Artix 7)
-- Tool versions: 		Vivado 2016.1
-- Description: 		Top Level Shell connecting all parts of the Etch-a-Sketch as well as initiating processes
--                      to link the code base together
--				
-- Dependencies: 		cursor_logic, encoder_logic, debouncer, and VGA
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

library UNISIM;						-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;

entity top_level_shell is
port (      clk: in STD_LOGIC;
            hor_a: in STD_LOGIC; -- left rotary encoder data
            hor_b: in STD_LOGIC; -- left rotary encoder data
            vert_a: in STD_LOGIC; -- right rotary encoder data
            vert_b: in STD_LOGIC; -- right rotary encoder data
            Vsync: out STD_LOGIC; -- vga data
            Hsync: out STD_LOGIC; -- vga data
            pixel_data: out STD_LOGIC_VECTOR(11 downto 0); -- final pixel color data
            switch_red: in STD_LOGIC; -- red component of cursor color
            switch_green: in STD_LOGIC; -- green component of cursor color
            switch_blue: in STD_LOGIC; -- blue component of cursor color
            background_red: in STD_LOGIC; -- red component of background color
            background_green: in STD_LOGIC; -- green component of background color
            background_blue: in STD_LOGIC; -- blue component of background color
            clear: in STD_LOGIC; -- clear initiating data
            up_down: in STD_LOGIC -- cursor up/down initiating data
            );
end top_level_shell; 

 architecture Behavioral of top_level_shell is

-- COMPONENT DECLARATIONS
-- Cursor register 
component cursor_logic is
    Port (  clk: in STD_LOGIC;
            hor_sig: in STD_LOGIC; -- 1 is clockwise (right), 0 counterclockwise (left)
            vert_sig: in STD_LOGIC; -- 1 is clockwise (up), 0 counterclockwise (down)
            hor_en: in STD_LOGIC; -- left knob being turned or not
            vert_en: in STD_LOGIC; -- right knob being turned or not
            cursor_out: out STD_LOGIC_VECTOR(14 downto 0) ); -- current cursor location
end component;

-- Rotary encoder
component encoder_logic is
  Port (  A: in std_logic; -- feedback data from turn
          B: in std_logic;  -- feedback data from turn
          clk: in std_logic;
          Enable: out std_logic; -- 1 means has detected turn, 0 no turn detected this tick
          Direction: out std_logic -- 1 is clockwise, 0 counterclockwise
  );
end component;

component debouncer is
    Port (  clk: in std_logic;
            input: in std_logic;
            output: out std_logic;
            cycles: in std_logic_vector(19 downto 0) -- debouncing time
     );
end component;

-- Block RAM
COMPONENT Block_Ram
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0); -- write enable
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0); -- write address
    dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- data written
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(14 DOWNTO 0); -- read address
    doutb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- data read
  );
END COMPONENT;

-- VGA 
Component VGA is
    port (  vclk : in STD_LOGIC; -- 25 MHz clock that VGA runs on
            Vsync: out STD_LOGIC;
            Hsync: out STD_LOGIC;
            video_on: out STD_LOGIC;
            pixel_x: out std_logic_vector(9 downto 0); -- x coordinate of VGA
            pixel_y: out std_logic_vector(9 downto 0)); -- y coordinate of VGA
end Component;
-------------------------------------------------
-- SIGNAL DECLARATIONS 
-- Signals for the serial clock divider, which divides the 100 MHz clock down to 50 MHz
constant SCLK_DIVIDER_VALUE: integer := 2;
constant COUNT_LEN: integer := integer(ceil( log2( real(SCLK_DIVIDER_VALUE) ) ));
signal sclkdiv: unsigned(COUNT_LEN-1 downto 0) := (others => '0');  -- clock divider counter
signal sclk_unbuf: std_logic := '0';    -- unbuffered serial clock 
signal sclk: std_logic := '0';          -- internal serial clock
signal sample_counter: unsigned(16 downto 0) := (others => '0');

constant WIDTH: unsigned(7 downto 0) := x"a0"; --160
constant HEIGHT: unsigned(7 downto 0) := x"78"; --120


-- intermediate signals
signal hor_en_s: std_logic := '0'; -- intermediate signal for the horizontal enable
signal hor_sig_s: std_logic := '0'; -- intermediate signal for the horizontal direction
signal vert_en_s: std_logic := '0'; -- intermediate signal for the vertical enable
signal vert_sig_s: std_logic := '0'; -- intermediate signal for the vertical direction
signal cursor_s: std_logic_vector(14 downto 0) := (others => '0'); -- intermediate signal for the cursor position coming from cursor logic
signal ram_read_addr: std_logic_vector(14 downto 0) := (others => '0'); -- signal used to feed into ram read address
signal pixel_x: std_logic_vector(9 downto 0); -- intermediate signal for pixel x location
signal pixel_y: std_logic_vector(9 downto 0); -- intermediate signal for pixel y location
signal combined_position: std_logic_vector(14 downto 0) := (others => '0'); -- full position
signal video_on: std_logic := '0';      -- vga video on signal
signal raw_color: std_logic_vector(3 downto 0); -- raw color data coming from RAM.
signal color_in: std_logic_vector(3 downto 0); -- 3 bit rgb color to be fed into RAM
signal background_color: std_logic_vector(2 downto 0) := "111"; -- signal for background color, initialized as white.
signal mp_curr, mp_prev: std_logic := '0'; -- signals for monopulser
signal db_up_down, mp_up_down: std_logic := '0'; -- cursor up or down

-- write enable variables
signal write_en_s: std_logic_vector(0 downto 0) := "1"; -- final write_enable signal
signal vsync_s: std_logic := '0'; -- vsync signal
signal vsync_first: std_logic := '0'; -- to hold previous vsync signal
signal vsync_second: std_logic := '0'; -- to hold new vsync signal

--debouncing variables
constant DB_CYCLES: std_logic_vector(19 downto 0) := X"0ffff"; --20000
signal db_hor_a, db_hor_b, db_vert_a, db_vert_b: std_logic; -- debounced values

-------------------------------------------------
begin

vsync <= vsync_s; -- updatating vsync
combined_position <= std_logic_vector(resize(unsigned(pixel_y(8 downto 2)) * WIDTH + unsigned(pixel_x(9 downto 2)),15)); -- converting cooridnates to RAM data value

-- Clock buffer for sclk
-- The BUFG component puts the signal onto the FPGA clocking network
Slow_clock_buffer: BUFG
	port map (I => sclk_unbuf,
		      O => sclk );
    
-- Divide the 100 MHz clock down to 50 MHz, then toggling a flip flop gives the final 
-- 25 MHz system clock
Serial_clock_divider: process(clk)
begin
	if rising_edge(clk) then
	   	if sclkdiv = SCLK_DIVIDER_VALUE-1 then 
			sclkdiv <= (others => '0');
			sclk_unbuf <= NOT(sclk_unbuf);
		else
			sclkdiv <= sclkdiv + 1;
		end if;
	end if;
end process Serial_clock_divider;

-- process to handle clearing
clear_logic: process(clk, clear, combined_position, switch_red, switch_green, switch_blue)
begin
    if clear = '1' and unsigned(pixel_x) / 4 < WIDTH and unsigned(pixel_y) / 4 < HEIGHT then
        ram_read_addr <= combined_position;
        color_in <= "0000";
    else
        color_in <= switch_red & switch_green & switch_blue & '1'; --last bit set as '1' to denote it is not background
        ram_read_addr <= cursor_s;
    end if;
end process clear_logic;

-- process to monopulse the debounced up_down signal
Monopulser: process(clk, db_up_down)
begin
    if rising_edge(clk) then
        mp_curr <= db_up_down;
        mp_prev <= mp_curr;
    end if;
    mp_up_down <= mp_curr and not(mp_prev);
end process Monopulser;

-- process to handle picking the pen up or putting it down
Up_down_logic: process(clk, db_up_down)
begin
    if rising_edge(clk) then
        if mp_up_down = '1' then    
            write_en_s <= not(write_en_s);
        end if;
    end if;
end process Up_down_logic;

-- process to change the background color
switch_color_processor: process( background_red, background_green, background_blue)
begin
    background_color <= background_red & background_green & background_blue;
end process switch_color_processor;

--combinatorial process to process 4 bit pixel data for 12 bit vga
vga_color_processor: process(combined_position, raw_color) 
begin
    if video_on = '0' then
        pixel_data <= X"000";
    elsif raw_color(0) = '0' then -- if this has never been written to; ie is background color
        pixel_data <=   background_color(2) & background_color(2) & background_color(2) & background_color(2) &
                        background_color(1) & background_color(1) & background_color(1) & background_color(1) &
                        background_color(0) & background_color(0) & background_color(0) & background_color(0);
    else
        pixel_data <=   raw_color(3) & raw_color(3) & raw_color(3) & raw_color(3) & 
                        raw_color(2) & raw_color(2) & raw_color(2) & raw_color(2) & 
                        raw_color(1) & raw_color(1) & raw_color(1) & raw_color(1);
    end if;
end process vga_color_processor;


---- Process to assert the write enable if necessary, only needed if you want
---- to update only at bottom of the screen. This slows the drawing down, so
---- we chose to keep it commented out in the end.    
--write_en_check: process(clk)
--begin
--    if rising_edge(clk) then
--        vsync_second <= vsync_first;
--        vsync_first <= vsync_s;
--        if vsync_first = '0' and vsync_second = '1' then
--            write_en_s <= "1";
--        else
--            write_en_s <= "0";
--        end if;
--    end if;
--end process write_en_check;

-- Instantiate the horizontal rotary encoder
Hor_Encoder: encoder_logic 
    PORT MAP (
        A => db_hor_a,
        B => db_hor_b,
        clk => clk,
        Enable => hor_en_s,
        Direction => hor_sig_s );

-- Instantiate the vertical rotary encoder
Vert_Encoder: encoder_logic 
    PORT MAP (
        A => db_vert_a,
        B => db_vert_b,
        clk => clk,
        Enable => vert_en_s,
        Direction => vert_sig_s );      
        
-- Instantiate debouncers for encoders / pen up-down:
Hor_A_Debouncer: debouncer
    PORT MAP (
        clk => clk,
        input => hor_a,
        output => db_hor_a,
        cycles => DB_CYCLES );      

Hor_B_Debouncer: debouncer
    PORT MAP (
        clk => clk,
        input => hor_b,
        output => db_hor_b,
        cycles => DB_CYCLES );      

Vert_A_Debouncer: debouncer
    PORT MAP (
        clk => clk,
        input => vert_a,
        output => db_vert_a,
        cycles => DB_CYCLES );      

Vert_B_Debouncer: debouncer
    PORT MAP (
        clk => clk,
        input => vert_b,
        output => db_vert_b,
        cycles => DB_CYCLES );      
        
Up_Down_Debouncer: debouncer
    PORT MAP (
        clk => clk,
        input => up_down,
        output => db_up_down,
        cycles => DB_CYCLES );    
            
-- Instantiate the cursor update
Cursor_Update: cursor_logic
    PORT MAP (
        clk => clk,
        hor_sig => hor_sig_s,
        vert_sig => vert_sig_s,
        hor_en => hor_en_s,
        vert_en => vert_en_s,
        cursor_out => cursor_s
        );
        
-- Instantiate the RAM
RAM : Block_Ram
  PORT MAP (
      clka => clk,
      ena => '1',
      wea => write_en_s, -- signal triggered when the pen is down
      addra => ram_read_addr, -- current cursor position
      dina => color_in, -- mark current position as the desired color
      clkb => clk,
      enb => '1',
      addrb => combined_position,
      doutb => raw_color
  );

-- Instantiate the VGA
display: VGA port map( 
            vclk => sclk,				-- runs on the 25 MHz clock
           	Vsync => Vsync_s, 		        
           	Hsync => Hsync,	
           	video_on => video_on, 		
           	pixel_x => pixel_x,		
           	pixel_y => pixel_y);
		
end Behavioral; 