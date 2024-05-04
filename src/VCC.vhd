library ieee;
use ieee.std_logic_1164.all;

entity my_vcc is
	port(
		out_vcc:out std_logic
	);
end my_vcc;

architecture behave of my_vcc is
begin
	out_vcc<='1';
end behave;