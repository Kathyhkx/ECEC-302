Library ieee;
Use ieee.std_logic_1164.all, ieee.std_logic_arith.all;
entity PE is
port (x_in, y_in, ps_in, c_in : in std_logic;
        x_out, y_out, ps_out, c_out: out std_logic);
end PE;

architecture concurrent of PE is
signal temp: std_logic;
begin
temp <= x_in and y_in;
x_out <= x_in; y_out <= y_in;
c_out <= (ps_in and temp) or (temp and c_in) or (c_in and ps_in);
ps_out <= ps_in xor temp xor c_in;
end concurrent;
