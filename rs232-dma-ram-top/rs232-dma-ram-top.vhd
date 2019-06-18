
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   
entity RS232dmaramtop is

  port (
     Reset     : in  std_logic;   -- Low_level-active asynchronous reset
     CLK100MHZ : in  std_logic;   -- System clock (20MHz), rising edge used
     --Data_in   : in  std_logic_vector(7 downto 0);  -- Data to be sent
     TD        : out std_logic;   -- RS232 Transmission line
     RD        : in  std_logic;   -- RS232 Reception line
     databus  : inout std_logic_vector(7 downto 0);
     switches : out   std_logic_vector(7 downto 0);
     Temp_L   : out   std_logic_vector(6 downto 0);
     Temp_H   : out   std_logic_vector(6 downto 0);
     --TX_Data      : out    std_logic_vector(7 downto 0);
     DMA_RQ       : out    std_logic;
     DMA_ACK      : in     std_logic;
     Send_comm    : in    std_logic;
     READY        : out   std_logic     

        );
        
end RS232dmaramtop;

architecture RTL of RS232dmaramtop is
 
 
 ------------------------------------------------------------------------
  -- Components for RS232top
  ------------------------------------------------------------------------

  component RS232top
    port (
        Reset     : in  std_logic;   -- Low_level-active asynchronous reset
        CLK100MHZ : in  std_logic;   -- System clock (20MHz), rising edge used
        Data_in   : in  std_logic_vector(7 downto 0);  -- Data to be sent
        Valid_D   : in  std_logic;   -- Handshake signal
        ACK_out    : out std_logic;   -- ACK for data received, low once data
        TX_RDY    : out std_logic;   -- System ready to transmit
        TD        : out std_logic;   -- RS232 Transmission line
        RD        : in  std_logic;   -- RS232 Reception line
        Data_out  : out std_logic_vector(7 downto 0);  -- Received data
        Data_read : in  std_logic;   -- Data read for guest system
        Full      : out std_logic;   -- Full internal memory
        Empty     : out std_logic);  -- Empty internal memory
  end component;

  ------------------------------------------------------------------------
  -- Components for RAM Block
  ------------------------------------------------------------------------

  component RAM
    port (
        Reset    : in    std_logic;
        Clk      : in    std_logic;
        databus  : inout std_logic_vector(7 downto 0);
        address  : in    std_logic_vector(7 downto 0);--cambiado de 3 a 7
        write_en : in    std_logic;
        oe       : in    std_logic;
        switches : out   std_logic_vector(7 downto 0);
        Temp_L   : out   std_logic_vector(6 downto 0);
        Temp_H   : out   std_logic_vector(6 downto 0)
    );
  end component;
  
  ------------------------------------------------------------------------
  -- Components for DMA Block
  ------------------------------------------------------------------------

component DMA is
 Port(
           Reset        : in    std_logic;
           CLK100MHZ    : in    std_logic;
           RCVD_Data    : in    std_logic_vector(7 downto 0);
           RX_Full      : in    std_logic;
           RX_Empty     : in    std_logic;
           Data_Read    : out    std_logic;
           ACK_in      : in    std_logic;
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


  ------------------------------------------------------------------------
  -- Internal Signals
  ------------------------------------------------------------------------
    signal Data_read : std_logic;   -- Data read for guest system
    signal TX_RDY    : std_logic;   -- System ready to transmit 
    signal Valid_D   : std_logic;   -- Handshake signal
    signal address  : std_logic_vector(7 downto 0);
    signal write_en : std_logic;
    signal oe       : std_logic;
    signal ACK_flag    : std_logic;   -- ACK for data received, low once data
    signal RX_Empty, RX_Full    : std_logic;
    signal Data_recibida, Data_in : std_logic_vector(7 downto 0); --dato recibido por la linea RX
    
    
begin  -- RTL

  

  bloqueRS232: RS232top
    port map (
        Reset     => Reset     ,
        CLK100MHZ => CLK100MHZ ,
        Data_in   => Data_in   ,
        Valid_D   => Valid_D   ,
        
        ACK_out    => ACK_flag    ,
    
        TX_RDY    => TX_RDY    ,
        TD        => TD        ,
        RD        => RD        ,
        Data_out  => Data_recibida  ,
        Data_read => Data_read ,
        Full      => RX_Full      ,
        Empty     => RX_Empty     );


  bloqueRAM: RAM
    port map (
        Reset       =>  Reset   ,
        Clk         =>  CLK100MHZ     ,
        databus     =>  databus ,
        address     =>  address ,
        write_en    =>  write_en,
        oe          =>  oe      ,
        switches    =>  switches,
        Temp_L      =>  Temp_L  ,
        Temp_H      =>  Temp_H  );
  
  bloqueDMA: DMA
    port map (
        Reset       =>  Reset        , 
        CLK100MHZ         =>  CLK100MHZ    , 
        RCVD_Data   =>  Data_recibida    , 
        RX_Full     =>  RX_Full      , 
        RX_Empty    =>  RX_Empty     , 
        Data_Read   =>  Data_Read    , 
        ACK_in     =>  ACK_flag      , 
        TX_RDY      =>  TX_RDY       , 
        Valid_D     =>  Valid_D      , 
        TX_Data     =>  Data_in      , 
        Address     =>  Address      , 
        Databus     =>  Databus      , 
        Write_en    =>  Write_en     , 
        OE          =>  OE           , 
        DMA_RQ      =>  DMA_RQ       , 
        DMA_ACK     =>  DMA_ACK      , 
        Send_comm   =>  Send_comm    , 
        READY       =>  READY        );
        
end RTL;

