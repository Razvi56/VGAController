library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_1 is
	port(
		I0,I1:in std_logic;
		S:in std_logic;
		Y:out std_logic
	);
end MUX_2_1;

architecture struct of MUX_2_1 is

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

component or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component or_n_bit;

signal S0: std_logic;
signal S1: std_logic;
signal S2: std_logic;
begin
	U0: inv_simple
	port map(S,S0);
	U1: and_N_bit
	generic map(N=>2)
	port map(I(0)=>S0,I(1)=>I0,Y=>S1);
	U2:and_N_bit
	generic map(N=>2)
	port map(I(0)=>S,I(1)=>I1,Y=>S2);
	U3:or_N_bit
	generic map(N=>2)
	port map(I(0)=>S1,I(1)=>S2,Y=>Y);
end struct;







