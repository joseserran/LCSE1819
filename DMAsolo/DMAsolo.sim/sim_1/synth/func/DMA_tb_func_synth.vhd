-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
-- Date        : Fri Jun 14 20:59:29 2019
-- Host        : joseangelSSD-PC running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/joseangelSSD/Documents/LCSE1819/DMAsolo/DMAsolo.sim/sim_1/synth/func/DMA_tb_func_synth.vhd
-- Design      : DMA
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity DMA is
  port (
    Reset : in STD_LOGIC;
    CLK100MHZ : in STD_LOGIC;
    RCVD_Data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    RX_Full : in STD_LOGIC;
    RX_Empty : in STD_LOGIC;
    Data_Read : out STD_LOGIC;
    ACK_out : in STD_LOGIC;
    TX_RDY : in STD_LOGIC;
    Valid_D : out STD_LOGIC;
    TX_Data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Address : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Databus : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    Write_en : out STD_LOGIC;
    OE : out STD_LOGIC;
    DMA_RQ : out STD_LOGIC;
    DMA_ACK : in STD_LOGIC;
    Send_comm : in STD_LOGIC;
    READY : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of DMA : entity is true;
end DMA;

architecture STRUCTURE of DMA is
  signal ACK_out_IBUF : STD_LOGIC;
  signal Address_OBUF : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \Address_OBUFT[7]_inst_i_2_n_0\ : STD_LOGIC;
  signal \Address_OBUFT[7]_inst_i_3_n_0\ : STD_LOGIC;
  signal \Address_TRI[0]\ : STD_LOGIC;
  signal \Address_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \Address_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \Address_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \Address_reg[2]_i_2_n_0\ : STD_LOGIC;
  signal CLK100MHZ_IBUF : STD_LOGIC;
  signal CLK100MHZ_IBUF_BUFG : STD_LOGIC;
  signal DMA_ACK_IBUF : STD_LOGIC;
  signal DMA_RQ_OBUF : STD_LOGIC;
  signal DMA_RQ_reg_i_2_n_0 : STD_LOGIC;
  signal Data_Read_OBUF : STD_LOGIC;
  signal Data_Read_reg_i_1_n_0 : STD_LOGIC;
  signal Data_Read_reg_i_2_n_0 : STD_LOGIC;
  signal Databus_IBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \Databus_IOBUF[7]_inst_i_2_n_0\ : STD_LOGIC;
  signal \Databus_IOBUF[7]_inst_i_3_n_0\ : STD_LOGIC;
  signal Databus_OBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \Databus_TRI[0]\ : STD_LOGIC;
  signal \Databus_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \Databus_reg[7]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_a[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_s_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_s_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_s_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_s_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_s_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_estado_s_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal OE_TRI : STD_LOGIC;
  signal RCVD_Data_IBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal READY_OBUF : STD_LOGIC;
  signal RX_Empty_IBUF : STD_LOGIC;
  signal Reset_IBUF : STD_LOGIC;
  signal Send_comm_IBUF : STD_LOGIC;
  signal TX_Data_OBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \TX_Data_OBUFT[7]_inst_i_2_n_0\ : STD_LOGIC;
  signal \TX_Data_OBUFT[7]_inst_i_3_n_0\ : STD_LOGIC;
  signal TX_RDY_IBUF : STD_LOGIC;
  signal Valid_D_OBUF : STD_LOGIC;
  signal Valid_D_reg_i_1_n_0 : STD_LOGIC;
  signal Valid_D_reg_i_2_n_0 : STD_LOGIC;
  signal Write_en0 : STD_LOGIC;
  signal Write_en_OBUFT_inst_i_2_n_0 : STD_LOGIC;
  signal Write_en_TRI : STD_LOGIC;
  signal estado_a : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of estado_a : signal is "yes";
  signal estado_s : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \Address_OBUFT[7]_inst_i_2\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Address_reg[0]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Address_reg[1]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Address_reg[2]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of DMA_RQ_reg : label is "LD";
  attribute XILINX_LEGACY_PRIM of Data_Read_reg : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_IOBUF[7]_inst_i_2\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[0]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[1]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[2]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[3]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[4]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[5]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[6]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \Databus_reg[7]\ : label is "LD";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_estado_a_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_estado_a_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_estado_a_reg[2]\ : label is "yes";
  attribute KEEP of \FSM_sequential_estado_a_reg[3]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \FSM_sequential_estado_s_reg[0]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \FSM_sequential_estado_s_reg[1]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \FSM_sequential_estado_s_reg[2]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \FSM_sequential_estado_s_reg[3]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_OBUFT[7]_inst_i_2\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[0]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[1]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[2]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[3]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[4]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[5]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[6]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \TX_Data_reg[7]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of Valid_D_reg : label is "LD";
  attribute XILINX_LEGACY_PRIM of Write_en_OBUFT_inst_i_2 : label is "LD";
begin
ACK_out_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => ACK_out,
      O => ACK_out_IBUF
    );
\Address_OBUFT[0]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => Address_OBUF(0),
      O => Address(0),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[1]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => Address_OBUF(1),
      O => Address(1),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[2]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => Address_OBUF(2),
      O => Address(2),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[3]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Address(3),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[4]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Address(4),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[5]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Address(5),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[6]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Address(6),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[7]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => Address(7),
      T => \Address_TRI[0]\
    );
