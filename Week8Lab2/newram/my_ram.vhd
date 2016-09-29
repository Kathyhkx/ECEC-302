library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_ram is
port( clka : in std_logic;
		wea : in std_logic_vector(0 downto 0);
		addra : in std_logic_vector(3 downto 0);
		dina : in std_logic_vector(3 downto 0);
		douta : out std_logic_vector(3 downto 0);
		douta2 : out std_logic_vector(3 downto 0));
end my_ram;

architecture Behavioral of my_ram is
component ram_416
port( clka : in std_logic;
		wea : in std_logic_vector(0 downto 0);
		addra : in std_logic_vector(3 downto 0);
		dina : in std_logic_vector(3 downto 0);
		douta : out std_logic_vector(3 downto 0));
end component;
begin
U2 : ram_416 port map(clka => clka, wea => wea, addra => addra, dina => dina, douta => douta);
U22 : ram_416 port map(clka => clka, wea => wea, addra => addra, dina => dina, douta => douta2);
end Behavioral;
