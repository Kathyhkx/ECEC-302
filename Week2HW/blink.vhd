----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:34:22 04/10/2014 
-- Design Name: 
-- Module Name:    blink - Behavioral 
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

entity blink is
port (b1, b2, ck, reset	: in std_logic;
		z	: 					  out std_logic);
end blink;

architecture Behavioral of blink is
signal temp : std_logic;

type my_state is (s0, s1);
signal n_s : my_state;

begin

process(ck,b1,b2,reset)
variable count : integer;
begin
if ck = '1' and ck'event then
	case n_s is
		when s0 =>
			if b1 = '1' then
				count := 0;
				n_s <= s1;
			elsif b1 = '0' then
				if count = 999999 then
					temp <= not temp;
					count := 0;
				else
					count := count + 1;
				end if;
			end if;
		when s1 =>
			if b2 = '1' then
				count := 0;
				n_s <= s0;
			elsif b2 = '0' then
				if reset = '1' then
					count := 0;
					n_s <= s0;
				elsif reset = '0' then
					if count = 9999999 then
						temp <= not temp;
						count := 0;
					else
						count := count + 1;
					end if;
				end if;
			end if;
		when others =>
			n_s <= s0;
	end case;
end if;
end process;

process(temp)
begin
if temp = '1' then z <= '1';
elsif temp = '0' then z <= '0';
else null;
end if;
end process;

end Behavioral;