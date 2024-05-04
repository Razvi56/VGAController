library ieee;
use ieee.std_logic_1164.all;

entity proiect_finalizat is
	port(
		Switch:in std_logic_vector(7 downto 0);
		Buttons:in std_logic_vector(3 downto 0);
		nclk,clr,PL:in std_logic;
		R,G,B:out std_logic_vector(3 downto 0);
		HSync,VSync:inout std_logic
	);
end proiect_finalizat;

architecture struct of proiect_finalizat is

component selector_forma is
	port(
		I:in std_logic_vector(3 downto 0);
		clk,set,rst:in std_logic;
		SH:out std_logic_vector(3 downto 0)
	);	
end component selector_forma;

component decizie_directie is
	port(
	buttons:in std_logic_vector(3 downto 0);
	--buttons(3)-up
	--buttons(2)-right
	--buttons(1)-down
	--buttons(0)-left
	dir_x,dir_y:out std_logic_vector(1 downto 0)
	);
end component decizie_directie;

component counter_pozitie is
	port(
		En:in std_logic;
		CLK,RST,SET,PL:in std_logic;
		dir_X,dir_Y:in std_logic_vector(1 downto 0); 
		CX,CY:out std_logic_vector(9 downto 0)
	);
end component counter_pozitie;

component controller_efectiv is
	port (
		C,SH:in std_logic_vector(3 downto 0);
		set,rst,clk:in std_logic;
		CX,CY:in std_logic_vector(9 downto 0);
		Hsync,Vsync:inout std_logic;
		R,G,B:out std_logic_vector(3 downto 0);
		En_pos_count:inout std_logic;
		X_sig,Y_sig:out std_logic_vector(9 downto 0)
	);
end component controller_efectiv;

component selector_culoare is
	port(
		I:in std_logic_vector(3 downto 0);
		clk,set,rst:in std_logic;
		C:out std_logic_vector(3 downto 0)
	);	
end component selector_culoare;

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component divizor_frecventa is
	port( 
		clr:in std_logic;
		NCLK:in std_logic;
		CLK:inout std_logic
	);
end component divizor_frecventa; 

signal zero_1:std_logic;
signal C:std_logic_vector(3 downto 0);
signal SH:std_logic_vector(3 downto 0);
signal dir_x:std_logic_vector(1 downto 0);
signal dir_y:std_logic_vector(1 downto 0);
signal En_pos_count:std_logic;
signal En_count:std_logic;	
signal CX:std_logic_vector(9 downto 0);
signal CY:std_logic_vector(9 downto 0);
signal clk:std_logic;
signal x_sig:std_logic_vector(9 downto 0);
signal y_sig:std_logic_vector(9 downto 0);
begin
	U_gnd:entity work.my_gnd(behave)
	port map(zero_1);
	
	U1:selector_culoare
	port map(Switch(7 downto 4),clk,zero_1,clr,C);
	U2:selector_forma
	port map(Switch(3 downto 0),clk,zero_1,clr,SH);
	U3:decizie_directie
	port map(Buttons,dir_x,dir_y);
	U_en_pos:and_n_bit
	generic map(N=>2)
	port map(I(0)=>En_pos_count,I(1)=>clk,Y=>En_count);
	U4:counter_pozitie
	port map(En_count,clk,clr,zero_1,PL,dir_x,dir_y,CX,CY);	
	---
	--entity controller_efectiv is
--	port (
--		C,SH:in std_logic_vector(3 downto 0);
--		set,rst,clk:in std_logic;
--		CX,CY:in std_logic_vector(9 downto 0);
--		Hsync,Vsync:inout std_logic;
--		R,G,B:out std_logic_vector(3 downto 0);
--		En_pos_count:inout std_logic;
--		X_sig,Y_sig:out std_logic_vector(9 downto 0)
--	);
--end controller_efectiv;	
	---
	U5:controller_efectiv
	port map(C,SH,zero_1,clr,clk,CX,CY,HSync,VSync,R,G,B,En_pos_count,x_sig,Y_sig);
	---divizor frecventa
	U_divizor_frecventa:divizor_frecventa
	port map(clr,NCLK,clk);
end struct;











