----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2018 20:56:21
-- Design Name: 
-- Module Name: RS2323_RX - Behavioral
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

entity RS232_RX is
  Port ( 
  reset : in STD_LOGIC;
  clk : in STD_LOGIC;
  LineRD_in : in STD_LOGIC;
  valid_out : out STD_LOGIC;
  Code_out : out STD_LOGIC;
  Store_out : out STD_LOGIC  
  );
end RS232_RX;

architecture Behavioral of RS232_RX is

type estado is (idle, startbit, rcvdata, stopbit);
signal estado_a, estado_s : estado;

signal data_count, data_siguiente : unsigned(3 downto 0):="0000";
signal contador_siguiente, contador : unsigned(7 downto 0) := "00000000";
constant halfbitcounter : integer := 87;
constant bitcounter :  integer := 173;

begin

reloj: process(clk,reset,estado_s)
begin
   
    if reset ='0' then
        contador<="00000000";
        data_count<="0000";
        estado_a <= idle;
--        contador_siguiente<="00000000";--aqui me ha vuelto a dar problemas
       
    elsif clk'event and clk = '1' then
        estado_a <= estado_s;
        contador <= contador_siguiente;
        data_count <= data_siguiente;
    end if;
end process;

estados: process(data_count, estado_a, linerd_in, contador)
begin
--contador<=contador_siguiente;

    --añadido para eliminar latches
       
    --hasta aqui

    case estado_a is
   
        when idle=>
            contador_siguiente<="00000000"; --añadido para quitar latch
            valid_out <='0';
            code_out <='0';
            store_out<='0';
            data_siguiente<="0000";
            
            if linerd_in = '0' then
                estado_s<=startbit;
            else
                estado_s<=idle;
            end if;
        
        when startbit=>
            valid_out<='0';
            code_out <='0';  
            store_out<='0'; 
            data_siguiente<="0000";
                  
            if contador = bitcounter then
                estado_s<=rcvdata;
                contador_siguiente<="00000000";
            else
                estado_s<=startbit;
                contador_siguiente<=contador+1;
            end if;    
        
        when rcvdata=>
          code_out<=lineRD_in;
          store_out<='0';
          if halfbitcounter = contador then
             valid_out<='1';
            data_siguiente<=data_count+1;
          else
             valid_out<='0';
    --      code_out<='0';
          end if;
          
          if contador = bitcounter then
               if data_count = 8 then
                    data_siguiente<="0000";
                    estado_s<=stopbit;
                end if;
                
                contador_siguiente<="00000000";    
          else
                estado_s<=rcvdata;
                contador_siguiente<=contador+1;
                end if;  
                
        when stopbit=>
            valid_out<='0';
            code_out <='0';
            data_siguiente<="0000";
            if contador = bitcounter then
                estado_s<=idle;
                contador_siguiente<="00000000";
            else
               estado_s<=stopbit;
               contador_siguiente<=contador+1; 
            end if;
               
            if halfbitcounter = contador and linerd_in = '1' then
                store_out<='1';
            else
                store_out<='0';
            end if;
             
               
            
        
    
    end case;
end process;

end Behavioral;

