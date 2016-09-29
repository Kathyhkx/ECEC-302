-- Problem 2
-- Design an up/down counter using IP catalog
-- core

library ieee;
use ieee.std_logic_1164.all;

entity updown_count is
port( CK, updown : in std_logic;
      Q : out std_logic_vector(3 downto 0));
end updown_count;

architecture behavioral of updown_count is
component c_counter_binary_0
  port(
    CLK : in std_logic;
    UP : in std_logic;
    Q : out std_logic_vector(3 downto 0)
    );
end component;

begin
U :  c_counter_binary_0
PORT MAP (CLK => CK, UP => updown, Q => Q);
end Behavioral; 