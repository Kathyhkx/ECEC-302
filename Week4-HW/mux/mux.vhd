----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:25 04/22/2014 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
generic (m : natural);
port(x: in std_logic_vector(0 to 2**m-1);
z: out std_logic;
s: in std_logic_vector(m-1 downto 0));
end mux;

architecture Behavioral of mux is
signal tempOut : std_logic;
begin
process(x,s)
subtype temp1 is integer range 0 to m**2-1;
variable temp : temp1;
begin
temp := 0;
for i in 0 to m-1 loop
	if s(i) = '1' then
		temp := temp + 2**i;
	end if;
end loop;

tempOut <= x(temp);
end process;
z <= tempout;

end Behavioral;

