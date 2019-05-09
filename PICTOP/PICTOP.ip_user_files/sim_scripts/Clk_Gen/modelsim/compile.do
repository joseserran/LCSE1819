vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../PICTOP.srcs/sources_1/ip/Clk_Gen" "+incdir+../../../../PICTOP.srcs/sources_1/ip/Clk_Gen" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../PICTOP.srcs/sources_1/ip/Clk_Gen/Clk_Gen_sim_netlist.vhdl" \


vlog -work xil_defaultlib \
"glbl.v"

