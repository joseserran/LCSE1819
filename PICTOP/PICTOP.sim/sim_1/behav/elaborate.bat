@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 9d11ef5121cd4264b846168fc94b35df -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot PICtop_tb_behav xil_defaultlib.PICtop_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
