-- Problem 1
-- Design an up/down counter using arith and
-- unsigned package

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity counter is
  generic( n: natural := 4);
  port (ck, reset, up_down: in std_logic;
         z : out std_logic_vector(n-1 downto 0)
         );
end counter;

architecture beh of counter is
  signal temp: std_logic_vector(n-1 downto 0);
begin
process(ck)
begin
if ck = '1' and ck'event then
  if reset = '1' then
     temp <= (others => '0')
  else
    if up_down = '0' then
       temp <= temp + 1;
    else
       temp <= temp - 1;
    end if;
  end if;
end if;
end process;
z <= temp;
end beh;
