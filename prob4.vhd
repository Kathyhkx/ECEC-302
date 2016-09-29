library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity decimal_N_digit_add is
generic(N: natural := 3);
port( x, y : in std_logic_vector(4*N - 1 downto 0);
        z  : out std_logic_vector(4*N - 1 downto 0)
    );
end decimal_N_digit_add;

architecture beh of decimal_N_digit_add is 
begin
process(x,y)
variable carry: std_logic;
variable temp, temp_x, temp_y: std_logic_vector(4 downto 0);
begin
carry := '0';
for i in 0 to N-1 loop
   temp_x := '0'&x(4*(i+1)-1 downto 4*i);
   temp_y := '0'&y(4*(i+1)-1 downto 4*i);
   temp := temp_x + temp_y;
if carry = '1' then
   temp := temp + 1;
end if;
if temp > 9 then
   carry := '1';
   temp := temp + 6;
end if;

z(4*(i+1)-1 downto 4*1) <= temp(3 downto 0);
end loop;
end process;
end beh;