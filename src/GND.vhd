library ieee;
use ieee.std_logic_1164.all;

entity my_gnd is
	port(
		out_gnd:out std_logic
	);
end my_gnd;

architecture behave of my_gnd is
begin
	out_gnd<='0';
end behave;