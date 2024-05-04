library ieee;
use ieee.std_logic_1164.all;

entity f_simple_comp_1_bit is
	port(
		A,B:in std_logic;
		F_sm,F_eq,F_gr:out std_logic
	);
end f_simple_comp_1_bit;

architecture struct of f_simple_comp_1_bit is

component and_n_bit is
	generic(N:natural);--N>=2
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component nxor_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component nxor_n_bit;

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

signal S0: std_logic; 
signal S1: std_logic;

begin
	U0: inv_simple
	port map(A,S0);
	U1: inv_simple
	port map(B,S1);
	U2: and_n_bit
	generic map(N=>2)
	port map(I(0)=>S0,I(1)=>B,Y=>F_sm);
	U3: nxor_n_bit
	generic map(N=> 2)
	port map(I(0)=>A,I(1)=>B,Y=> F_eq);
	U4: and_n_bit
	generic map(N=> 2)
	port map(I(0)=>A,I(1)=>S1,Y=> F_gr);
end struct;










