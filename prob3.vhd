-- Write a test bench for the factorial sequential
-- circuit for n = 1, …, 10.
----------------------------------
-- library ieee;
-- use ieee.std_logic_1164.all
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all

-- entity fact is
-- generic (K: natural := 32);
-- port(ck, reset: in std_logic;
--      LED: out std_logic_vector(K-1 downto 0));
-- end fact;

-- architecture Behavioral of fact is
-- signal temp: std_logic_vector(2*K - 1 downto 0);
-- signal n: std_logic_vector(k-1 downto 0);

-- begin
-- process(ck)
-- begin
-- if ck = '1' and ck'event then
--    if reset = '1' then
--    temp <= (0 => '1', others => '0');
--    n <= (0 => '1', others => '0');
--    else
--    temp <= n * temp(K-1 downto 0);
--    n <= n+1;
--    end if;
-- end if;
-- end process;
-- LED <= temp(K-1 downto 0);
-- end Behavioral;
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fact_tb is
end fact_tb;
architecture Beh of fact_tb is
component fact
generic (K: natural := 32); --number of bits
port(ck, reset: in std_logic;
     LED: out std_logic_vector(K-1 downto 0));
end component;

signal z: std_logic_vector(31 downto 0);
signal n, n_factorial: integer := 1;
signal ck: std_logic := '1';
type my_stste is (init, run_test, done);
signal n_s: my_state := init;
signal reset: std_logic := '1';
begin
ck <= not ck after 5 ns;
dut: fact generic map(32)
      port map(ck, reset, z);
process(ck)
variable n, n_factorial: integer := 0;
begin
if ck = '1' then
   case n_s is
   when init => reset <= '1';
               n := 1;
         n_factorial := 1;
         n_s <= run_test;
    when run_test => reset <= '0';
         n_factorial := n*n_factorial;
        n := n + 1;
    assert conv_integer(unsigned(z)) = n_factorial
           report "incorrect" severiy ERROR;
              if n > 11 then
            n_s <= done;
        end if;
    when done => assert FALSE
        report "test completed" severity FAILURE;
    end case;
end if;
end process;
end beh;