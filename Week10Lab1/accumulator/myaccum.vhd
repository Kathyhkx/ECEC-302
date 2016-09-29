----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:54 06/03/2014 
-- Design Name: 
-- Module Name:    myaccum - Behavioral 
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

entity myaccum is
port( b1,b2 : in std_logic;
		b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		clk : IN STD_LOGIC;
		ce : IN STD_LOGIC;
		sclr : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end myaccum;

architecture Behavioral of myaccum is

signal en : std_logic;
type db_state is (not_rdy,rdy,pulse);
signal db_ns : db_state;

COMPONENT accum
  PORT (
    b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    sclr : IN STD_LOGIC;
    q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

begin

U2 : accum port map(b,en,ce,sclr,q);

process(clk,b1,b2)
begin
	if clk='1' and clk'event then
		case db_ns is
			when not_rdy =>
				if b1='1' then
					db_ns <= rdy;
				end if;
				en <= '0';
			when rdy =>
				if b2 = '1' then
					db_ns <= pulse;
				end if;
				en <= '0';
			when pulse =>
				db_ns <= not_rdy;
				en <= '1';
			when others =>
				null;
		end case;
	end if;
end process;

end Behavioral;

