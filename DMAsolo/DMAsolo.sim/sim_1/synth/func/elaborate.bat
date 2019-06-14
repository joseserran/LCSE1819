@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto da6d5d8f81024384b6b0fda14f9d9c5c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot DMA_tb_func_synth xil_defaultlib.DMA_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
