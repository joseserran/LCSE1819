
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

--USE work.PIC_pkg.all;

entity DMA is
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
end DMA;

architecture behavior of DMA is

 type estados is (idle,transmitiendo_buffer_1,transmitiendo_buffer_2, recibiendo_LSB, recibiendo_middle, recibiendo_MSB, comando_completo);
 signal estado_a, estado_s : estados;
 --type estados2 is (idle, transmitiendo, recibiendo);--una segunda maquina de estados
signal dato_1_enviado, dato_2_enviado : std_logic := '0';
signal peticion_send_comm : std_logic := '0';
--signal address_rx : std_logic_vector .= "00000000","00000001","0000
--type address_vector is array (0 to 3) of std_logic_vector(7 downto 0);
--signal address_rx : address_vector;
--signal address_array is array ("00000000", "00000001") of Type;
--signal address_vector : address_rx(3 downto 0);

begin

reloj_ram: process(CLK100MHZ, reset)  -- no reset

    begin

       if Reset = '0' then
       
           estado_a<=idle;
           
--           READY <= '1';--DMA listo para funcionar
--           OE <= 'Z';--en espera OE en alta impedancia
--           Write_en <= 'Z'; --indicacion de escritura para la RAM
--           Address <= "ZZZZZZZZ";--libera el uso de la direccion de memoria
--           Databus <= "ZZZZZZZZ";--libera bus de datos del sistema
                  
       elsif CLK100MHZ'event and CLK100MHZ='1' then
           estado_a <= estado_s;
         
       end if;
end process;

FSM: process(estado_a, dato_1_enviado, dato_2_enviado, RX_empty, RX_Full,peticion_send_comm, send_comm,TX_RDY,
    ACK_out,DMA_ACK,RCVD_Data, databus)
begin

        
    case estado_a is
    
     when idle =>
     
     READY <= '1';--DMA listo para funcionar
     OE <= 'Z';--en espera OE en alta impedancia
     Write_en <= 'Z'; --indicacion de escritura para la RAM
     Address <= "ZZZZZZZZ";--libera el uso de la direccion de memoria
     Databus <= "ZZZZZZZZ";--libera bus de datos del sistema
     dato_1_enviado <= '0';
     dato_2_enviado <= '0';
     valid_D <= '1';
     DMA_RQ <= '0';
     oe <= '0';
     peticion_send_comm <= send_comm;--volcamos la peticion a una variable para terminar el proceso
     data_read <= '0'; --peticion de lectura de un nuevo dato desde el rs232
     tx_data <= "ZZZZZZZZ";   
     write_en <='0';
       
     --------------------CORREGIR EL CONCEPTO DE RX_EMPTY Y RX_FULL
        if peticion_Send_comm = '1' and TX_RDY ='1' then -- if RX_full ='0' and RX_Empty = '0' and peticion_Send_comm = '1' and TX_RDY ='1' then
         estado_s <= transmitiendo_buffer_1;
         
         
--        elsif peticion_Send_comm = '0' and TX_RDY ='1' then -- elsif RX_full ='0' and RX_Empty = '1' and peticion_Send_comm = '0' and TX_RDY ='1' then
--        estado_s <= idle;
        
        
        elsif RX_Empty = '0' and peticion_Send_comm = '0' and TX_RDY ='1' then --RX_Full = '1' and RX_Empty = '0' and peticion_Send_comm = '0' and TX_RDY ='1' then
        estado_s <= recibiendo_LSB;
        
        
--        elsif RX_Full = '0' and RX_Empty = '0' and peticion_Send_comm = '0' and TX_RDY ='1' then
--        estado_s <= idle;
        
        
        else 
        estado_s <= idle;
        
        end if;
        
      
        
    when transmitiendo_buffer_1 =>
    Address <= "00000101";
   TX_Data <= Databus;--
   oe <= '1'; --cargamos datos de la RAM al rs232
   READY <= '0';--DMA en uso
--   dato_1_enviado <= '1';
   
    
--    if  dato_1_enviado = '1' and ACK_out = '0' then--ACK_out activa a nivel bajo
--             estado_s <= transmitiendo_buffer_2;
--             READY <= '0';--DMA en uso
--             valid_D <= '0'; --validacion del dato enviado al tranmisor RS232, low cuando es valido

    if  ACK_out = '0' and peticion_Send_comm = '1' then--ACK_out activa a nivel bajo
             estado_s <= transmitiendo_buffer_2;
