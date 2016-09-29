----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:58 04/24/2014 
-- Design Name: 
-- Module Name:    t_gate - Behavioral 
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

entity t_gate is
generic( n : natural;
			k : natural );
port( x : in std_logic_vector(1 to n);
		z : out std_logic);
end t_gate;

architecture Behavioral of t_gate is
begin
process(x)
subtype temp1 is integer range 0 to n;
variable temp : temp1;
begin
temp := 0;
for i in 1 to n loop
	if x(i) = '1' then
		temp := temp + 1;
	end if;
end loop;

if temp >= k then
	z <= '1';
else
	z <= '0';
end if;
end process;


end Behavioral;

