@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim PICtop_tb_behav -key {Behavioral:sim_1:Functional:PICtop_tb} -tclbatch PICtop_tb.tcl -view C:/Users/joseangelSSD/Documents/LCSE1819/PICTOP/PICtop_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
