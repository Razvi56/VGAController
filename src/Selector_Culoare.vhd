library ieee;
use ieee.std_logic_1164.all;

entity selector_culoare is
	port(
		I:in std_logic_vector(3 downto 0);
		clk,set,rst:in std_logic;
		C:out std_logic_vector(3 downto 0)
	);	
end selector_culoare;

architecture struct of selector_culoare is

component color_select is
	port(
		B:in std_logic_vector(3 downto 0);
		SET,RST,clk:in std_logic;
		Out_v:out std_logic_vector(3 downto 0)
	);
	
end component color_select;

begin
	U0: color_select
	port map(I,set,rst,clk,C);
end struct;
















