library ieee;
use ieee.std_logic_1164.all;



entity mux_2_n_1 is
	generic(N:natural);
	port(
		I:in std_logic_vector(2**N-1 downto 0);
		S:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end mux_2_n_1;

architecture struct of mux_2_n_1 is--mux_2_n_1 prin cascadare mux_2_1

component MUX_2_1 is
	port(
		I0,I1:in std_logic;
		S:in std_logic;
		Y:out std_logic
	);
end component MUX_2_1;

signal R:std_logic_vector(2**(N+1)-2 downto 0);
begin
R(2**(N+1)-2 downto 2**N-1)<=I;	
	generate_mux:
	for k in 0 to N-1 generate
		generate_level:
		for m in 0 to 2**k-1 generate
			U_fundamental_mux: mux_2_1
			port map(R(2**(k+1)-1+2*m),R(2**(k+1)+2*m),S(N-1-k),R(2**k-1+m));
		end generate generate_level;	
	end generate generate_mux;
Y<= R(0);
end struct;	



									 





