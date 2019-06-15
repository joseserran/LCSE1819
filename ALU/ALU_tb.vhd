
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

USE work.PIC_pkg.all;


entity ALU_tb is
end ALU_tb;

architecture testbench of ALU_tb is
    component ALU
    Port(
        Reset           : in    std_logic;
        CLK100MHZ       : in    std_logic;
        u_instruction   : in    alu_op; --bus de microinstrucciones
        databus : inout  STD_LOGIC_VECTOR (7 downto 0);
        Index_Reg       : out    STD_LOGIC_VECTOR (7 downto 0);
        FlagZ           : out    std_logic; --flag de cero
        FlagC           : out    std_logic; --flag de acarreo
        FlagN           : out    std_logic; --flag de acarreo en nibble
        FlagE           : out    std_logic  --flag de error
       );
    end component;
    signal reset, clk, FlagZ, FlagC, FlagN, FlagE : std_logic; 
    signal u_instruction : alu_op; --bus de microinstrucciones    
    signal  index_reg,Databus : std_logic_vector(7 downto 0);          
begin
UUT: ALU
port map(
    reset          => reset          ,
    CLK100MHZ            => clk            ,
    u_instruction  => u_instruction  ,
    FlagZ          => FlagZ          ,
    FlagC          => FlagC          ,
    FlagN          => FlagN          ,
    FlagE          => FlagE          ,
    index_reg      => index_reg      ,
    databus        => databus           
);

Databus<="ZZZZZZZZ", "11100010" after 100 ns, "00001000" after 200 ns, "ZZZZZZZZ" after 350 ns;


 -- Clock generator
  p_clk : process
  begin
     clk <= '1', '0' after 25 ns;
     wait for 50 ns;
  end process;
  
-- Reset & Start generator
    p_reset : process
begin
       reset <= '0', '1' after 75 ns;
       u_instruction <= nop, op_lda after 150 ns, nop after 175 ns, op_ldb after 300 ns, op_add after 350 ns, op_oeacc after 400 ns;
        wait;
end process;
end testbench;



















