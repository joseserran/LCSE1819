
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   
entity RS232top_TB is
end RS232top_TB;

architecture Testbench of RS232top_TB is

  component RS232top
    port (
      Reset     : in  std_logic;
      Clk100MHz       : in  std_logic;
      Data_in   : in  std_logic_vector(7 downto 0);
      Valid_D   : in  std_logic;
      Ack_out    : out std_logic;
      TX_RDY    : out std_logic;
      TD        : out std_logic;
      RD        : in  std_logic;
      Data_out  : out std_logic_vector(7 downto 0);
      Data_read : in  std_logic;
      Full      : out std_logic;
      Empty     : out std_logic);
  end component;
  
  signal Reset, Clk, Valid_D, Ack_out, TX_RDY : std_logic;
  signal TD, RD, Data_read, Full, Empty : std_logic;
  signal Data_out, Data_in : std_logic_vector(7 downto 0);

begin

  UUT: RS232top
    port map (
      Reset     => Reset,
      Clk100MHz       => Clk,
      Data_in   => Data_in,
      Valid_D   => Valid_D,
      Ack_out    => Ack_out,
      TX_RDY    => TX_RDY,
      TD        => TD,
      RD        => RD,
      Data_out  => Data_out,
      Data_read => Data_read,
      Full      => Full,
      Empty     => Empty);

  Data_in <= "11100010", "00111100" after 200000 ns;
  
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
     
     --conun solo bit
--     Valid_D <= '1', '0' after 300 ns,
--                '1' after 1210 ns;
--     RD <= '1',
--           '0' after 10500 ns,    -- StartBit
--           '1' after 19150 ns,   -- LSb
--           '0' after 27800 ns,
--           '0' after 36450 ns,
--           '1' after 45100 ns,
--           '1' after 53750 ns,
--           '1' after 62400 ns,
--           '1' after 71050 ns,
--           '0' after 79700 ns,  -- MSb
--           '1' after 88350 ns,  -- Stopbit
--           '1' after 97000 ns;
--     Data_read <= '0','1'after 98000 ns;
     
     
----    un bit con mas retraso
          Valid_D <='1', '0' after 110 ns,
                '1' after 400 ns,
                 '1' after 100000 ns,
                  '0' after 100110 ns,
                '1' after 100400 ns,
                '0' after 210 us,
                '1' after 220us;
                
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
               '1' after 187000 ns;
               
 Data_read <= '0','1'after 88000 ns;

     wait;
  END PROCESS;

end Testbench;

