@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim RS232dmaramtop_TB_behav -key {Behavioral:sim_1:Functional:RS232dmaramtop_TB} -tclbatch RS232dmaramtop_TB.tcl -view C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/RS232dmaramtop_TB_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
