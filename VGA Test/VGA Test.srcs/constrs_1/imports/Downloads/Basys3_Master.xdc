## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#Bank = 34, Pin name = CLK,					Sch name = CLK100MHZ
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 20.000 -name sys_clk_pin -waveform {0.000 10.000} -add [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {background_blue}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {background_blue}]
set_property PACKAGE_PIN V16 [get_ports {background_green}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {background_green}]
set_property PACKAGE_PIN W16 [get_ports {background_red}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {background_red}]

set_property PACKAGE_PIN U1 [get_ports {switch_blue}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_blue}]
set_property PACKAGE_PIN T1 [get_ports {switch_green}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_green}]
set_property PACKAGE_PIN R2 [get_ports {switch_red}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_red}]
 

#Pmod Header JA
#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {hor_a}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hor_a}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {hor_b}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hor_b}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {clear}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {clear}]


#Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {vert_a}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {vert_a}]
#Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {vert_b}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {vert_b}]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {up_down}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {up_down}]
	

#VGA Connector
set_property PACKAGE_PIN G19 [get_ports {pixel_data[8]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[8]}]
set_property PACKAGE_PIN H19 [get_ports {pixel_data[9]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[9]}]
set_property PACKAGE_PIN J19 [get_ports {pixel_data[10]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[10]}]
set_property PACKAGE_PIN N19 [get_ports {pixel_data[11]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[11]}]
set_property PACKAGE_PIN N18 [get_ports {pixel_data[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[0]}]
set_property PACKAGE_PIN L18 [get_ports {pixel_data[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[1]}]
set_property PACKAGE_PIN K18 [get_ports {pixel_data[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[2]}]
set_property PACKAGE_PIN J18 [get_ports {pixel_data[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[3]}]
set_property PACKAGE_PIN J17 [get_ports {pixel_data[4]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[4]}]
set_property PACKAGE_PIN H17 [get_ports {pixel_data[5]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[5]}]
set_property PACKAGE_PIN G17 [get_ports {pixel_data[6]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[6]}]
set_property PACKAGE_PIN D17 [get_ports {pixel_data[7]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {pixel_data[7]}]
set_property PACKAGE_PIN P19 [get_ports Hsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
set_property PACKAGE_PIN R19 [get_ports Vsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports Vsync]


## These additional constraints are recommended by Digilent
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