\Address_OBUFT[7]_inst_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \Address_OBUFT[7]_inst_i_2_n_0\,
      O => \Address_TRI[0]\
    );
\Address_OBUFT[7]_inst_i_2\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Address_OBUFT[7]_inst_i_3_n_0\,
      G => \Address_reg[2]_i_2_n_0\,
      GE => '1',
      Q => \Address_OBUFT[7]_inst_i_2_n_0\
    );
\Address_OBUFT[7]_inst_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3334"
    )
        port map (
      I0 => estado_a(0),
      I1 => estado_a(3),
      I2 => estado_a(2),
      I3 => estado_a(1),
      O => \Address_OBUFT[7]_inst_i_3_n_0\
    );
\Address_reg[0]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Address_reg[0]_i_1_n_0\,
      G => \Address_reg[2]_i_2_n_0\,
      GE => '1',
      Q => Address_OBUF(0)
    );
\Address_reg[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"001F"
    )
        port map (
      I0 => estado_a(2),
      I1 => estado_a(1),
      I2 => estado_a(3),
      I3 => estado_a(0),
      O => \Address_reg[0]_i_1_n_0\
    );
\Address_reg[1]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Address_reg[1]_i_1_n_0\,
      G => \Address_reg[2]_i_2_n_0\,
      GE => '1',
      Q => Address_OBUF(1)
    );
\Address_reg[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0057"
    )
        port map (
      I0 => estado_a(3),
      I1 => estado_a(2),
      I2 => estado_a(0),
      I3 => estado_a(1),
      O => \Address_reg[1]_i_1_n_0\
    );
\Address_reg[2]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Address_reg[2]_i_1_n_0\,
      G => \Address_reg[2]_i_2_n_0\,
      GE => '1',
      Q => Address_OBUF(2)
    );
\Address_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => estado_a(3),
      I1 => estado_a(2),
      O => \Address_reg[2]_i_1_n_0\
    );
\Address_reg[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5447"
    )
        port map (
      I0 => estado_a(3),
      I1 => estado_a(1),
      I2 => estado_a(2),
      I3 => estado_a(0),
      O => \Address_reg[2]_i_2_n_0\
    );
CLK100MHZ_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => CLK100MHZ_IBUF,
      O => CLK100MHZ_IBUF_BUFG
    );
CLK100MHZ_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => CLK100MHZ,
      O => CLK100MHZ_IBUF
    );
DMA_ACK_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => DMA_ACK,
      O => DMA_ACK_IBUF
    );
DMA_RQ_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => DMA_RQ_OBUF,
      O => DMA_RQ
    );
DMA_RQ_reg: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Write_en0,
      G => DMA_RQ_reg_i_2_n_0,
      GE => '1',
      Q => DMA_RQ_OBUF
    );
DMA_RQ_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2226"
    )
        port map (
      I0 => estado_a(2),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(1),
      O => Write_en0
    );
DMA_RQ_reg_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4447"
    )
        port map (
      I0 => estado_a(3),
      I1 => estado_a(2),
      I2 => estado_a(0),
      I3 => estado_a(1),
      O => DMA_RQ_reg_i_2_n_0
    );
