

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
USE work.PIC_pkg.all;


entity CPU is
  Port (
  reset :in std_logic;
  clk: in std_logic;
  -- ROM
  rom_data: in std_logic_vector (11 downto 0);
  rom_addr: out std_logic_vector (11 downto 0);
  -- RAM
  ram_addr: out std_logic_vector (7 downto 0);
 -- ram_cs: out std_logic;
  ram_write: out std_logic;
  ram_oe: out std_logic;
  databus: inout std_logic_vector (7 downto 0);
  -- DMA
  dma_rq: in std_logic;
  dma_ack: out std_logic;
  send_comm: out std_logic;
  dma_ready:in std_logic;
  -- ALU
  command_alu: out alu_op; -- alu_op del PDF
  index_reg: in std_logic_vector (7 downto 0);
  flagZ: in std_logic;
  flagC: in std_logic;
  flagN: in std_logic;
  flagE: in std_logic
   );
end CPU;

architecture Behavioral of CPU is

type estado is (idle, dar_bus,fetch, decode,execute,fetch2);--,fetch_exp);
signal estado_a,estado_s : estado;

signal databus_out: std_logic_vector (7 downto 0);

signal cont_programa: std_logic_vector (11 downto 0):=X"000";
signal instruccion: std_logic_vector (11 downto 0);
signal temporal:std_logic_vector (11 downto 0);

signal tipo: std_logic_vector (1 downto 0):="00";
signal cont_sig: std_logic_vector (11 downto 0):=X"000";

signal flag_fetch: std_logic:='0';
signal flag_fetch_sig: std_logic:='0';

signal flag_done: std_logic := '0';     
signal flag_done_sig: std_logic := '0';  

signal flag_trasmit : std_logic;
signal flag_trasmit_sig : std_logic;

signal flag_tipo: std_logic;
signal flag_sig : std_logic;


signal instruc_sig : std_logic_vector (11 downto 0);
signal temporal_sig : std_logic_vector (11 downto 0);



begin

Reloj:process(clk,reset)
begin
    if reset = '0' then 
        estado_a <= idle;
        cont_programa <= X"000";
        
        flag_tipo <='0';
        flag_fetch<='0';
        flag_trasmit <= '0';
        flag_done_sig <= '0';
        
        instruccion <= X"000";
        temporal <= X"000";


        
    elsif clk'event and clk='1' then 
        estado_a <= estado_s;
        cont_programa <= cont_sig;
        
        flag_tipo <= flag_sig;
        flag_fetch<= flag_fetch_sig;
        flag_trasmit <= flag_trasmit_sig;
        flag_done_sig <= flag_done;
        
        instruccion <= instruc_sig;
        temporal <=temporal_sig;


    end if;
end process;

Siguiente: process(estado_a,dma_rq,flag_fetch,flag_tipo,flag_done, flag_sig)--,f_exp_sig, f_exp)
begin
    case estado_a is
    when idle=> 
        if dma_rq='1' then estado_s<=dar_bus;
        elsif (dma_rq='0') then estado_s<=fetch;
        else estado_s<=idle;
        end if;
    when dar_bus =>
        if dma_rq ='0' then estado_s<= idle;
        else estado_s <= dar_bus;
        end if;
    when fetch=> 
        if (flag_fetch='1') then estado_s<=decode;
        else estado_s<=fetch;
        end if;
    when decode=> 
        if (flag_sig ='0') then estado_s<=execute;
        elsif (flag_sig ='1') then estado_s <= fetch2;   ---TYPE_3 no siempre necesita ese dato
        else estado_s<=decode;
        end if;
        
    when fetch2=> 

        if (flag_fetch='1') then estado_s<=execute;
        else estado_s<=fetch2;
        end if;
        
 
        
    when execute=> 
        if (flag_done = '1') then estado_s<=idle;
        else estado_s<=execute;
        end if;
    end case;
end process;

databus <= databus_out;

Salidas: process (estado_a,cont_programa, rom_data, instruccion,
                 temporal, flagZ, index_reg,dma_ready, flag_trasmit,
                  instruc_sig, temporal_sig, flag_sig, flag_tipo,
                  flag_fetch, flag_done_sig)--,f_exp)--, tipo, fuente, tipo_1_2)
