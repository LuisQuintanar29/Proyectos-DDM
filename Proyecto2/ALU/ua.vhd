library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;
--UA a,b,s,cin, salsum,cout
entity ua is
port(
a,b: in std_logic_vector(2 downto 0);--000 001 010 011  100 101 110 111
s: in std_logic_vector(1 downto 0);--s0   s1
 cin: in std_logic;
salsum: out std_logic_vector(2 downto 0); --000 001 010 011  100 101 110 111
cout:out std_logic );
end entity ua;

architecture arqUA of ua is
signal cablemux4B:std_logic_vector(2 downto 0);
begin
--del mux4                        port map (s,b,salmux4x1)
u1: entity work.mux4x1(arqmux4x1) port map (s,b, cablemux4B);

u2: entity work.sum(arqsum) port map (a, cablemux4B, cin, salsum,cout);

end architecture arqUA;