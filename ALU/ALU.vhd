
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

USE work.PIC_pkg.all;

entity ALU is
 Port(
    Reset           : in    std_logic;
    CLK       : in    std_logic;
    u_instruction   : in    alu_op; --bus de microinstrucciones
    databus : inout  STD_LOGIC_VECTOR (7 downto 0);
    Index_Reg       : out    STD_LOGIC_VECTOR (7 downto 0);
    FlagZ           : out    std_logic; --flag de cero
    FlagC           : out    std_logic; --flag de acarreo
    FlagN           : out    std_logic; --flag de acarreo en nibble
    FlagE           : out    std_logic  --flag de error
   );
end ALU;

architecture behavior of ALU is
    signal A, B, acumulador : STD_LOGIC_VECTOR (7 downto 0);

begin

process(CLK, reset)  

begin

    if Reset = '0' then
        A <= "00000000";
		B <= "00000000";
		acumulador <= "00000000";
		Index_Reg<= "00000000";
		FlagZ <= '0';
--		databus <= "ZZZZZZZZ";
	
	elsif CLK'event and CLK='1' then
	   
       case u_instruction is
        
            --External value load
	       when op_lda =>
	           A <= databus;
	       when op_ldb =>
               B <= databus;
		   when op_ldacc =>
	           acumulador <= databus;
			when op_ldid =>
				index_reg<= databus;


			--Internal load
			when op_mvacc2id =>
				index_reg<= acumulador ;
			when op_mvacc2a =>
				a <= acumulador ;
			when op_mvacc2b =>
				b <= acumulador ;


			--Arithmetic operations
			when op_add =>
				acumulador <= a+b;
				if (a+b = 0) then
					flagZ <= '1';
				else
					flagZ <= '0';
				end if;
			when op_sub =>
				acumulador <= a-b;
				if (a = b) then
					flagZ <= '1';
				else
					flagZ <= '0';
				end if;
			when op_shiftl =>
				acumulador <= acumulador(6 downto 0) & '0';
			when op_shiftr =>
				acumulador <= '0' & acumulador(7 downto 1);


			--Logic operations
			when op_and =>
				acumulador <= a and b;
			when op_or =>
				acumulador <= a or b;
			when op_xor =>
				acumulador <= a xor b;
			
			--Compare operations
			when op_cmpe =>
				if (a = b) then
					flagZ <= '1';
				else
					flagZ <= '0';
				end if;
			when op_cmpl =>
				if (a < b) then
					flagZ <= '1';
				else
					flagZ <= '0';
				end if;
			when op_cmpg =>
				if (a > b) then
					flagZ <= '1';
				else
					flagZ <= '0';
				end if;


			--Convertion operations
			when op_ascii2bin =>
				if (a < "00110000" or a > "00111001") then
					acumulador <= "11111111";
				else
					acumulador <= a - "00110000";
				end if;
			when op_bin2ascii =>
				if (a > "00001111") then
					acumulador <= "11111111";
				elsif (a < "00001010") then
					acumulador <= a + "00110000";
				else
					acumulador <= a + "00110111";
				end if;
			
			when op_oeacc => --output enable
			     --databus <= acumulador; --???????????
			
			when nop =>
				
		end case;
               
       end if;
end process;



end behavior;