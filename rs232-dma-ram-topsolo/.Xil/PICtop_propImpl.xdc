set_property SRC_FILE_INFO {cfile:c:/Users/joseangelSSD/Documents/LCSE1819/PICTOP/PICTOP.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc rfile:../../PICTOP/PICTOP.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc id:1 order:EARLY scoped_inst:rs232dmaramtop_bloque/bloqueRS232/Clock_generator/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/joseangelSSD/Documents/LCSE1819/PIC/PICtop.xdc rfile:../../PIC/PICtop.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
set_property src_info {type:XDC file:2 line:60 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { temp[0] }]; #IO_L24N_T3_A00_D16_14 Sch=ca
set_property src_info {type:XDC file:2 line:61 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { temp[1] }]; #IO_25_14 Sch=cb
set_property src_info {type:XDC file:2 line:62 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { temp[2] }]; #IO_25_15 Sch=cc
set_property src_info {type:XDC file:2 line:63 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { temp[3] }]; #IO_L17P_T2_A26_15 Sch=cd
set_property src_info {type:XDC file:2 line:64 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { temp[4] }]; #IO_L13P_T2_MRCC_14 Sch=ce
set_property src_info {type:XDC file:2 line:65 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { temp[5] }]; #IO_L19P_T3_A10_D26_14 Sch=cf
set_property src_info {type:XDC file:2 line:66 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { temp[6] }]; #IO_L4P_T0_D04_14 Sch=cg
set_property src_info {type:XDC file:2 line:70 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { disp[0] }]; #IO_L23P_T3_FOE_B_15 Sch=an[0]
set_property src_info {type:XDC file:2 line:71 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { disp[1] }]; #IO_L23N_T3_FWE_B_15 Sch=an[1]
set_property src_info {type:XDC file:2 line:96 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { TD }]; #RS232_TX }]; #IO_L20N_T3_A19_15 Sch=ja[1]
set_property src_info {type:XDC file:2 line:97 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { RD }]; #RS232_RX }]; #IO_L21N_T3_DQS_A18_15 Sch=ja[2]
