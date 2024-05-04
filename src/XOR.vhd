library ieee;
use ieee.std_logic_1164.all;

entity xor_2_bit is
	port(
		I0,I1:in std_logic;
		Y:out std_logic
	);
end xor_2_bit;

architecture data_flux of xor_2_bit is
begin
	Y<= I0 xor I1;
end data_flux;

library ieee;
use ieee.std_logic_1164.all;

entity xor_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end xor_n_bit;

architecture struct of xor_n_bit is
component xor_2_bit is
	port(
		I0,I1:in std_logic;
		Y:out std_logic
	);
end component xor_2_bit;

signal S: std_logic_vector(N-1 downto 0);
begin 
	S(0)<= I(0);
	generate_xor_n: for k in 0 to N-2 generate
						U_xor_2: xor_2_bit port map(S(k),I(k+1),S(k+1));
					end generate generate_xor_n;
	Y<=S(N-1);
end struct;







