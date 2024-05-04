 library ieee;
use ieee.std_logic_1164.all;

entity inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end inv_simple;

architecture data_flux of inv_simple is
begin
	Y0<= not I0;
end data_flux;