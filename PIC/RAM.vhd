
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

USE work.PIC_pkg.all;

ENTITY ram IS
PORT (
   Reset    : in    std_logic;
   Clk      : in    std_logic;
   databus  : inout std_logic_vector(7 downto 0);
   address  : in    std_logic_vector(3 downto 0);
   write_en : in    std_logic;
   oe       : in    std_logic;
   switches : out   std_logic_vector(7 downto 0);
   Temp_L   : out   std_logic_vector(6 downto 0);
   Temp_H   : out   std_logic_vector(6 downto 0)
   );
END ram;

ARCHITECTURE behavior OF ram IS

  SIGNAL contents_ram : array8_ram(255 downto 0); --la direcccion de memoria de la ram es hasta 255

BEGIN

-------------------------------------------------------------------------
-- Memoria de propósito general
-------------------------------------------------------------------------
p_ram : process (clk,reset)  -- no reset
begin

if reset = '0' then
  
    for direccion in 0 to 63 loop
     contents_ram(direccion) <= "00000000"; --se pone a cero todo este bloque de memoria
     end loop;
     
elsif clk'event and clk = '1' then

    if write_en = '1' then
        contents_ram(to_integer(unsigned(address))) <= databus;
    end if;
end if;

end process;

databus <= contents_ram(to_integer(unsigned(address))) when oe = '0' else (others => 'Z');
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Decodificador de BCD a 7 segmentos
-------------------------------------------------------------------------
with contents_ram(49)(7 downto 4) select --la posicion de memoria 0x31 es la direccion de los displays de temperatura, en decimal es 49
Temp_H <=
    "0000110" when "0001",  -- 1
    "1011011" when "0010",  -- 2
    "1001111" when "0011",  -- 3
    "1100110" when "0100",  -- 4
    "1101101" when "0101",  -- 5
    "1111101" when "0110",  -- 6
    "0000111" when "0111",  -- 7
    "1111111" when "1000",  -- 8
    "1101111" when "1001",  -- 9
    "1110111" when "1010",  -- A
    "1111100" when "1011",  -- B
    "0111001" when "1100",  -- C
    "1011110" when "1101",  -- D
    "1111001" when "1110",  -- E
    "1110001" when "1111",  -- F
    "0111111" when others;  -- 0
    
with contents_ram(49)(3 downto 0) select
Temp_L <=
    "0000110" when "0001",  -- 1
    "1011011" when "0010",  -- 2
    "1001111" when "0011",  -- 3
    "1100110" when "0100",  -- 4
    "1101101" when "0101",  -- 5
    "1111101" when "0110",  -- 6
    "0000111" when "0111",  -- 7
    "1111111" when "1000",  -- 8
    "1101111" when "1001",  -- 9
    "1110111" when "1010",  -- A
    "1111100" when "1011",  -- B
    "0111001" when "1100",  -- C
    "1011110" when "1101",  -- D
    "1111001" when "1110",  -- E
    "1110001" when "1111",  -- F
    "0111111" when others;  -- 0
    
    
switches(1) <= contents_ram(16) (0);
switches(1) <= contents_ram(17) (0);
switches(1) <= contents_ram(18) (0);
switches(1) <= contents_ram(19) (0);
switches(1) <= contents_ram(20) (0);
switches(1) <= contents_ram(21) (0);
switches(1) <= contents_ram(22) (0);
switches(1) <= contents_ram(23) (0);

-------------------------------------------------------------------------

END behavior;

