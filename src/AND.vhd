library ieee;
use ieee.std_logic_1164.all;

entity and_2_bit is
	port(
		I0,I1:in std_logic;
		Y0:out std_logic
	);
end and_2_bit;

architecture data_flux of and_2_bit is 
begin
	 Y0<= I0 and I1;
end data_flux;

library ieee;
use ieee.std_logic_1164.all;

entity and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end and_n_bit;

architecture data_flux of and_n_bit is
component and_2_bit is
	port(
		I0,I1:in std_logic;
		Y0:out std_logic
	);
end component and_2_bit;  

signal S: std_logic_vector(N-1 downto 0);
begin
	S(0)<=I(0);
	generate_and_n: for k in 0 to N-2 generate
					U1: and_2_bit port map(S(k),I(k+1),S(k+1));
				end generate generate_and_n;
	Y<=S(N-1);
end data_flux;	


