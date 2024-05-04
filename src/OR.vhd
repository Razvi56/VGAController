library ieee;
use ieee.std_logic_1164.all;

entity or_2_bit is
	port(
		I0,I1:in std_logic;
		Y0:out std_logic
	);
end or_2_bit;

architecture data_flux of or_2_bit is
begin
	Y0<=I0 or I1; 
end data_flux;	 

library ieee;
use ieee.std_logic_1164.all;

entity or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end or_n_bit;

architecture struct of or_n_bit is
 component or_2_bit is
	port(
		I0,I1:in std_logic;
		Y0:out std_logic
	);
end component or_2_bit;

signal S: std_logic_vector(N-1 downto 0);
begin
	S(0)<= I(0);
	generate_or_n: for k in 0 to N-2 generate
					U2: or_2_bit port map(S(k),I(k+1),S(k+1));
				end generate generate_or_n;
	Y<= S(N-1);
end struct;






