library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pipe_mult is
generic (N: natural := 4);
port(                x : in    std_logic_vector(N-1 downto 0);
                        y : in    std_logic;
                        z : out  std_logic;
ck, reset,b1,b2 : in    std_logic);
end pipe_mult;

architecture struc of pipe_mult is

component pe
port( x_i,y_i,c_in,ps_in: in std_logic;
y_out,c_out,ps_out: out std_logic;
ck, reset: in std_logic);
end component;

component DFF
port( x, reset, ck: in std_logic;
Q: out std_logic);
end component;

-- wires declaration
signal yy, c, ps: std_logic_vector(n-1 downto 0);
signal w, en: std_logic;
type my_state is (READY, ONE_EN, NOT_READY);
signal n_s : my_state;
begin
D: DFF port map(w, reset, en, ps(n-1)); -- what wire is w in Fig. 2?

g1: for i in 0 to n-1 generate
	g2: if i=0 generate
		cell: pe port map(x(i), yy(i), c(i), ps(i), yy(i+1), c(i+1), z, en, reset);
	end generate g2;
	
	g3: if i > 0 and i < n-1 generate
		cell: pe port map(x(i), yy(i), c(i), ps(i), yy(i+1), c(i+1), ps(i-1), en, reset);
	end generate g3;
	
	g4: if i=n-1 generate
		
		cell: pe port map(x(i), yy(i), c(i), ps(i), open, w, ps(i-1), en, reset);
	end generate g4;
	
end generate g1;

c(0) <= '0';
yy(0) <= y;
-- Wire Input Ports c(0) <= ?; yy(0) <= ?
--

-- Single Step process generates en from b1 and b2 button press
process(ck)
begin
	if ck='1' and ck'event then
		case n_s is
			when READY => -- ready for next input
				en <= '0'; -- disable input capture
				if b1 = '1' then -- enable input capture if b1 is pressed
					n_s <= ONE_EN;
				end if;
			when ONE_EN =>
				en <= '1'; -- read switch input
				n_s <= NOT_READY; -- disable input capture and wait for b2 press
			when NOT_READY =>
				en <= '0'; -- disable input capture
				if b2 = '1' then
					n_s <= READY; -- switch to READY indicating you are ready for the next input
				end if;
		end case;
	end if;
end process;
end struc;