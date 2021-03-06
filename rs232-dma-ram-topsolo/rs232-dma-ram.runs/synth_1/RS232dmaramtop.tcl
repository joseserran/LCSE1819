# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.cache/wt [current_project]
set_property parent.project_path C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/joseangelSSD/Documents/LCSE1819/PIC/PIC_pkg.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/PIC/DMA.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/PIC/RAM.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/RS232/RS232_RX.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/RS232/RS232_TX.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/RS232/RS232top.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/RS232/ShiftRegister.vhd
  C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-top/rs232-dma-ram-top.vhd
}
read_ip -quiet C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xci
set_property used_in_implementation false [get_files -all c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xdc]
set_property used_in_implementation false [get_files -all c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen_ooc.xdc]
set_property is_locked true [get_files C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/Clk_Gen/Clk_Gen.xci]

read_ip -quiet C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/fifo/fifo.xci
set_property used_in_implementation false [get_files -all c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/fifo/fifo.xdc]
set_property used_in_implementation false [get_files -all c:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/fifo/fifo_ooc.xdc]
set_property is_locked true [get_files C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-topsolo/rs232-dma-ram.srcs/sources_1/ip/fifo/fifo.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-top/PICtoptriada.xdc
set_property used_in_implementation false [get_files C:/Users/joseangelSSD/Documents/LCSE1819/rs232-dma-ram-top/PICtoptriada.xdc]


synth_design -top RS232dmaramtop -part xc7a100tcsg324-1


write_checkpoint -force -noxdef RS232dmaramtop.dcp

catch { report_utilization -file RS232dmaramtop_utilization_synth.rpt -pb RS232dmaramtop_utilization_synth.pb }
