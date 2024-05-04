library ieee;
use ieee.std_logic_1164.all;

entity divizor_frecventa is
	port( 
		clr:in std_logic;
		NCLK:in std_logic;
		CLK:inout std_logic
	);
end divizor_frecventa; 

architecture struct of divizor_frecventa is	

component J_K_falling_edge_flip_flop is
	port(
		J,K,S,R,CLK:in std_logic;
		Q,nonQ:inout std_logic
	);
end component J_K_falling_edge_flip_flop;

signal S:std_logic_vector(1 downto 0);
signal zero_1:std_logic;
begin
	U_gnd:entity work.my_gnd(behave)
	port map(zero_1);
	U_vcc:entity work.my_vcc(behave)
	port map(S(0));	
	U0:j_k_falling_edge_flip_flop
	port map(S(0),S(0),zero_1,clr,NCLK,S(1),open);
	U1:j_k_falling_edge_flip_flop
	port map(S(1),S(1),zero_1,clr,NCLK,clk,open);
	
end struct;







