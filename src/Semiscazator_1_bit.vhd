library ieee;
use ieee.std_logic_1164.all;

entity semiscazator_1_bit is
	port(
		a,b:in std_logic;
		d,bout:out std_logic
	);
end semiscazator_1_bit;

architecture struct of semiscazator_1_bit is

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component xor_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component xor_n_bit;

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

signal S0:std_logic;
begin
	U0: xor_n_bit
	generic map(N=>2)
	port map(I(0)=>a,I(1)=>b,Y=>d);
	U1:inv_simple
	port map(a,S0);
	U2: and_n_bit
	generic map(N=>2)
	port map(I(0)=>b,I(1)=>S0,Y=>bout);
end struct;