--             READY <= '0';--DMA en uso
             valid_D <= '0'; --validacion del dato enviado al tranmisor RS232, low cuando es valido
             
     elsif   ACK_out = '1' and peticion_Send_comm = '1' then--si aun el rs232 no ha adquirido el dato pero me siguen pidiendo mandar comando, lo espero
            estado_s <= transmitiendo_buffer_1;
            valid_D <= '1';--no validado el dato
     else
                estado_s <= idle;
                valid_D <= '1';--no validado el dato
     end if;
        
    when transmitiendo_buffer_2=>
      Address <= "00000100";
      TX_Data <= Databus;--
      oe <= '1'; --cargamos datos de la RAM al rs232
--      dato_2_enviado <= '1';
      
--       if  dato_2_enviado = '1' and ACK_out = '0'  then--ACK_out activa a nivel bajo
--                estado_s <= idle;
--                READY <= '0';--DMA en uso
--                valid_D <= '1'; --validacion del dato enviado al tranmisor RS232

      if  ACK_out = '0' and peticion_Send_comm = '1' then--ACK_out activa a nivel bajo
                estado_s <= idle;
--                READY <= '0';--DMA en uso
                valid_D <= '0'; --validacion del dato enviado al tranmisor RS232, activo a nivel bajo
             
       elsif   ACK_out = '1' and peticion_Send_comm = '1' then--si aun el rs232 no ha adquirido el dato pero me siguen pidiendo mandar comando, lo espero
                estado_s <= transmitiendo_buffer_2;
                valid_D <= '1';--no validado el dato         
        else 
               estado_s <= idle;
               valid_D <= '1';--no validado el dato
        end if;
      
    when recibiendo_LSB=>
        DMA_RQ <= '1'; --pedimos los buses al procesador
        READY <= '0';--la DMA ya no esta ociosa
    
            if DMA_ACK = '1' and rx_empty = '0' and TX_RDY = '1' then--el procesador ha cedido el bus y la fifo NO esta vacia
            
            Databus<=RCVD_Data;
            data_read <= '1'; --peticion de lectura del rs232
            address <= "00000010"; --volcamos a la direccion de memoria buffer LSB
            estado_s<=recibiendo_middle;
            write_en <= '1';--habilitacion de escritura para la ram
                
--            elsif DMA_ACK = '0' and rx_empty = '0' and TX_RDY = '1' then--el procesador no ha cedido aun el bus y la fifo NO esta vacia
--            estado_s <= recibiendo_LSB;
        
            elsif  rx_empty = '1' then--el procesador no ha cedido aun el bus y la fifo SI esta vacia
            estado_s <= idle;
            
            else 
            estado_s <= recibiendo_LSB;
            write_en <= '0';--mientras que no podamos escribir
            end if; 
            
     when recibiendo_middle=>
     
     if DMA_ACK = '1' and rx_empty = '0' and TX_RDY = '1' then--el procesador ha cedido el bus y la fifo NO esta vacia
     
     Databus<=RCVD_Data;
     data_read <= '1'; --peticion de lectura del rs232
     address <= "00000001"; --volcamos a la direccion de memoria buffer LSB
     estado_s<=recibiendo_MSB;
     write_en <= '1';--habilitacion de escritura para la ram
         
     elsif rx_empty = '1' then--el procesador no ha cedido aun el bus y la fifo SI esta vacia --DMA_ACK = '0' and 
     estado_s <= idle;
     
     else 
     estado_s <= recibiendo_middle;
     write_en <= '0';--mientras que no podamos escribir
     end if; 
     
     when recibiendo_MSB=>
       
         if DMA_ACK = '1' and rx_empty = '0' and TX_RDY = '1' then--el procesador ha cedido el bus y la fifo NO esta vacia
     
     Databus<=RCVD_Data;
     data_read <= '1'; --peticion de lectura del rs232
     address <= "00000000"; --volcamos a la direccion de memoria buffer LSB
     estado_s<=comando_completo;
     write_en <= '1';--habilitacion de escritura para la ram
         
     elsif rx_empty = '1' then--el procesador no ha cedido aun el bus y la fifo SI esta vacia
     estado_s <= idle;
     
     else 
     estado_s <= recibiendo_MSB;
     write_en <= '0';--mientras que no podamos escribir
     end if; 
         
     when comando_completo=>
     Databus<="11111111"; --ponemos valor 0xFF
     address <= "00000011"; --en registro NEW_INST de la RAM
     estado_s<=idle;
     write_en <= '1';--habilitacion de escritura para la ram
           
    end case;
end process;

-------------------------------------------------------------------------

end behavior;