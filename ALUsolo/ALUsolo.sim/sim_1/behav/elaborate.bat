@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 9e84e437ff0e403b8c933b4a20c8f088 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot ALU_tb_behav xil_defaultlib.ALU_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
