library ieee;
use ieee.std_logic_1164.all;

entity nor_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end nor_n_bit;

architecture struct of nor_n_bit is

component or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component or_n_bit;

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;
signal S: std_logic;
begin 
	U1_or_n: or_n_bit
	generic map(N=> N)
	port map(I,S);
	U2_or_inv: inv_simple
	port map(S,Y);
end struct;




