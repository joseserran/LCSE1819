----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2018 00:13:43
-- Design Name: 
-- Module Name: Shift_register - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftRegister is
port (
      Reset  : in  std_logic;
      Clk    : in  std_logic;
      Enable : in  std_logic;
      D      : in  std_logic;
      Q      : out std_logic_vector(7 downto 0));


--  Port ( 
--    Reset : in STD_LOGIC;
--    Clk : in STD_LOGIC;
--    Enable : in STD_LOGIC;
--    D : in STD_LOGIC;
--    Q : out STD_LOGIC_vector (7 downto 0)
  
--  );
end ShiftRegister;

architecture Behavioral of ShiftRegister is
signal shift_reg : std_logic_vector (7 downto 0):="00000000";

begin
reloj: process(Clk,Reset,Enable)
begin
    if Reset ='0' then
    Q<="00000000";
    elsif Clk'event and Clk = '1' then
        if Enable='1' then
        shift_reg(7) <= D;
        shift_reg(6) <= shift_reg(7);
        shift_reg(5) <= shift_reg(6);
        shift_reg(4) <= shift_reg(5);
        shift_reg(3) <= shift_reg(4);
        shift_reg(2) <= shift_reg(3);
        shift_reg(1) <= shift_reg(2);
        shift_reg(0) <= shift_reg(1);
        Q <= shift_reg;
        end if;
    end if;
end process;

end Behavioral;