Data_Read_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => Data_Read_OBUF,
      O => Data_Read
    );
Data_Read_reg: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Data_Read_reg_i_1_n_0,
      G => Data_Read_reg_i_2_n_0,
      GE => '1',
      Q => Data_Read_OBUF
    );
Data_Read_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => estado_a(2),
      I1 => estado_a(3),
      O => Data_Read_reg_i_1_n_0
    );
Data_Read_reg_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4441"
    )
        port map (
      I0 => estado_a(3),
      I1 => estado_a(2),
      I2 => estado_a(1),
      I3 => estado_a(0),
      O => Data_Read_reg_i_2_n_0
    );
\Databus_IOBUF[0]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(0),
      IO => Databus(0),
      O => Databus_IBUF(0),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[1]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(1),
      IO => Databus(1),
      O => Databus_IBUF(1),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[2]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(2),
      IO => Databus(2),
      O => Databus_IBUF(2),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[3]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(3),
      IO => Databus(3),
      O => Databus_IBUF(3),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[4]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(4),
      IO => Databus(4),
      O => Databus_IBUF(4),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[5]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(5),
      IO => Databus(5),
      O => Databus_IBUF(5),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[6]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(6),
      IO => Databus(6),
      O => Databus_IBUF(6),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[7]_inst\: unisim.vcomponents.IOBUF
     port map (
      I => Databus_OBUF(7),
      IO => Databus(7),
      O => Databus_IBUF(7),
      T => \Databus_TRI[0]\
    );
\Databus_IOBUF[7]_inst_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \Databus_IOBUF[7]_inst_i_2_n_0\,
      O => \Databus_TRI[0]\
    );
\Databus_IOBUF[7]_inst_i_2\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_IOBUF[7]_inst_i_3_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => \Databus_IOBUF[7]_inst_i_2_n_0\
    );
\Databus_IOBUF[7]_inst_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01E0"
    )
        port map (
      I0 => estado_a(1),
      I1 => estado_a(0),
      I2 => estado_a(2),
      I3 => estado_a(3),
      O => \Databus_IOBUF[7]_inst_i_3_n_0\
    );
\Databus_reg[0]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[0]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(0)
    );
\Databus_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(0),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[0]_i_1_n_0\
    );
\Databus_reg[1]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[1]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(1)
    );
\Databus_reg[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(1),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[1]_i_1_n_0\
    );
\Databus_reg[2]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[2]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(2)
    );
\Databus_reg[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(2),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[2]_i_1_n_0\
    );
\Databus_reg[3]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[3]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(3)
    );
\Databus_reg[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(3),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[3]_i_1_n_0\
    );
\Databus_reg[4]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[4]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(4)
    );
\Databus_reg[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(4),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[4]_i_1_n_0\
    );
\Databus_reg[5]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[5]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(5)
    );
\Databus_reg[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(5),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[5]_i_1_n_0\
    );
\Databus_reg[6]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[6]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(6)
    );
\Databus_reg[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(6),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[6]_i_1_n_0\
    );
\Databus_reg[7]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \Databus_reg[7]_i_1_n_0\,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Databus_OBUF(7)
    );
\Databus_reg[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2222222F"
    )
        port map (
      I0 => RCVD_Data_IBUF(7),
      I1 => estado_a(3),
      I2 => estado_a(0),
      I3 => estado_a(2),
      I4 => estado_a(1),
      O => \Databus_reg[7]_i_1_n_0\
    );
\Databus_reg[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01E1"
    )
        port map (
      I0 => estado_a(1),
      I1 => estado_a(0),
      I2 => estado_a(2),
      I3 => estado_a(3),
      O => \Databus_reg[7]_i_2_n_0\
    );
\FSM_sequential_estado_a[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Reset_IBUF,
      O => \FSM_sequential_estado_a[3]_i_1_n_0\
    );
\FSM_sequential_estado_a_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK100MHZ_IBUF_BUFG,
      CE => '1',
      CLR => \FSM_sequential_estado_a[3]_i_1_n_0\,
      D => estado_s(0),
      Q => estado_a(0)
    );
