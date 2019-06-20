set_property SRC_FILE_INFO {cfile:c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc rfile:../rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc id:1 order:EARLY scoped_inst:bloqueRS232/Clock_generator/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