begin
    --f_exp_sig<=f_exp;
    
    dma_ack <='0';
    cont_sig <= cont_programa;
    
    command_alu <= nop;
    
    ram_addr <= (others => 'Z');
    ram_write <= 'Z';
    ram_oe <= 'Z';
    send_comm <= '0';
    
    flag_sig <=flag_tipo;
    flag_fetch_sig<= flag_fetch;
    flag_trasmit_sig <= flag_trasmit;  
    flag_done <= flag_done_sig;
 
    databus_out <= (others => 'Z');
    
    instruc_sig <= instruccion;
    temporal_sig <= temporal;
    
    rom_addr <= cont_programa;  

    case estado_a is 
    when idle =>
        dma_ack <='0';
        flag_done <='0';
        flag_sig <='0';
    when dar_bus =>
        dma_ack <='1';

    when fetch => -- 
        rom_addr <= cont_programa; 
        instruc_sig <= rom_data;
        
        cont_sig <= std_logic_vector(unsigned(cont_programa) + 1);
        
        flag_fetch_sig <='1';
        
    when decode =>
        
        if instruccion (7 downto 6)=TYPE_2 then
            flag_sig <= '1';

        elsif instruccion (7 downto 6)=TYPE_3  then    
            if (instruccion (4 downto 3) = SRC_ACC) and (instruccion (2 downto 0)= DST_INDX or instruccion (2 downto 0)=DST_A) then 
                flag_sig <= '0';
            else 
                flag_sig <= '1';
            end if;

        end if;
        
        if (instruccion (7 downto 6)=TYPE_3) and (instruccion (5)=LD) then
            if instruccion (4 downto 3)=SRC_INDXD_MEM or instruccion (4 downto 3)=SRC_MEM then
                flag_sig <= '1';
            end if;
        end if;
    when fetch2 =>
        rom_addr <= cont_programa;
        temporal_sig <= rom_data;
        cont_sig <= std_logic_vector(unsigned(cont_programa) + 1);
        flag_fetch_sig<='1';
        

    when execute =>

             
        case instruccion (7 downto 6) is
        when TYPE_1 => -- INSTRUCCIONES DE ALU --------------------------------------- TYPE_1 --------------------

            case instruccion(5 downto 0) is
            when ALU_ADD =>
                command_alu<=op_add;
                 flag_done <= '1';

            when ALU_SUB =>
                command_alu<=op_sub;
                flag_done <= '1';
                

            when ALU_SHIFTL =>
                command_alu<=op_shiftl;
                 flag_done <= '1';
                 
            when ALU_SHIFTR =>
                command_alu<=op_shiftr;
                 flag_done <= '1';

            when ALU_AND => 
                command_alu<=op_and;
                flag_done <= '1';
            when ALU_OR =>
                command_alu<=op_or;
				flag_done <= '1';


            when ALU_XOR => 
                command_alu<=op_xor;
                 flag_done <= '1';

            when ALU_CMPE =>
                command_alu<=op_cmpe;
                 flag_done <= '1';

            when ALU_CMPG =>
                command_alu<=op_cmpg;
				flag_done <= '1';

            when ALU_CMPL =>
                command_alu<=op_cmpl;
                 flag_done <= '1';

            when ALU_ASCII2BIN =>
                command_alu<=op_ascii2bin;
                 flag_done <= '1';

            when ALU_BIN2ASCII =>
                command_alu<=op_bin2ascii;
                 flag_done <= '1';

            when others =>
                command_alu <= nop;
            end case;
        when TYPE_2 =>--- Instrucciones de salto ---------------------------------------------- TYPE_2 ---------
            
            case instruccion (5 downto 0) is 
            when JMP_UNCOND =>
                cont_sig <= temporal;
				flag_done <= '1';
            when JMP_COND =>
                if FlagZ = '1' then 
                    cont_sig <= temporal;
					flag_done <= '1';
                else 
                    cont_sig <= cont_programa;
					flag_done <= '1';
                end if;
                
            when others =>
                NULL;
            end case;
        when TYPE_3 => ------ Instrucciones de movimiento de datos ---------------------------- TYPE_3 -----------
           
            case instruccion (5) is  -- operacion 
            when LD => --         --------------------------------------------------- LD----------------------------------------
                case instruccion (4 downto 3) is  -- fuente 
                when SRC_ACC => -- =1=
                    case instruccion (2 downto 0) is  -- destino
                    when DST_A =>
                        command_alu <= op_mvacc2a;
						flag_done <= '1';
                    when DST_B =>
                        command_alu <= op_mvacc2b;
						flag_done <= '1';
                    when DST_INDX =>
                        command_alu <= op_mvacc2id;
						flag_done <= '1';
                    when others =>
                        NULL;
                    end case;
                    
                when SRC_CONSTANT => -- =2= -- fuente
                    case instruccion (2 downto 0) is 
                    when DST_A =>
                        databus_out <= temporal(7 downto 0);
                        command_alu <= op_lda;
						flag_done <= '1';
                    when DST_B =>
                        databus_out <= temporal(7 downto 0);
                        command_alu <= op_ldb;
						flag_done <= '1';
                    when DST_ACC =>
                        databus_out <= temporal(7 downto 0);
                        command_alu <= op_ldacc;
						flag_done <= '1';
                    when DST_INDX =>
                        databus_out <= temporal(7 downto 0);
                        command_alu <= op_ldid;
						flag_done <= '1';
                    when others =>
                         NULL;
                    end case; 
                when SRC_INDXD_MEM => -- =3= 
                
                     ram_addr <= temporal(7 downto 0);
                    case instruccion (2 downto 0) is -- destino  NO TOCO DATABUS, PORQUE ESCRIBE LA RAM EN EL DATABUS
                    when DST_A =>
                        command_alu <= op_lda;
                        ram_oe<= '0';
						flag_done <= '1';
                    when DST_B =>
                        command_alu <= op_ldb;
                        ram_oe<= '0';
					    flag_done <= '1';
                    when DST_ACC =>
                        command_alu <= op_ldacc;
                        ram_oe<= '0';
						flag_done <= '1';
                    when DST_INDX =>
                        command_alu <= op_ldid;
                        ram_oe<= '0';
						flag_done <= '1';
                    when others =>
                        NULL;
                    end case;
                    
                when SRC_MEM => -- =4 =  -- fuente  
                 
                          ram_addr <= temporal(7 downto 0);        
                    case instruccion (2 downto 0) is   -- destino
                    when DST_A =>
                        command_alu <= op_lda;
                        ram_oe<= '0';
						flag_done <= '1';
                    when DST_B =>
                        command_alu <= op_ldb;
                        ram_oe<= '0';
						flag_done <= '1';
                    when DST_ACC =>
                        command_alu <= op_ldacc;
                        ram_oe<= '0';
						flag_done <= '1';
                    when DST_INDX =>
                       command_alu <= op_ldid;
                       ram_oe<= '0';
					   flag_done <= '1';
                    when others =>
                       NULL;
                    end case;
                when others =>
                   NULL;
                end case;
                                
            when WR => -- operacion --         --------------------------------------------------- WR--------------------------------------
                case instruccion (4 downto 3) is  -- fuente 
                when SRC_ACC =>
                    case instruccion (2 downto 0) is  -- destino
                    when DST_MEM =>
                        command_alu <= op_oeacc;   -- YA ESCRIBE LA ALU EN DATABUS
                        ram_addr <= temporal(7 downto 0);
                        ram_write <= '1';
						flag_done <= '1';
                    when DST_INDXD_MEM =>
                        command_alu <= op_oeacc;
                        ram_addr <= std_logic_vector(unsigned(temporal(7 downto 0)) + unsigned(index_reg));
                        ram_write <= '1';
						flag_done <= '1';
                    when others =>
                        NULL;
                    end case;
                when others =>
                    NULL;    
                end case;
            when others =>
                NULL;
            end case;
            
        when TYPE_4 =>
            send_comm <= '1';
            if dma_ready = '0' then flag_trasmit_sig <= '1'; 
            else  flag_trasmit_sig<='0';
            end if;
            if (flag_trasmit = '1' and  dma_ready = '1') then 
				send_comm <= '0';
				flag_done <= '1';
            end if;
        when others =>
            NULL;
        end case;  
    when others =>
        NULL;     
    end case;

end process;


end Behavioral;