\FSM_sequential_estado_a_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK100MHZ_IBUF_BUFG,
      CE => '1',
      CLR => \FSM_sequential_estado_a[3]_i_1_n_0\,
      D => estado_s(1),
      Q => estado_a(1)
    );
\FSM_sequential_estado_a_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK100MHZ_IBUF_BUFG,
      CE => '1',
      CLR => \FSM_sequential_estado_a[3]_i_1_n_0\,
      D => estado_s(2),
      Q => estado_a(2)
    );
\FSM_sequential_estado_a_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK100MHZ_IBUF_BUFG,
      CE => '1',
      CLR => \FSM_sequential_estado_a[3]_i_1_n_0\,
      D => estado_s(3),
      Q => estado_a(3)
    );
\FSM_sequential_estado_s_reg[0]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \FSM_sequential_estado_s_reg[0]_i_1_n_0\,
      G => \FSM_sequential_estado_s_reg[3]_i_2_n_0\,
      GE => '1',
      Q => estado_s(0)
    );
\FSM_sequential_estado_s_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000FE"
    )
        port map (
      I0 => estado_a(2),
      I1 => Send_comm_IBUF,
      I2 => estado_a(1),
      I3 => estado_a(0),
      I4 => estado_a(3),
      O => \FSM_sequential_estado_s_reg[0]_i_1_n_0\
    );
\FSM_sequential_estado_s_reg[1]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \FSM_sequential_estado_s_reg[1]_i_1_n_0\,
      G => \FSM_sequential_estado_s_reg[3]_i_2_n_0\,
      GE => '1',
      Q => estado_s(1)
    );
\FSM_sequential_estado_s_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => estado_a(0),
      I1 => estado_a(1),
      O => \FSM_sequential_estado_s_reg[1]_i_1_n_0\
    );
\FSM_sequential_estado_s_reg[2]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \FSM_sequential_estado_s_reg[2]_i_1_n_0\,
      G => \FSM_sequential_estado_s_reg[3]_i_2_n_0\,
      GE => '1',
      Q => estado_s(2)
    );
\FSM_sequential_estado_s_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111555500000001"
    )
        port map (
      I0 => estado_a(3),
      I1 => estado_a(0),
      I2 => Send_comm_IBUF,
      I3 => RX_Empty_IBUF,
      I4 => estado_a(1),
      I5 => estado_a(2),
      O => \FSM_sequential_estado_s_reg[2]_i_1_n_0\
    );
\FSM_sequential_estado_s_reg[3]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \FSM_sequential_estado_s_reg[3]_i_1_n_0\,
      G => \FSM_sequential_estado_s_reg[3]_i_2_n_0\,
      GE => '1',
      Q => estado_s(3)
    );
\FSM_sequential_estado_s_reg[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => estado_a(1),
      I1 => estado_a(0),
      I2 => estado_a(2),
      O => \FSM_sequential_estado_s_reg[3]_i_1_n_0\
    );
\FSM_sequential_estado_s_reg[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF5540404F"
    )
        port map (
      I0 => estado_a(3),
      I1 => ACK_out_IBUF,
      I2 => estado_a(1),
      I3 => estado_a(0),
      I4 => estado_a(2),
      I5 => \FSM_sequential_estado_s_reg[3]_i_3_n_0\,
      O => \FSM_sequential_estado_s_reg[3]_i_2_n_0\
    );
\FSM_sequential_estado_s_reg[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55045004"
    )
        port map (
      I0 => estado_a(3),
      I1 => TX_RDY_IBUF,
      I2 => estado_a(1),
      I3 => estado_a(2),
      I4 => DMA_ACK_IBUF,
      O => \FSM_sequential_estado_s_reg[3]_i_3_n_0\
    );
OE_OBUFT_inst: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => OE,
      T => OE_TRI
    );
\RCVD_Data_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(0),
      O => RCVD_Data_IBUF(0)
    );
\RCVD_Data_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(1),
      O => RCVD_Data_IBUF(1)
    );
\RCVD_Data_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(2),
      O => RCVD_Data_IBUF(2)
    );
\RCVD_Data_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(3),
      O => RCVD_Data_IBUF(3)
    );
\RCVD_Data_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(4),
      O => RCVD_Data_IBUF(4)
    );
\RCVD_Data_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(5),
      O => RCVD_Data_IBUF(5)
    );
