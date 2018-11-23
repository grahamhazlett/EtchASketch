# Digital Etch-A-Sketch

This digital Etch-A-Sketch project was implemented using VHDL, uploaded to a FPGA board. The project takes input from two rotary encoders, and displays the output to a monitor via VGA output. The functionality, design process, high level logic, and code are documented.

![](documentation/Func.png)

Detailed documentation of the functionality and design of the project can be found in the [Final Project Report](Final%20Project%20Report.pdf), and in the supporting [Final Project Report Appendix](Final%20Project%20Report%20Appendix.pdf).


VHDL files which are especially relevant to the design of the project are:

[top_level_shell.vhd](Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/new/top_level_shell.vhd): The top level shell code for the entire project, linking individual components together and facilitating the overall functionality of the project.

[cursor_logic.vhd](Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/new/cursor_logic.vhd): A component dictating the motion of the Etch-A-Sketch cursor based on input signals and screen bounds.

[encoder_logic.vhd](Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/new/encoder_logic.vhd): A component to interpret signals coming from the rotary encoders into signals for the cursor movement.

[debouncer.vhd](Etch-a-Sketch/Etch-a-Sketch.srcs/sources_1/new/debouncer.vhd): A component responsible for debouncing the noisy signal coming from raw button and rotary encoder inputs for reliable processing.
