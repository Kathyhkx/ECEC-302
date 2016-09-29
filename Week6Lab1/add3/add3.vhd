----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:56:12 05/06/2014 
-- Design Name: 
-- Module Name:    add3 - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add3 is
port(	ck, reset, go, b1, b2 : in std_logic;
		a, b : in std_logic_vector(2 downto 0);
		c : out std_logic_vector(2 downto 0);
		c_out : out std_logic);
end add3;

architecture Behavioral of add3 is
component adder
Generic (k: natural := 3);--k will be mapped onto the components used
Port ( a, b : in std_logic_vector(k-1 downto 0);
        C : out std_logic_vector(k-1 downto 0);
        C_out : out std_logic;
        Go,reset,ck : in std_logic);
end component;
type db_state is (not_rdy, rdy, pulse);
signal db_ns : db_state;
signal en : std_logic;
begin
U2 : adder generic map(3) port map (a,b,c,c_out,go,reset,en);
process(ck,b1,b2) -- single step
begin
if ck='1' and ck'event then
	case db_ns is
		when not_rdy =>
			if b1 = '1' then
				db_ns <= rdy;
			end if;
			en <= '0';
		when rdy =>
			en <= '1';
			db_ns <= pulse;
		when pulse =>
			en <= '0';
			if b2 = '1' then
				db_ns <= not_rdy;
			end if;
	end case;
end if;
end process;
end Behavioral;
