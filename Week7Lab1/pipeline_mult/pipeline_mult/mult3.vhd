----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:01:18 05/13/2014 
-- Design Name: 
-- Module Name:    mult3 - Behavioral 
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

entity mult3 is
port( x : in std_logic_vector(4-1 downto 0);
		y : in std_logic;
		z : out std_logic;
		ck, reset, b1, b2 : in std_logic);
end mult3;

architecture Behavioral of mult3 is

component pipe_mult
generic (N: natural := 4);
port(x : in    std_logic_vector(N-1 downto 0);
     y : in    std_logic;
     z : out  std_logic;
ck, reset,b1,b2 : in    std_logic);
end component;
begin

threemult : pipe_mult generic map (4) port map(x,y,z,ck,reset,b1,b2);

end Behavioral;

