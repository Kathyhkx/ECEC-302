----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:08:41 05/27/2014 
-- Design Name: 
-- Module Name:    radixR_adder - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL,IEEE.STD_LOGIC_ARITH.ALL,IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity radixR_adder is
generic (r : natural := 5; --r radix
			n : natural := 3); --n is the least integer > log r
port	  (x, y : in std_logic_vector(n-1 downto 0);
			ck,b1,b2,reset : in std_logic;
			z : out std_logic_vector(n-1 downto 0));
end radixR_adder;

architecture Behavioral of radixR_adder is
type state is (no_carry,carry);
signal n_s : state;
signal temp_x, temp_y, temp_out : std_logic_vector(n downto 0);--n+1 bit vector
type my_state is (READY, ONE_EN, NOT_READY);
signal dbns : my_state;
signal ck1 : std_logic;
begin
temp_x <= '0' & x;
temp_y <= '0' & y;
z <= temp_out;
process(ck1)
variable temp : std_logic_vector(n downto 0); -- n+1 bit vector
begin
if ck1='1' and ck1'event then
	case n_s is
		when no_carry =>
			temp := temp_x + temp_y;
			if unsigned(temp) < r or reset='1' then
				n_s <= no_carry;
				temp_out <= temp;
			elsif unsigned(temp) > r-1 and reset='0' then
				n_s <= carry;
				temp_out <= temp-r;
			else
				null;
			end if;
		when carry =>
			temp := temp_x + temp_y;
			if unsigned(temp) > r-2 then
				n_s <= carry;
				temp_out <= temp-r+1;
			elsif unsigned(temp) < r-1 or reset = '1' then
				n_s <= no_carry;
				temp_out <= temp+1;
			else
				null;
			end if;
	end case;
end if;

end process;

process(ck)
begin
	if ck='1' and ck'event then
		case dbns is
			when READY => -- ready for next input
				ck1 <= '0'; -- disable input capture
				if b1 = '1' then -- enable input capture if b1 is pressed
					dbns <= ONE_EN;
				end if;
			when ONE_EN =>
				ck1 <= '1'; -- read switch input
				dbns <= NOT_READY; -- disable input capture and wait for b2 press
			when NOT_READY =>
				ck1 <= '0'; -- disable input capture
				if b2 = '1' then
					dbns <= READY; -- switch to READY indicating you are ready for the next input
				end if;
		end case;
	end if;
end process;
end Behavioral;

