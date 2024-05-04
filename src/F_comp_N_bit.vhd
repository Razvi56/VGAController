library ieee;
use ieee.std_logic_1164.all;

entity f_comp_n_bit is
	generic(N:natural);
	port(
		A,B:in std_logic_vector(N-1 downto 0);
		F_sm,F_eq,F_gr:out std_logic
	);
end f_comp_n_bit;	

architecture struct of f_comp_n_bit is 

	component f_comp_1_bit is
	port(
		P_sm,P_eq,P_gr,A,B:in std_logic;
		F_sm,F_eq,F_gr:out std_logic
	);
	end component f_comp_1_bit;
	
	component f_simple_comp_1_bit is
	port(
		A,B:in std_logic;
		F_sm,F_eq,F_gr:out std_logic
	);
	end component f_simple_comp_1_bit;
	
	signal S0:std_logic_vector(N-1 downto 0);
	signal S1:std_logic_vector(N-1 downto 0);
	signal S2:std_logic_vector(N-1 downto 0);

begin
	U_first: f_simple_comp_1_bit
	port map(A(N-1),B(N-1),S0(N-1),S1(N-1),S2(N-1));
	
	generate_comparator_1:
	for k in N-2 downto 0 generate
		U_comp_1: f_comp_1_bit
		port map(S0(k+1),S1(k+1),S2(k+1),A(k),B(k),S0(k),S1(k),S2(k));
	end generate generate_comparator_1;
	F_sm<=S0(0);
	F_eq<=S1(0);
	F_gr<=S2(0);
end struct;	  



















