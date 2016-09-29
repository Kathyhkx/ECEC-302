use IEEE.STD_LOGIC_1164.ALL;


entity t_gate_impl is
port( v : in std_logic_vector(5 downto 0);
		y : out std_logic);
end t_gate_impl;

architecture struc of t_gate_impl is
component t_gate
generic( n : natural;
			k : natural);
port( x : in std_logic_vector(1 to n);
		z : out std_logic);
end component;
begin
U2 : t_gate generic map (6,3) port map (z => y, x => v);

end struc;

