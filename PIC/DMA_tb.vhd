
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;



entity DMA_tb is
end DMA_tb;

architecture testbench of DMA_tb is
    component DMA
    Port(
       Reset        : in    std_logic;
       CLK100MHZ          : in    std_logic;
       RCVD_Data    : in    std_logic_vector(7 downto 0);
       RX_Full      : in    std_logic;
       RX_Empty     : in    std_logic;
       Data_Read    : out    std_logic;
       ACK_out      : in    std_logic;
       TX_RDY       : in    std_logic;
       Valid_D      : out    std_logic;
       TX_Data      : out    std_logic_vector(7 downto 0);
       Address      : out    std_logic_vector(7 downto 0);
       Databus      : inout    std_logic_vector(7 downto 0);
       Write_en     : out    std_logic;
       OE           : out    std_logic;
       DMA_RQ       : out    std_logic;
       DMA_ACK      : in     std_logic;
       Send_comm    : in    std_logic;
       READY        : out   std_logic
       );
    end component;
    signal Reset, Clk,RX_Full,RX_Empty,Data_Read,ACK_out,TX_RDY,Valid_D,Write_en,OE,DMA_RQ,DMA_ACK,Send_comm, READY : std_logic;     
    signal  RCVD_Data,TX_Data,Address,Databus : std_logic_vector(7 downto 0);          
begin
UUT: DMA
port map(
Reset     =>Reset     ,
CLK100MHZ       =>Clk       ,
RCVD_Data =>RCVD_Data ,
RX_Full   =>RX_Full   ,
RX_Empty  =>RX_Empty  ,
Data_Read =>Data_Read ,
ACK_out   =>ACK_out   ,
TX_RDY    =>TX_RDY    ,   
Valid_D   =>Valid_D   ,   
TX_Data   =>TX_Data   ,   
Address   =>Address   ,   
Databus   =>Databus   ,   
Write_en  =>Write_en  ,   
OE        =>OE        ,   
DMA_RQ    =>DMA_RQ    ,   
DMA_ACK   =>DMA_ACK   ,   
Send_comm =>Send_comm ,   
READY     =>READY       
);

Databus<="ZZZZZZZZ", "11100010" after 100 ns, "ZZZZZZZZ" after 850 ns;
RCVD_Data<="10101011";

 -- Clock generator
  p_clk : process
  begin
     clk <= '1', '0' after 25 ns;
     wait for 50 ns;
  end process;
  
-- Reset & Start generator
    p_reset : process
begin
       reset <= '0', '1' after 75 ns;
       RX_Empty <= '0', '1' after 100 ns,  '0' after 800 ns, '1' after 1150 ns,  '0' after 1300 ns, '1' after 1550 ns;
       RX_Full <=  '0';--, '1' after 800 ns;
       Send_comm <= '0', '1' after 200 ns, '0' after 350 ns;--,'1' after 600 ns, '0' after 800 ns;
       TX_RDY <='0', '1' after 210 ns,  '0' after 1325 ns, '1' after 1425 ns;
       ACK_out <= '1', '0' after 300 ns,-- '1' after 400 ns, '0' after 450 ns, 
       '1' after 410 ns,  '0' after 600 ns, '1' after 880 ns;
       DMA_ACK <= '0', '1' after 1000 ns;
        wait;
end process;
end testbench;



















