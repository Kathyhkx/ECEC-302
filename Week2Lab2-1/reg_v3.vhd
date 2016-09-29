----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:39:42 04/10/2014 
-- Design Name: 
-- Module Name:    reg_v3 - Behavioral 
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

entity reg_v3 is
port(	sw 		: in	std_logic_vector(7 downto 0);
		z 			: out	std_logic_vector(7 downto 0);
		disp_en	: out	std_logic_vector(3 downto 0);
		ck, reset: in std_logic);
end reg_v3;

architecture Behavioral of reg_v3 is
type my_state is (s0, s1, s2, s3); -- states for the four 7-seg displays
signal n_s : my_state; -- time division multiplex of the pairs
signal ck_div : std_logic; -- of switches data to the displays
signal sw_sel : std_logic_vector(0 to 3);
begin
process(sw_sel) -- multiplex switch inputs to display bus
variable temp : std_logic_vector(1 downto 0);
begin
case sw_sel is
	when "1000" =>
		temp := sw(7 downto 6);
	when "0100" =>
		temp := sw(5 downto 4);
	when "0010" =>
		temp := sw(3 downto 2);
	when "0001" =>
		temp := sw(1 downto 0);
	when others =>
		temp := "00";
end case;
case temp is
	when "00" =>
		z <= "00000011";
	when "01" =>
		z <= "10011111";
	when "10" =>
		z <= "00100101";
	when "11" =>
		z <= "00001101";
	when others =>
		null;
end case;
end process;

process(ck_div) -- state machine for TMD: Control for switch
begin -- select and display enable
if ck_div'event and ck_div='1' then
	case n_s is
		when s0 =>
			sw_sel <= "1000";
			disp_en <= "0111";
			n_s <= s1;
		when s1 =>
			sw_sel <= "0100";
			disp_en <= "1011";
			n_s <= s2;
		when s2 =>
			sw_sel <= "0010";
			disp_en <= "1101";
			n_s <= s3;
		when s3 =>
			sw_sel <= "0001";
			disp_en <= "1110";
			n_s <= s0;
	end case;
end if;
end process;

process(ck) -- clock division
variable count : integer;
begin
if ck = '1' and ck'event then
	if reset = '1' then
		count := 0;
		ck_div <= '0';
	elsif reset = '0' then
		if count = 99999 then
			ck_div <= not ck_div;
			count := 0;
		else
			count := count + 1;
		end if;
	end if;
end if;
end process;
end Behavioral;

