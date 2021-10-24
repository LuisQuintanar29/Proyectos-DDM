library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.std_logic_1164.all;
--unidad=>s(2),b(3),salmux4x1(3)
--del mux4 port map(s,b, salmux4x1)
entity mux4x1 is
port(
s: in std_logic_vector(1 downto 0); --s(1) y s(0)
b: in std_logic_vector(2 downto 0); --000 001 010 011  100 101 110 111
salmux4x1: out std_logic_vector(2 downto 0)
);
end entity mux4x1;
architecture arqmux4x1 of mux4x1 is
begin
with s select
salmux4x1 <= 
            (others=>'0') when "00",
				            b when "01",
					    not  b when "10",
				(others=>'1')  when "11",
				(others=>'0') when others;
				
end architecture arqmux4x1;