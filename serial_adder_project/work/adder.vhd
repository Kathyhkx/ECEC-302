Library ieee;
Use ieee.std_logic_1164.all, work.p1_pack.all;
Entity adder is
Generic (k: natural := 3);--k will be mapped onto the components used
Port ( a, b : in std_logic_vector(k-1 downto 0);
        C : out std_logic_vector(k-1 downto 0);
        C_out : out std_logic;
        Go,reset,ck : in std_logic);
End adder;
Architecture struc of adder is--Component declaration (copy-paste of entitydeclaration)
--For example you need to declare the serial_adder

component serial_adder
Generic (N: natural := 8);
  PORT(
    SIGNAL a , b , clk,en : IN std_logic;
    SIGNAL s: OUT std_logic_vector(N-1 DOWNTO 0);
    SIGNAL cout,done : OUT std_logic);
end component; 

component control
  Port (go, ck, reset, done : in std_logic;
      sel : out sh_reg_sel;
      En : out std_logic);
end component;

component sh_reg
  Generic (n : natural := 4);--specifiable parameter (default to 4)
Port (x : in std_logic_vector(n-1 downto 0);
z : out std_logic;
Sel : in sh_reg_sel;
Ck : in std_logic);
end component;

component adder
  Port (go, ck, reset, done : in std_logic;
      sel : out sh_reg_sel;
      En : out std_logic);
end component;
--declare other components, i.e.,
--shift register, controller
--Internal signals (wires)
signal sel : sh_reg_sel;
signal a_bit,b_bit,done,en : std_logic;
begin
--instantiation and wiring
s_adder: serial_adder generic map(k)
port map(a_bit,b_bit,ck,en,c,c_out,done);

reg_A:  sh_reg generic map(k)
port map(a,a_bit,sel,ck);
  
reg_B:  sh_reg generic map(k)
port map(b,b_bit,sel,ck);
  
controller : control
port map(go, ck, reset, done,sel,en);
  
--Instantiate other components
--The design comprises
--2 shift registers, a controller, and a serial adder
end struc; 