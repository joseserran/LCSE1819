
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

USE work.PIC_pkg.all;

entity DMA is
 Port(
   Reset        : in    std_logic;
   CLK100MHZ          : in    std_logic;
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
end DMA;

architecture behavior of DMA is

type estados is (idle,esperandoEnvio,pidiendoBusesRecepcion,lecturaDato1,lecturaDato2,lecturaDato3,escribirFF,envioDato1, envioDato2);
signal estado_a, estado_s : estados;
signal dato_1_enviado, dato_2_enviado : std_logic := '0';
signal contador_envio, contador_envio_s , contador_recepcion, contador_recepcion_s: integer := 0;


begin

reloj_ram: process(CLK100MHZ, reset)  -- no reset

    begin

       if Reset = '0' then
       
           estado_a<=idle;
           contador_recepcion <= 1;
           contador_envio <= 1;
                  
       elsif CLK100MHZ'event and CLK100MHZ='1' then
           estado_a <= estado_s;
           contador_recepcion <= contador_recepcion_s;
           contador_envio <= contador_envio_s;
            
       end if;
end process;

FSM: process(estado_a,RX_empty, RX_Full,send_comm,TX_RDY, ACK_in,DMA_ACK,RCVD_Data, databus)
begin
    contador_recepcion_s <= contador_recepcion;
    contador_envio_s <= contador_envio;

        
    case estado_a is
    
        when idle =>
         
             READY <= '1';--DMA listo para funcionar
             OE <= 'Z';--en espera OE en alta impedancia
             Write_en <= 'Z'; --indicacion de escritura para la RAM, en espera en alta impedancia
             Address <= "ZZZZZZZZ";--libera el uso de la direccion de memoria, en espera en alta impedancia
             Databus <= "ZZZZZZZZ";--libera bus de datos del sistema, en espera en alta impedancia
             valid_D <= '1';
             DMA_RQ <= '0';
             
             contador_recepcion_s <= 1;
             contador_envio_s <= 1;
             
             data_read <= '0'; --peticion de lectura de un nuevo dato desde el rs232
             tx_data <= "ZZZZZZZZ"; 
               
             --version anadido en 14 de junio 2019
             if Send_comm = '1' then
                READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
                estado_s <= esperandoEnvio;
                
             elsif RX_Empty = '0' then
                READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
                estado_s <= pidiendoBusesRecepcion;
                --contador igual a 0
             else
                estado_s <= idle;
             end if;
    
        when pidiendoBusesRecepcion =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
            DMA_RQ <= '1'; --se mantiene al procesador solicitud de uso de buses
            data_read <= '0'; --peticion de lectura del rs232
            if DMA_ACK = '1' and RX_Empty = '0'then
            
                if contador_recepcion = 1 then
                    estado_s <= lecturaDato1;
                end if;
                
                if contador_recepcion = 2 then
                    estado_s <= lecturaDato2;
                end if;
                
                if contador_recepcion = 3 then
                    estado_s <= lecturaDato3;
                end if;
                    
            else
                estado_s <= idle;
            end if;
          
            
        when lecturaDato1 =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
            DMA_RQ <= '1'; --se mantiene al procesador solicitud de uso de buses
            data_read <= '1'; --peticion de lectura del rs232
            Databus<=RCVD_Data; --volcamos datos leidos en el bus de datos
            address <= DMA_RX_BUFFER_LSB; --volcamos a la direccion de memoria buffer LSB
            Write_en <= '1';--habilitacion de escritura para la ram
            --si sigue activo la dma_ack y rx_se vacia
            if DMA_ACK = '1' and RX_Empty = '1'then
                estado_s <= pidiendoBusesRecepcion;
                contador_recepcion_s <= 2;
            end if;
         
    
        when lecturaDato2 =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
            DMA_RQ <= '1'; --se mantiene al procesador solicitud de uso de buses
            data_read <= '1'; --peticion de lectura del rs232
            Databus<=RCVD_Data; --volcamos datos leidos en el bus de datos
            address <= DMA_RX_BUFFER_MID; --volcamos a la direccion de memoria buffer middle byte
            Write_en <= '1';--habilitacion de escritura para la ram
            
            if DMA_ACK = '1' and RX_Empty = '1'then
                estado_s <= pidiendoBusesRecepcion;
                            contador_recepcion_s <= 3;
            end if;
         
        when lecturaDato3 =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
            DMA_RQ <= '1'; --se mantiene al procesador solicitud de uso de buses
            data_read <= '1'; --peticion de lectura del rs232
            Databus<=RCVD_Data; --volcamos datos leidos en el bus de datos
            address <= DMA_RX_BUFFER_MSB; --volcamos a la direccion de memoria buffer MSB
            Write_en <= '1';--habilitacion de escritura para la ram
            
            if DMA_ACK = '1' and RX_Empty = '1'then
                estado_s <= escribirFF;
                            contador_recepcion_s <= 0;
            end if;
           
            
        when escribirFF =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
            DMA_RQ <= '1'; --se mantiene al procesador solicitud de uso de buses
            address <= NEW_INST; --volcamos a la direccion de memoria NEW_INST
            Databus <= "11111111"; --valor 0xFF
            Write_en <= '1';--habilitacion de escritura para la ram
            estado_s <= idle;
          
            
        when esperandoEnvio =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento
            Valid_d <= '0';
       
            if TX_RDY = '1' then
            
                if contador_envio = 1 then
                    estado_s <= envioDato1;
                end if;
                
                if contador_envio = 2 then
                    estado_s <= envioDato2;
                end if;
                
            end if;
        
        when envioDato1 =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento 
            Address <= DMA_TX_BUFFER_LSB; --byte menos significativo 
            OE <= '0'; -- habilitacion de salida de la ram
            TX_DATA <= Databus; --volcamos databus en datos a mandar a rs232
            Valid_d <= '0'; --Validacion del dato de entrada por parte del sistema cliente. Activa a nivel bajo.
            
            if ACK_in = '0' then -- and TX_RDY = '1' then --añadido TX_RDY = '1'
                estado_s <= esperandoEnvio;
                contador_envio_s <= 2;
                --Valid_d <= '1';
            end if;
            
        when envioDato2 =>
            READY <= '0';--DMA en uso, ponermos a 0 durante funcionamiento 
            Address <= DMA_TX_BUFFER_MSB; --byte mas significativo 
            OE <= '0'; -- habilitacion de salida de la ram
            TX_DATA <= Databus; --volcamos databus en datos a mandar a rs232
            Valid_d <= '0'; --Validacion del dato de entrada por parte del sistema cliente. Activa a nivel bajo.
            
            if ACK_in = '0' then --and TX_RDY = '1' then
                estado_s <= idle;
                contador_envio_s <= 1;
                --Valid_d <= '1';
            end if;
                 
        
               
    end case;
end process;

-------------------------------------------------------------------------

end behavior;