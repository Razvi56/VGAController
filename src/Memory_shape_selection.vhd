
library ieee;
use ieee.std_logic_1164.all; 

entity memory_shape_selection is
	port(
		ADR_Y:in std_logic_vector(8 downto 0);
		SH:in std_logic_vector(1 downto 0);
		X_slice: out std_logic_vector(639 downto 0)
	);
end memory_shape_selection;

architecture struct of memory_shape_selection is

signal S0:std_logic_vector(639 downto 0);
signal S1:std_logic_vector(639 downto 0);
signal S2:std_logic_vector(639 downto 0);
signal S3:std_logic_vector(639 downto 0);
signal ZERO:std_logic_vector(8 downto 0);


begin
	U0:entity work.ROM_SQUARE_480x640(behave)
	port map(ADR_Y,S0);
	U1:entity work.ROM_CIRCLE_480x640(behave)
	port map(ADR_Y,S1);
	U2:entity work.ROM_TRIANGLE_480x640(behave)
	port map(ADR_Y,S2);
	U3:entity work.ROM_PLUS_480x640(behave)
	port map(ADR_Y,S3);
	U4:entity work.mux_4_1_bus_640(struct)
	port map(I(0)=>S0,I(1)=>S1,I(2)=>S2,I(3)=>S3,S=>SH,Y=>X_slice);
	
end struct;	















