----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:00:09 05/15/2014 
-- Design Name: 
-- Module Name:    myfifo - Behavioral 
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

entity myfifo is
port( ck,b1,b2 : in std_logic;
		rst : in std_logic;
		din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		wr_en : IN STD_LOGIC;
		--rd_en : IN STD_LOGIC;
		dout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		full : OUT STD_LOGIC;
		empty : OUT STD_LOGIC);
end myfifo;

architecture Behavioral of myfifo is

component fifo_416
port( clk : IN STD_LOGIC;
		srst : IN STD_LOGIC;
		din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		wr_en : IN STD_LOGIC;
		rd_en : IN STD_LOGIC;
		dout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		full : OUT STD_LOGIC;
		empty : OUT STD_LOGIC);
end component;
signal en,slowclk,clk1,sel,temp_rd,temp_full,temp_empty : std_logic;
type db_state is (not_rdy,rdy,pulse);
signal db_ns : db_state;

type full_state is (isfull,not_full);
signal full_ns : full_state;

begin

U2 : fifo_416 port map(clk=>clk1,srst=>rst,din=>din,wr_en=>wr_en,rd_en=>temp_rd,dout=>dout,full=>temp_full,empty=>temp_empty);
full <= temp_full;
empty <= temp_empty;

process(en,slowclk,sel)
begin
if sel = '0' then
	clk1 <= en;
else
	clk1 <= slowclk;
end if;
end process;

process(slowclk,temp_full,temp_empty) -- full read until empty
begin -- need reset after empty
	if slowclk='1' and slowclk'event then
		if rst = '1' then
			full_ns <= not_full;
			sel <='0';
		else
			case full_ns is
				when not_full =>
					if temp_full = '1' then
						temp_rd <= '1';
						sel <= '1';
						full_ns <= isfull;
					else
						sel <= '0';
						temp_rd <= '0';
					end if;
				when isfull =>
					if temp_empty = '1' then
						temp_rd <= '0';
						sel <= '0';
						full_ns <= not_full;
					else
						sel <= '1';
						temp_rd <= '1';
					end if;
			end case;
		end if;
	end if;
end process;

process(ck)
variable count : integer := 0;
begin
	if ck='1' and ck'event then
		if count < 50000000 then
			count := count + 1;
			slowclk <= '0';
		else
			count := 0;
			slowclk <= '1';
		end if;
	end if;
end process;

process(ck,b1,b2)
begin
	if ck='1' and ck'event then
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

