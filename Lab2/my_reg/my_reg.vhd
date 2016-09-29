----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:57:22 04/03/2014 
-- Design Name: 
-- Module Name:    my_reg - Behavioral 
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

entity my_reg is
port( X : in std_logic_vector(3 downto 0);
		Z1 : out std_logic_vector(3 downto 0);
		Z2 : out std_logic_vector(3 downto 0);
		Button_A, Button_B, en, ck : in std_logic);
end my_reg;
architecture Behavioral of my_reg is
Type my_state is (READY, ONE_EN, NOT_READY); --names for states
signal temp1, temp2 : std_logic_vector(3 downto 0); -- register-a place holder
signal CK1 : std_logic; -- declare signal EN to trigger register load
signal next_state : my_state;
begin
process(ck) --state machine to generate single step one clock cycle
begin
if ck='1' and ck'event then --sync to clock rising edge
	Case next_state is
		When READY => -- wait on button A press state
			CK1 <= '0'; -- assign CK1
			If Button_A = '1' then
				next_state <= ONE_EN;--state transition
			end if;
		When ONE_EN => -- generate high for one clock cycle state
			CK1 <= '1'; --assign ck1
			next_state <= NOT_READY; --transition
		When NOT_READY => --wait on press button B state
			CK1 <= '0'; -- assign ck1
			If Button_B = '1' then
				next_state <= READY; -- state transition
			end if;
	end case;
end if;
end process;
process(CK1) -- process for the cascading registers triggered by ck1 signal
Begin
if CK1 = '1' and CK1'event then -- synchronous fence
	if en = '1' then
		temp1 <= X;
		temp2 <= temp1;
	end if;
end if; -- end synchronous fence
end process;
	Z1 <= temp1;
	Z2 <= temp2; -- wire register contents to output ports
end Behavioral;

