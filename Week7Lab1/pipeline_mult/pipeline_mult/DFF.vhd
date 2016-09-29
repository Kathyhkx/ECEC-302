library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Entity  DFF is
port( x, reset, ck: in std_logic;
Q: out std_logic);
end DFF;

architecture beh of DFF is
begin
process(ck,x)
begin
if ck = '1' and ck'event then
	if reset = '1' then
		Q <= '0';
	else
		Q <= x and ck;
	end if;
end if;
end process;
end beh;