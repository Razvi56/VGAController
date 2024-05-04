library ieee;
use ieee.std_logic_1164.all;

entity controller_efectiv is
	port (
		C,SH:in std_logic_vector(3 downto 0);
		set,rst,clk:in std_logic;
		CX,CY:in std_logic_vector(9 downto 0);
		Hsync,Vsync:inout std_logic;
		R,G,B:out std_logic_vector(3 downto 0);
		En_pos_count:inout std_logic;
		X_sig,Y_sig:out std_logic_vector(9 downto 0)
	);
end controller_efectiv;	

architecture struct of controller_efectiv is

component DEC_to_BCD is
	port(
		I:in std_logic_vector(3 downto 0);
		Out_v:out std_logic_vector(1 downto 0)
	);
end component DEC_to_BCD;


component shape_generator is
	port(
		clk,clr:in std_logic;
		X,Y:in std_logic_vector(9 downto 0);
		CX,CY:in std_logic_vector(9 downto 0);
		C,SH:in std_logic_vector(1 downto 0);
		RED,GREEN,BLUE:out std_logic_vector(3 downto 0)
	);
end component shape_generator;

signal real_C:std_logic_vector(1 downto 0);
signal real_SH:std_logic_vector(1 downto 0);
signal X_pos:std_logic_vector(9 downto 0);
signal Y_pos:std_logic_vector(9 downto 0);

begin
	U0:dec_to_bcd
	port map(C,real_C);
	U1:dec_to_bcd
	port map(SH,real_SH);
	U2:entity work.sync_unit
	port map(clk,set,rst,Hsync,Vsync,X_pos,Y_pos,En_pos_count);
	U3:shape_generator
	port map(clk,rst,X_pos,Y_pos,CX,CY,real_C,real_SH,R,G,B);
	X_sig<=X_pos;
	Y_sig<=Y_pos;
end struct;	  


















