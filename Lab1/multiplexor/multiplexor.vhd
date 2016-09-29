----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:06 04/01/2014 
-- Design Name: 
-- Module Name:    multiplexor - Behavioral 
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

entity multiplexor is
port ( sel : in std_logic_vector(2 downto 0);
	x : in std_logic_vector(4 downto 0);
	z : out std_logic;
	z_L : out std_logic);
end multiplexor;

architecture Behavioral of multiplexor is
begin
process(sel, x)
begin
case sel is
	when "000" =>
		z <= x(0); z_L <= not x(0);
	when "001" =>
		z <= x(1); z_L <= not x(1);
	when "010" =>
		z <= x(2); z_L <= not x(2);
	when "011" =>
		z <= x(3); z_L <= not x(3);
	when "100" =>
		z <= x(4); z_L <= not x(4);
	when others =>
		z <= '1'; z_L <= '1';
end case;
end process;
end Behavioral;

