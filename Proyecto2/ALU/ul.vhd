library ieee;
use ieee.std_logic_1164.all;

--unidadUL=> a(3),b(3),s(2),F(3)
entity ul is
port(
a,b: in std_logic_vector(2 downto 0);
s: in std_logic_vector(1 downto 0);
F: out std_logic_vector(2 downto 0)
);
end entity ul;

architecture arqUL of ul is
signal sand, sor, sxor,snot: std_logic_vector(2 downto 0);

begin
sand<= a and b;
sor <= a or b;
sxor<= a xor b;
snot<= not a;

with s select 
F<=           sand when "00",
               sor when "01",
	           sxor when "10",
	           snot when "11",
			(others=>'0') when others;
			
end architecture arqUL;