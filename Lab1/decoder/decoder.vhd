----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:53:42 04/01/2014 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

entity decoder is
port (x : in std_logic_vector(2 downto 0);
	en : in std_logic;
	z : out std_logic_vector(7 downto 0));
end decoder;
architecture Behavioral of decoder is
begin
process(x, en) -- a process describing decoder behavior
begin
if en = '0' then -- which runs when x or en changes (an event)
	z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
else
	case x is
		when "000" =>
			z(0) <= '1'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
		when "001" =>
			z(0) <= '0'; z(1) <= '1'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
		when "010" =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '1'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
		when "011" =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '1'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
		when "100" =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '1'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
		when "101" =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '1'; z(6) <= '0'; z(7) <= '0';
		when "110" =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '1'; z(7) <= '0';
		when "111" =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '1';
		when others =>
			z(0) <= '0'; z(1) <= '0'; z(2) <= '0'; z(3) <= '0'; z(4) <= '0'; z(5) <= '0'; z(6) <= '0'; z(7) <= '0';
	end case;
end if;
end process;
end Behavioral;

