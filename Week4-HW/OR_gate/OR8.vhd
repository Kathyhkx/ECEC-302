----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:51 04/22/2014 
-- Design Name: 
-- Module Name:    OR8 - Behavioral 
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

entity OR8 is
port(v : in std_logic_vector(1 to 8);
	  y : out std_logic);
end OR8;

architecture struc of OR8 is
component OR_gate
generic(n: natural);
port(x: in std_logic_vector(1 to n);
		z: out std_logic);
end component;
begin
U2: OR_gate generic map (8) port map (z => y, x => v);

end struc;

