@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto dd5f14d2c87b41d99ca49f7423ce1af2 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot RS232dmaramtop_TB_behav xil_defaultlib.RS232dmaramtop_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
