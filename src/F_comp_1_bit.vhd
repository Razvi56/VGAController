library ieee;
use ieee.std_logic_1164.all;

entity f_comp_1_bit is
	port(
		P_sm,P_eq,P_gr,A,B:in std_logic;
		F_sm,F_eq,F_gr:out std_logic
	);
end f_comp_1_bit;

architecture struct of f_comp_1_bit is

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

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
signal S3: std_logic;
signal S4: std_logic;
begin 
	U1: inv_simple
	port map(A,S0);
	U2: and_n_bit
	generic map(N=>3)
	port map(I(0)=>S0,I(1)=>B,I(2)=>P_eq,Y=>S1);
	U3: nxor_n_bit
	generic map(N=>2)
	port map(I(0)=>A,I(1)=>B,Y=>S2);
	U4:inv_simple
	port map(B,S4);
	U5:and_n_bit
	generic map(N=>3)
	port map(I(0)=>P_eq,I(1)=>A,I(2)=>S4,Y=>S3); 
	U6: or_n_bit
	generic map(N=>2)
	port map(I(0)=>P_sm,I(1)=>S1,Y=>F_sm);
	U7: and_n_bit
	generic map(N=>2)
	port map(I(0)=>P_eq,I(1)=>S2,Y=>F_eq);
	U8: or_n_bit
	generic map(N=>2)
	port map(I(0)=>P_gr,I(1)=>S3,Y=>F_gr);
end struct;























