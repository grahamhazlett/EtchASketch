@echo off
REM ****************************************************************************
REM Vivado (TM) v2017.3.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Tue Aug 28 13:51:15 -0400 2018
REM SW Build 2035080 on Fri Oct 20 14:20:01 MDT 2017
REM
REM Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
call xsim encoder_logic_tb_behav -key {Behavioral:sim_1:Functional:encoder_logic_tb} -tclbatch encoder_logic_tb.tcl -view P:/18summer/engs031/G19/Etch-a-Sketch/encoder_logic_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
