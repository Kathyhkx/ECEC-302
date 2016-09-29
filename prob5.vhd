library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity accumulator_latency_L is
generic( N: natural := 4);
         L: natural := 3);
port (ck, reset :  in_std_logic;
       x : in std_logic_vector(n-a downto 0);
       z : out std_logic_vector(2*n-1 downto 0)
    );
end accumulator_latency_L;

architecture beh of accumulator_latency_L is
type vector_array is
array (natural range <>) of std_logic_vector(n-1 downto 0);
signal latency_temp: vector_array(0 to L-2);
signal zero_vector, one_vector: std_logic_vector(n-1 downto 0);
signal temp, temp_x: syd_logic_vector(2*n-1 downto 0);

begin
zero_vector <= (others => '0');
one_vector <= (others => '1');
process(latency_temp(L-2))
begin
   if signed(latency_temp(L-2)) < 0 then
      temp_x <= one_vector&latency_temp(L-2);
    else
      temp_x <= zero_vector&latency_temp(L-2);
    end if;
end process;

process(ck) 
begin
if ck='1' and ck'event then
  if reset = '1' then
    for i in 0 to L-2 loop
      latency_temp(i) <= (others => '0');
    end loop;
    temp <= (others => '0');
  else
    temp <= temp + temp_x;
    latency_temp <= x&latency_temp(0 to L-3);
  end if;
end if;
end process;
z <= temp;
end beh;
