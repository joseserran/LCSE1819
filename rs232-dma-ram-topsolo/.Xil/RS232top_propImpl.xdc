set_property SRC_FILE_INFO {cfile:c:/Users/joseangelSSD/Documents/LCSE1819/RS232TOP/RS232TOP.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc rfile:../../RS232TOP/RS232TOP.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc id:1 order:EARLY scoped_inst:Clock_generator/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/joseangelSSD/Documents/LCSE1819/RS232/RS232top.xdc rfile:../../RS232/RS232top.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
set_property src_info {type:XDC file:2 line:44 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { ACK_in }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[11]
