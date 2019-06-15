
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

USE work.PIC_pkg.all;

entity CPU is
    port ( 
        Reset       : in  STD_LOGIC;
        CLK100MHZ         : in  STD_LOGIC;
        ROM_Data    : in  STD_LOGIC_VECTOR (11 downto 0);
        ROM_Addr    : out  STD_LOGIC_VECTOR (11 downto 0);
        RAM_Addr    : out  STD_LOGIC_VECTOR (7 downto 0);
        RAM_Write   : out  STD_LOGIC;
        RAM_OE      : out  STD_LOGIC;
        Databus     : inout  STD_LOGIC_VECTOR (7 downto 0);
        DMA_RQ      : in  STD_LOGIC;
        DMA_ACK     : out  STD_LOGIC;
        SEND_comm   : out  STD_LOGIC;
        DMA_READY   : in  STD_LOGIC;
        Alu_op      : out  alu_op;
        Index_Reg   : in  STD_LOGIC_VECTOR (7 downto 0);
        FlagZ       : in  STD_LOGIC);
end CPU;

architecture behavior of CPU is
	type state is (idle);
	signal A, B, acumulador : STD_LOGIC_VECTOR (7 downto 0);

begin

process(CLK100MHZ, reset)  

begin

    if Reset = '0' then
        
	
	elsif CLK100MHZ'event and CLK100MHZ='1' then
	   
       
               
    end if;
end process;



end behavior;