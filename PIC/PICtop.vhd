
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

USE work.PIC_pkg.all;

entity PICtop is
  port (
        Reset    : in  std_logic;                        -- Asynchronous, active low
        CLK100MHZ      : in  std_logic;                  -- System clock, 20 MHz, rising_edge
        RS232_RX : in  std_logic;                        -- RS232 RX line
        RS232_TX : out std_logic;                       -- RS232 TX line
        switches : out std_logic_vector(7 downto 0);   -- Switch status bargraph
        Temp_L     : out std_logic_vector(6 downto 0);   -- Display value for T_STAT
        Temp_H     : out std_logic_vector(6 downto 0)   -- Display activation for T_STAT
    );  
end PICtop;

architecture RTL of PICtop is

  component RS232dmaramtop is

  port (
       Reset          : in  std_logic;   -- Low_level-active asynchronous reset
       CLK100MHZ      : in  std_logic;   -- System clock (20MHz), rising edge used
       CLK20MHZ       : out  std_logic;   -- System clock (20MHz), rising edge used
       TD             : out std_logic;   -- RS232 Transmission line
       RD             : in  std_logic;   -- RS232 Reception line
       databus        : inout std_logic_vector(7 downto 0);
       address        : inout    std_logic_vector(7 downto 0);
       switches       : out   std_logic_vector(7 downto 0);
       Temp_L         : out   std_logic_vector(6 downto 0);
       Temp_H         : out   std_logic_vector(6 downto 0);
       DMA_RQ       : out    std_logic;
       DMA_ACK      : in     std_logic;
       Send_comm    : in    std_logic;
       READY        : out   std_logic;
       oe            : inout    std_logic     

        );
  end component;
  
  
component ALU is
   Port(
      Reset           : in    std_logic;
      CLK             : in    std_logic;
      u_instruction   : in    alu_op; --bus de microinstrucciones
      databus         : inout  STD_LOGIC_VECTOR (7 downto 0);
      Index_Reg       : out    STD_LOGIC_VECTOR (7 downto 0);
      FlagZ           : out    std_logic; --flag de cero
      FlagC           : out    std_logic; --flag de acarreo
      FlagN           : out    std_logic; --flag de acarreo en nibble
      FlagE           : out    std_logic  --flag de error
     );
    end component;

component CPU is
  Port (
      reset         : in std_logic;
      CLK           : in std_logic;
      
      rom_data      : in std_logic_vector (11 downto 0);
      rom_addr      : out std_logic_vector (11 downto 0);
      
      ram_addr      : out std_logic_vector (7 downto 0);
     
      ram_write     : out std_logic;
      ram_oe        : out std_logic;
      databus       : inout std_logic_vector (7 downto 0);
     
      DMA_RQ        : in std_logic;
      dma_ack       : out std_logic;
      send_comm     : out std_logic;
      dma_ready     : in std_logic;
      
      command_alu   : out alu_op; -- alu_op del PDF
      index_reg     : in std_logic_vector (7 downto 0);
      FlagZ         : in std_logic;
      flagC         : in std_logic;
      flagN         : in std_logic;
      flagE         : in std_logic
   );
    end component;
    
component ROM is
      port (
      Instruction     : out std_logic_vector(11 downto 0);  -- Instruction bus
      Program_counter : in  std_logic_vector(11 downto 0)
         );
        end component;
        
        
        
------------------------------------------------------------------------
-- Internal Signals
-----------------------------------------------------------------------    


 signal FlagZ, FlagC ,FlagN, FlagE, CLK, DMA_RQ, DMA_ACK, Send_comm , READY, oe, write_en, CLK20MHZ: STD_LOGIC;
 
 signal rom_addr, rom_DATA : STD_LOGIC_vector (11 downto 0);
 
 signal Index_Reg       : STD_LOGIC_VECTOR (7 downto 0);
 
 signal databus , address : std_logic_vector (7 downto 0);
 SIGNAL command_alu   : alu_op;      
 
begin  -- behavior

  rs232dmaramtop_bloque: RS232dmaramtop
    port map (
        Reset       =>  Reset     ,
        CLK100MHZ   =>  CLK100MHZ ,
        CLK20MHZ    =>  CLK  ,
        TD          =>  RS232_TX        ,
        RD          =>  RS232_RX        ,
        databus     =>  databus   ,
        address     =>  address,
        switches    =>  switches  ,
        Temp_L      =>  Temp_L    ,
        Temp_H      =>  Temp_H    ,
        DMA_RQ      =>  DMA_RQ    ,
        DMA_ACK     =>  DMA_ACK   ,
        Send_comm   =>  Send_comm ,
        READY       =>  READY     ,
        oe          =>      oe     
        );
        
  ALU_bloque: ALU
          port map (
          Reset           =>    Reset          ,        
          CLK             =>    CLK            ,
          u_instruction   =>    command_alu    ,
          databus         =>    databus        ,
          Index_Reg       =>    Index_Reg      ,
          FlagZ           =>    FlagZ          ,
          FlagC           =>    FlagC          ,
          FlagN           =>    FlagN          ,
          FlagE           =>    FlagE
          );

  CPU_bloque: CPU
          port map (
          reset         =>  reset      ,
          CLK           =>  CLK        ,
             
          rom_data      =>  rom_data   ,
          rom_addr      =>  rom_addr   ,
                   
          ram_addr      =>  address   ,
                  
          ram_write     =>  write_en    ,
          ram_oe        =>  oe          ,
          databus       =>  databus    ,
              
          dma_rq        =>  dma_rq     ,
          dma_ack       =>  dma_ack    ,
          send_comm     =>  send_comm  ,
          dma_ready     =>  ready  ,

          command_alu   =>  command_alu,
          index_reg     =>  index_reg  ,
          FlagZ         =>  FlagZ      ,
          flagC         =>  flagC      ,
          flagN         =>  flagN      ,    
          flagE         =>  flagE      
          );    
              
 ROM_bloque: ROM
          port map (
          Instruction     => rom_data    ,         
          Program_counter => rom_addr   
          );
              

 
end RTL;

