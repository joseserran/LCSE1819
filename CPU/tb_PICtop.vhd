
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

library xil_defaultlib;
USE xil_defaultlib.PIC_pkg.all;
USE work.RS232_test.all;

entity PICtop_tb is
end PICtop_tb;

architecture TestBench of PICtop_tb is

  component PICtop
    port (
      Reset    : in  std_logic;
      Clk100MHz: in  std_logic;
      RS232_RX : in  std_logic;
      RS232_TX : out std_logic;
      switches : out std_logic_vector(7 downto 0);
      Temp_L     : out std_logic_vector(6 downto 0);
      TEMP_H     : out std_logic_vector(6 downto 0));
  end component;

-----------------------------------------------------------------------------
-- Internal signals
-----------------------------------------------------------------------------

  signal Reset    : std_logic;
  signal Clk      : std_logic;
  signal RS232_RX : std_logic;
  signal RS232_TX : std_logic;
  signal switches : std_logic_vector(7 downto 0);
  signal Temp_L     : std_logic_vector(6 downto 0);
  signal TEMP_H    : std_logic_vector(6 downto 0);

begin  -- TestBench

  UUT: PICtop
    port map (
        Reset    => Reset,
        Clk100MHz      => Clk,
        RS232_RX => RS232_RX,
        RS232_TX => RS232_TX,
        switches => switches,
        Temp_L     => Temp_L,
        TEMP_H     => TEMP_H);

-----------------------------------------------------------------------------
-- Reset & clock generator
-----------------------------------------------------------------------------

  Reset <= '0', '1' after 15 ns;

  p_clk : PROCESS
  BEGIN
     clk <= '1', '0' after 5 ns;
     wait for 10 ns;
  END PROCESS;

-------------------------------------------------------------------------------
-- Sending some stuff through RS232 port
-------------------------------------------------------------------------------

  SEND_STUFF : process
  begin
     RS232_RX <= '1';
     -- I
     wait for 40 us;
     Transmit(RS232_RX, X"49");
     wait for 40 us;
     Transmit(RS232_RX, X"34"); -- 34
     wait for 40 us;
     Transmit(RS232_RX, X"31"); -- 31
     wait for 200 us;
     -- T
     Transmit(RS232_RX, X"54");
     wait for 40 us;
     Transmit(RS232_RX, X"32");
     wait for 40 us;
     Transmit(RS232_RX, X"38");
     wait for 200 us;
     -- A
     Transmit(RS232_RX, X"41");
     wait for 40 us;
     Transmit(RS232_RX, X"35");
     wait for 40 us;
     Transmit(RS232_RX, X"33");
     wait for 200 us;
     -- S
     Transmit(RS232_RX, X"53");
     wait for 40 us;
     Transmit(RS232_RX, X"49"); -- I
     wait for 40 us;
     Transmit(RS232_RX, X"34");
     wait for 200 us;
     -- S
     Transmit(RS232_RX, X"53");
     wait for 40 us;
     Transmit(RS232_RX, X"54"); -- T
     wait for 40 us;
     Transmit(RS232_RX, X"39");
     wait;
  end process SEND_STUFF;
   
end TestBench;

