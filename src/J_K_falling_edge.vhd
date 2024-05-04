library ieee;
use ieee.std_logic_1164.all;

entity J_K_falling_edge_flip_flop is
	port(
		J,K,S,R,CLK:in std_logic;
		Q,nonQ:inout std_logic
	);
end J_K_falling_edge_flip_flop;	

architecture behave of J_K_falling_edge_flip_flop is
begin
	proc_j_k:process(clk,s,r)
	begin
		if s='1' then
			Q<='1';
			nonQ<='0';
		elsif r='1' then
			Q<='0';
			nonQ<='1';
		elsif clk'event and clk='0' then
			if j='0' and k='0' then
				Q<=Q;
				nonQ<=nonQ;
			elsif j='0' and k='1' then
				Q<='0';
				nonQ<='1';
			elsif j='1' and k='0' then
				Q<='1';
				nonQ<='0';
			else
				Q<= not Q;
				nonQ<=not nonQ;
			end if;	
		end if;
	end process proc_j_k;
end behave;	

--architecture arh_struct_master_slave of J_K_falling_edge_flip_flop is
--
--component nand_n_bit is
--	generic(N:natural);
--	port(
--		I: in std_logic_vector(N-1 downto 0);
--		Y:out std_logic
--	);
--end component nand_n_bit;
--
--component inv_simple is
--	port(
--		I0:in std_logic;
--		Y0:out std_logic
--	);	
--end component inv_simple; 
--
--signal N1:std_logic;
--signal N2:std_logic;
--signal N3:std_logic;
--signal N4:std_logic;
--signal N5:std_logic;
--signal N6:std_logic;
--signal N7:std_logic;
--signal N8:std_logic;
--signal N9:std_logic;
--signal N11:std_logic;
--signal N12:std_logic;
--begin
--	U1:nand_n_bit
--	generic map(N=> 3)
--	port map(I(0)=>N1,I(1)=>J,I(2)=>clk,Y=>N3);
--	U2:nand_n_bit
--	generic map(N=> 3)
--	port map(I(0)=>clk,I(1)=>K,I(2)=>N2,Y=>N4);
--	U3:nand_n_bit
--	generic map(N=> 3)
--	port map(I(0)=>N5,I(1)=>N3,I(2)=>N8,Y=>N7);
--	U4:nand_n_bit
--	generic map(N=> 3)
--	port map(I(0)=>N7,I(1)=>N4,I(2)=>N6,Y=>N8);
--	U5:nand_n_bit
--	generic map(N=> 2)
--	port map(I(0)=>N7,I(1)=>N9,Y=>N11);
--	U6:nand_n_bit
--	generic map(N=> 2)
--	port map(I(0)=>N9,I(1)=>N8,Y=>N12);
--	U7:nand_n_bit
--	generic map(N=> 3)
--	port map(I(0)=>N5,I(1)=>N11,I(2)=>N1,Y=>N2);
--	U8:nand_n_bit
--	generic map(N=> 3)
--	port map(I(0)=>N2,I(1)=>N12,I(2)=>N6,Y=>N1);
--	U9:inv_simple
--	port map(S,N5);
--	U10:inv_simple
--	port map(R,N6);
--	U11:inv_simple
--	port map(clk,N9);
--	Q<=N2;
--	nonQ<=N1;
--end arh_struct_master_slave;





