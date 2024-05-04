library ieee;
use ieee.std_logic_1164.all;

entity DEC_to_BCD is
	port(
		I:in std_logic_vector(3 downto 0);
		Out_v:out std_logic_vector(1 downto 0)
	);
end DEC_to_BCD;	

architecture struct of DEC_to_BCD is

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

signal R: std_logic_vector(2 downto 0);--3 intrari apar inversate
--R(0)<=not I(0)
--R(1)<=not I(1)
--R(2)<=not I(2)
signal S: std_logic_vector(3 downto 0);
begin
	generate_inv_BCD:
	for k in 0 to 2 generate
		U_inv_BCD:inv_simple
		port map(I(k),R(k));
	end generate generate_inv_BCD;
	U0:and_n_bit
	generic map(N=>3)
	port map(I(0)=>I(2),I(1)=>R(1),I(2)=>R(0),Y=>S(0));
	U1:and_n_bit
	generic map(N=>4)
	port map(I(0)=>I(3),I(1)=>R(2),I(2)=>R(1),I(3)=>R(0),Y=>S(1));
	U2:and_n_bit
	generic map(N=>2)
	port map(I(0)=>I(1),I(1)=>R(0),Y=>S(2));
	U3:and_n_bit
	generic map(N=>4)
	port map(I(0)=>I(3),I(1)=>R(2),I(2)=>R(1),I(3)=>R(0),Y=>S(3));
	U4:or_n_bit
	generic map(N=>2)
	port map(I(0)=>S(0),I(1)=>S(1),Y=>Out_v(1));
	U5:or_n_bit
	generic map(N=>2)
	port map(I(0)=>S(2),I(1)=>S(3),Y=>Out_v(0));
end struct;










