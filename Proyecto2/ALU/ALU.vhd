library ieee;
use ieee.std_logic_1164.all;

entity ALU is
port( a, b: in std_logic_vector(2 downto 0);
		s: in std_logic_vector(1 downto 0);
		sel: in std_logic;
		cin : in std_logic;
		ua, ul: in std_logic_vector (2 downto 0);
		f: out std_logic_vector (2 downto 0);
		salmux: out std_logic_vector (2 downto 0);
		salsum : out std_logic_vector (2 downto 0);
		cout : out std_logic);
		
end;

architecture arqALU of ALU is
signal salmuxb, salsumb : std_logic_vector (2 downto 0);
begin

u1: entity work.ua(arqUA) port map (a, b, s, cin, salsumb, cout);
	--entity work.UA(arqUA) port map (a, b, s, cin, salsum, cout)
u2: entity work.ul(arqUL) port map (a, b, s, salmuxb);
	--entity work.UL(arqUL) port map (a, b, s, f)
u3: entity work.mux2x1(arqmux2x1) port map(salsumb, salmuxb, sel ,salmux);
	--entity work.mux2x1(ua, ul, salmux)
end;