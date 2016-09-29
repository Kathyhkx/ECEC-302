----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:54:04 04/22/2014 
-- Design Name: 
-- Module Name:    OR_gate - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OR_gate is
generic (n: natural);
port(x: in std_logic_vector(1 to n);
z: out std_logic);
end OR_gate;

architecture Behavioral of OR_gate is

begin
process(x)
variable temp: std_logic;
begin
temp:='0';
for i in 1 to N loop
	temp := temp or x(i);
end loop;
z <= temp;
end process;


end Behavioral;

