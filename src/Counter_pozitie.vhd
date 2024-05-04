library ieee;
use ieee.std_logic_1164.all;

entity counter_pozitie is
	port(
		En:in std_logic;
		CLK,RST,SET,PL:in std_logic;
		dir_X,dir_Y:in std_logic_vector(1 downto 0); 
		CX,CY:out std_logic_vector(9 downto 0)
	);
end counter_pozitie;

architecture struct of counter_pozitie is

component counter_x is
	port(
		En:in std_logic;
		dir_x:in std_logic_vector(1 downto 0);
		clk:in std_logic;
		rst,set,PL:in std_logic;
		Q:out std_logic_vector(9 downto 0)
	);
end component counter_x;

component counter_Y is
	port(
		En:in std_logic;
		dir_Y:in std_logic_vector(1 downto 0);
		clk:in std_logic;
		rst,set,PL:in std_logic;
		Q:out std_logic_vector(9 downto 0)
	);
end component counter_Y;

begin
	U0:counter_x port map(En,dir_x,clk,rst,set,PL,CX);
	U1:counter_y port map(En,dir_Y,clk,rst,set,PL,CY);
end struct;	









