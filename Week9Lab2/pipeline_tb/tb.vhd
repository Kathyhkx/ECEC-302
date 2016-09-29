library IEEE;
use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, IEEE.STD_LOGIC_SIGNED.ALL;
entity tb is
constant n : natural := 3; -- number of bits
constant T0: natural := 2; -- rate - 1/T0 where T0=2 every other clock cycle
constant k : natural := 3; -- test vectors
constant L : natural := 1; -- delay
end tb;

architecture Behavioral of tb is
component pipe_mult
generic (N: natural := 4);
port( x : in    std_logic_vector(N-1 downto 0);
      y : in    std_logic;
      z : out  std_logic;
	  ck, reset : in    std_logic);
end component;

signal ck: std_logic := '0';
type my_state is (init, apply_bit, check, done);
signal n_s: my_state;
type vector_array is array (natural range <>) of std_logic_vector(n-1 downto 0);
signal test_vector_x : vector_array(0 to k-1) := ("111", "011", "001");
signal test_vector_y : vector_array(0 to k-1) := ("111", "100", "101");
signal x_vector, y_vector : std_logic_vector(n-1 downto 0);
signal z_vector : std_logic_vector(2*n-1 downto 0);
signal y, z, reset : std_logic;

begin
ck <= not ck after 50 ns;
dut : pipe_mult generic map(n) port map(x_vector, y, z, ck, reset); -- y is bit-serial input

process(ck)
variable t, i, j : integer := 0; -- t cycle, i-th vector, j-th bit position
begin
if ck = '1' then
	case n_s is
		when init =>
			n_s <= apply_bit;
			t := 0;
			j := 0;
			reset <= '1';
			x_vector <= test_vector_x(i);
			y_vector <= test_vector_y(i);
			z_vector <= (others => '0');
		when apply_bit =>
			reset <= '0';
			if t = 0 then
				y <= y_vector(j);
				j := j+1;
			end if;
			if t>L-1 and t < N*T0 then
				if t mod T0 = 0 then
					y <= y_vector(j);
					j := j+1;
					z_vector <= z & z_vector(2*n-1 downto 1);
				else
					y <= '0';
				end if;
			end if;
			if t > n*T0 - 1 then
				y <= '0';
				if (t mod T0 = 0) and (t < n*T0 + n*T0 + T0*L) then
					z_vector <= z & z_vector(2*n-1 downto 1);
				elsif t = n*T0 + n*T0 + T0*L then
					n_s <= check;
				end if;
			end if;
			t := t+1;
		when check =>
			reset <= '0';
			assert z_vector = unsigned(x_vector) * unsigned(y_vector) report "INCORRECT" severity FAILURE;
			i := i+1;
			if i = K then
				n_s <= done;
			else
				n_s <= init;
			end if;
		when done =>
			assert FALSE report "TEST COMPLETE" severity FAILURE;
			reset <= '0';
	end case;
end if;
end process;
end Behavioral;