\RCVD_Data_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(6),
      O => RCVD_Data_IBUF(6)
    );
\RCVD_Data_IBUF[7]_inst\: unisim.vcomponents.IBUF
     port map (
      I => RCVD_Data(7),
      O => RCVD_Data_IBUF(7)
    );
READY_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => READY_OBUF,
      O => READY
    );
READY_OBUF_inst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => Send_comm_IBUF,
      I1 => RX_Empty_IBUF,
      I2 => estado_a(2),
      I3 => estado_a(1),
      I4 => estado_a(3),
      I5 => estado_a(0),
      O => READY_OBUF
    );
RX_Empty_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => RX_Empty,
      O => RX_Empty_IBUF
    );
Reset_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => Reset,
      O => Reset_IBUF
    );
Send_comm_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => Send_comm,
      O => Send_comm_IBUF
    );
\TX_Data_OBUFT[0]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(0),
      O => TX_Data(0),
      T => OE_TRI
    );
\TX_Data_OBUFT[1]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(1),
      O => TX_Data(1),
      T => OE_TRI
    );
\TX_Data_OBUFT[2]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(2),
      O => TX_Data(2),
      T => OE_TRI
    );
\TX_Data_OBUFT[3]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(3),
      O => TX_Data(3),
      T => OE_TRI
    );
\TX_Data_OBUFT[4]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(4),
      O => TX_Data(4),
      T => OE_TRI
    );
\TX_Data_OBUFT[5]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(5),
      O => TX_Data(5),
      T => OE_TRI
    );
\TX_Data_OBUFT[6]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(6),
      O => TX_Data(6),
      T => OE_TRI
    );
\TX_Data_OBUFT[7]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => TX_Data_OBUF(7),
      O => TX_Data(7),
      T => OE_TRI
    );
\TX_Data_OBUFT[7]_inst_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \TX_Data_OBUFT[7]_inst_i_2_n_0\,
      O => OE_TRI
    );
\TX_Data_OBUFT[7]_inst_i_2\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \TX_Data_OBUFT[7]_inst_i_3_n_0\,
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => \TX_Data_OBUFT[7]_inst_i_2_n_0\
    );
\TX_Data_OBUFT[7]_inst_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => estado_a(1),
      I1 => estado_a(3),
      O => \TX_Data_OBUFT[7]_inst_i_3_n_0\
    );
\TX_Data_reg[0]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(0),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(0)
    );
\TX_Data_reg[1]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(1),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(1)
    );
\TX_Data_reg[2]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(2),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(2)
    );
\TX_Data_reg[3]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(3),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(3)
    );
\TX_Data_reg[4]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(4),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(4)
    );
\TX_Data_reg[5]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(5),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(5)
    );
\TX_Data_reg[6]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(6),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(6)
    );
\TX_Data_reg[7]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Databus_IBUF(7),
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => TX_Data_OBUF(7)
    );
TX_RDY_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => TX_RDY,
      O => TX_RDY_IBUF
    );
Valid_D_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => Valid_D_OBUF,
      O => Valid_D
    );
Valid_D_reg: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Valid_D_reg_i_1_n_0,
      G => Valid_D_reg_i_2_n_0,
      GE => '1',
      Q => Valid_D_OBUF
    );
Valid_D_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => estado_a(1),
      I1 => estado_a(3),
      O => Valid_D_reg_i_1_n_0
    );
Valid_D_reg_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000D"
    )
        port map (
      I0 => estado_a(0),
      I1 => estado_a(1),
      I2 => estado_a(3),
      I3 => estado_a(2),
      O => Valid_D_reg_i_2_n_0
    );
Write_en_OBUFT_inst: unisim.vcomponents.OBUFT
     port map (
      I => '1',
      O => Write_en,
      T => Write_en_TRI
    );
Write_en_OBUFT_inst_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Write_en_OBUFT_inst_i_2_n_0,
      O => Write_en_TRI
    );
Write_en_OBUFT_inst_i_2: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => Write_en0,
      G => \Databus_reg[7]_i_2_n_0\,
      GE => '1',
      Q => Write_en_OBUFT_inst_i_2_n_0
    );
end STRUCTURE;
