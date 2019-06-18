----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2018 12:08:38
-- Design Name: 
-- Module Name: RS232_TX - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS232_TX is
  Port ( 
        reset : in STD_LOGIC;
        clk : in STD_LOGIC;
        start : in STD_LOGIC;
        data : in std_logic_vector (7 downto 0);
        eot : out STD_LOGIC;
        tx : out STD_LOGIC    
);
end RS232_TX;

architecture Behavioral of RS232_TX is

type estado is (idle, startbit, senddata, stopbit);
signal estado_a, estado_s : estado;

signal data_count, data_siguiente : unsigned(2 downto 0):="000";
signal pulse_width, pulse_siguiente : unsigned (7 downto 0) := "00000000"; --incializamos a 0 el contador de pulsos

constant count_end_of_pulses : integer := 173; --clockfec7baudios 20000000/115200=173 

begin

reloj: process (clk, reset)
    begin
        if reset = '0' then
            estado_a<=idle;
            data_count<=(others=>'0');
            pulse_width<=(others=>'0');
            
        elsif clk'event and clk='1' then
            estado_a <= estado_s;
            data_count<=data_siguiente;
            pulse_width<=pulse_siguiente;
        end if;
        
end process; 

estados: process(estado_a, start, data_count, pulse_width, data)
begin
    --añadido para eliminar latches
        estado_s <= estado_a;
        tx<='1';--en espera se esta a nivel alto
        --eot<='1';--final de transmision
    --hasta aqui
        
        data_siguiente<=data_count;
        pulse_siguiente<=pulse_width;
        
    case estado_a is
    
     when idle =>
     eot<='1';--final de transmision
     tx<='1';--en espera se esta a nivel alto
        if start = '1' then
            estado_s <= startbit;
            eot<='0';--en transmision
        else 
            estado_s <= idle;
            eot<='1';--final de transmision
        end if;
        
     when startbit =>
     tx<='0';--ponemos a nivel bajo la linea de transmision
     --eot<='0';--en transmision       
        if pulse_width = 173 then 
           estado_s <= senddata;--entramos en estado de mandar datos
--           data_count<="0";--ponemos el contador de bits a cero ME HA DADO INIFNITOS PROBLEMAS 
--           pulse_width<="00000000";--ancho de pulso a cero
           pulse_siguiente <="00000000";      --contador ancho de pulso a cero
        else 
           estado_s <= startbit; --seguimos en el estado
--           data_count<=(others=>'0');--no tocamos el valor del contador de bit
   
           pulse_siguiente<=pulse_width+1;--añadimos uno al contador del ancho de bit
        end if;
        
    when senddata=>
      tx<=data(to_integer(data_count));--pone el valor del tx al correspodiente dato
      --eot<='0';--en transmision
        if pulse_width = 173 then
            if data_count=7 then 
            estado_s<=stopbit;
            else 
            estado_s<=senddata;
            end if;
        data_siguiente <=data_count+1;--añadimos uno al contador de bits  
--        pulse_width<="00000000";--ancho de pulso a cero
        pulse_siguiente <="00000000";
      
        else
            estado_s<=senddata;
            pulse_siguiente<=pulse_width+1;
            data_siguiente <=data_count;
        end if;
        
    when stopbit=>
    --eot<='0';--en transmision
    --tx<='1';--en espera se esta a nivel alto
        if pulse_width = 173 then
        estado_s<=idle;
--        pulse_width<="00000000";--ancho de pulso a cero
        pulse_siguiente <="00000000";
        else
        pulse_siguiente<=pulse_width+1;
        end if;
    
    end case;
end process;
end Behavioral;

