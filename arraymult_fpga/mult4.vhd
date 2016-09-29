----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:49:59 05/08/2014 
-- Design Name: 
-- Module Name:    mult4 - Behavioral 
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

entity mult4 is
port (a, b : in std_logic_vector (4-1 downto 0);
      p : out std_logic_vector(2*4 - 1 downto 0));
end mult4;

architecture struc of mult4 is

component a_mult
generic (N: natural := 4);
port (a, b : in std_logic_vector (n-1 downto 0);
      p : out std_logic_vector(2*n - 1 downto 0));
end component;
begin
fourmult : a_mult generic map (4) port map (a,b,p);

end struc;

