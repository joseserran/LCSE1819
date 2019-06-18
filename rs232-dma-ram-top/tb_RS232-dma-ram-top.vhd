
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   
entity RS232dmaramtop_TB is
end RS232dmaramtop_TB;

architecture Testbench of RS232dmaramtop_TB is

  component RS232dmaramtop
    port (
    Reset     : in  std_logic;   -- Low_level-active asynchronous reset
    CLK100MHZ : in  std_logic;   -- System clock (20MHz), rising edge used
    --Data_in   : in  std_logic_vector(7 downto 0);  -- Data to be sent
    --ACK_in    : out std_logic;   -- ACK for data received, low once data
    TD        : out std_logic;   -- RS232 Transmission line
    RD        : in  std_logic;   -- RS232 Reception line
    --Data_out  : out std_logic_vector(7 downto 0);  -- Received data
    --Full      : out std_logic;   -- Full internal memory
    --Empty     : out std_logic;
    databus  : inout std_logic_vector(7 downto 0);
    switches : out   std_logic_vector(7 downto 0);
    Temp_L   : out   std_logic_vector(6 downto 0);
    Temp_H   : out   std_logic_vector(6 downto 0);
    --RCVD_Data    : in    std_logic_vector(7 downto 0);
    --RX_Full      : in    std_logic;
    --RX_Empty     : in    std_logic;
    --ACK_out      : in    std_logic;
    --TX_Data      : out    std_logic_vector(7 downto 0);
    DMA_RQ       : out    std_logic;
    DMA_ACK      : in     std_logic;
    Send_comm    : in    std_logic;
    READY        : out   std_logic     

       );
  end component;
  
  signal Reset, Clk, DMA_RQ, DMA_ACK,Send_comm, READY : std_logic;--eliminado:TX_RDY, Data_read
  signal TD, RD : std_logic;
  signal  switches,databus : std_logic_vector(7 downto 0);
  signal Temp_L,Temp_H  : std_logic_vector(6 downto 0);

begin

  UUT: RS232dmaramtop
    port map (
      Reset         => Reset    ,
      Clk100MHz     => Clk      ,
      --Data_in       => Data_in  ,
      TD            => TD       ,
      RD            => RD       ,
      databus       => databus  ,
      switches      => switches ,
      Temp_L        => Temp_L   ,
      Temp_H        => Temp_H   ,
      --TX_Data       => TX_Data  ,
      DMA_RQ        => DMA_RQ   ,
      DMA_ACK       => DMA_ACK  ,
      Send_comm     => Send_comm,
      READY         => READY
      );

 -- Data_in <= "11100010";-- after 100000 ns;
  
  -- Clock generator
  p_clk : PROCESS
  BEGIN
     clk <= '1', '0' after 5 ns;
     wait for 10 ns;
  END PROCESS;

  -- Reset & Start generator
  p_reset : PROCESS
  BEGIN
     reset <= '0', '1' after 200 ns;
    -- TD <= "11100010" after 100000 ns;
    
    
    
    

--concesion por parte del control princpal de buses a la DMA
        DMA_ACK <= '0', '1' after 87 us,'0' after 88 us, '1' after 187 us, '0' after 188 us, '1' after 300 us,'0' after 300030 ns;-- '0' after 87010 ns, '1' after 187 us, '0' after 187010 ns, '1' after 287 us, '0' after 287010 ns; --despues de llegar los tres datos   

--peticion porparte del ocntorl prncipal que envie datos
          Send_comm <='0', '0' after 110 us,'1' after 350 us, '0' after 400 us;
          
          
 ----    un bit con mas retraso               
          RD <= '1',
           '0' after 500 ns,    -- StartBit
                '1' after 9150 ns,   -- LSb
                '0' after 17800 ns,
                '0' after 26450 ns,
                '1' after 35100 ns,
                '1' after 43750 ns,
                '1' after 52400 ns,
                '1' after 61050 ns,
                '0' after 69700 ns,  -- MSb
                '1' after 78350 ns,  -- Stopbit
                '1' after 87000 ns,

-- -- con un segundo bit
     
               '0' after 100500 ns,    -- StartBit
               '1' after 109150 ns,   -- LSb
               '1' after 117800 ns,
               '1' after 126450 ns,
               '0' after 135100 ns,
               '1' after 143750 ns,
               '0' after 152400 ns,
               '1' after 161050 ns,
               '0' after 169700 ns,  -- MSb
               '1' after 178350 ns,  -- Stopbit
               '1' after 187000 ns,
               
 -- -- con un tercer bit
                    
                              '0' after 200500 ns,    -- StartBit
                              '0' after 209150 ns,   -- LSb
                              '0' after 217800 ns,
                              '1' after 226450 ns,
                              '1' after 235100 ns,
                              '1' after 243750 ns,
                              '0' after 252400 ns,
                              '0' after 261050 ns,
                              '1' after 269700 ns,  -- MSb
                              '1' after 278350 ns,  -- Stopbit
                              '1' after 287000 ns;
               
 --Data_read <= '0','1'after 88000 ns; se encarga la DMA

     wait;
  END PROCESS;

end Testbench;

