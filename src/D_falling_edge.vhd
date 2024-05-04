library ieee;
use ieee.std_logic_1164.all;

entity d_falling_edge_flip_flop is
	port(
		D,S,R,CLK:in std_logic;	
		Q,nonQ:inout std_logic
	);
end d_falling_edge_flip_flop;

architecture behave of d_falling_edge_flip_flop is
begin
	proc_d:process(CLK,S,R)
	begin
		if s='1' then
		   Q<='1';
		   nonQ<='0';
		elsif r='1' then
			Q<='0';
			nonQ<='1';
		elsif clk='0' and clk'event then
			Q<=D;
			nonQ<=not D;
		end if;
	end process proc_d;
end behave;	









