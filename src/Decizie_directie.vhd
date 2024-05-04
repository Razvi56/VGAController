library ieee;
use ieee.std_logic_1164.all;

entity decizie_directie is
	port(
	buttons:in std_logic_vector(3 downto 0);
	--buttons(3)-up
	--buttons(2)-right
	--buttons(1)-down
	--buttons(0)-left
	dir_x,dir_y:out std_logic_vector(1 downto 0)
	);
end decizie_directie;

architecture struct of decizie_directie is

component semiscazator_1_bit is
	port(
		a,b:in std_logic;
		d,bout:out std_logic
	);
end component semiscazator_1_bit;

begin
	U0:semiscazator_1_bit
	port map(buttons(3),buttons(1),dir_y(0),dir_y(1));
	U1:semiscazator_1_bit
	port map(buttons(2),buttons(0),dir_x(0),dir_x(1));
end struct;


