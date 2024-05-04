library ieee;
use ieee.std_logic_1164.all;

entity f_sum_1_bit is
	port(
		A,B,cin:in std_logic;
		S,cout:out std_logic
	);
end f_sum_1_bit;	

architecture struct of f_sum_1_bit is

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component or_n_bit;

component xor_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component xor_n_bit;

signal S0:std_logic;
signal S1:std_logic;
signal S2:std_logic;
begin
	U1:xor_n_bit
	generic map(N=>3)
	port map(I(0)=>A,I(1)=>B,I(2)=>cin,Y=>S);
	U2:and_n_bit
	generic map(N=>2)
	port map(I(0)=>A,I(1)=>B,Y=>S0);
	U3:and_n_bit
	generic map(N=>2)
	port map(I(0)=>A,I(1)=>cin,Y=>S1);
	U4:and_n_bit
	generic map(N=>2)
	port map(I(0)=>B,I(1)=>cin,Y=>S2);
	U5:or_n_bit 
	generic map(N=>3)
	port map(I(0)=>S0,I(1)=>S1,I(2)=>S2,Y=>cout);
end struct;


















