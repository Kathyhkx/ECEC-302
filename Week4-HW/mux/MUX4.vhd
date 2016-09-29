----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:35 04/24/2014 
-- Design Name: 
-- Module Name:    MUX4 - Behavioral 
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

entity MUX4 is
port( v : in std_logic_vector(0 to 3);
		d : in std_logic_vector(1 downto 0);
		y : out std_logic);
end MUX4;

architecture struc of MUX4 is
component mux
generic(m: natural);
port(x: in std_logic_vector(0 to 2**m-1);
z: out std_logic;
s: in std_logic_vector(m-1 downto 0));
end component;
begin
U2: mux generic map (2) port map (z => y, x => v, s => d);

end struc;

