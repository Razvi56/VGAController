library ieee;
use ieee.std_logic_1164.all;

entity counter_x is
	port(
		En:in std_logic;
		dir_x:in std_logic_vector(1 downto 0);
		clk:in std_logic;
		rst,set,PL:in std_logic;
		Q:out std_logic_vector(9 downto 0)
	);
end counter_x;

architecture struct of counter_X is

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component or_n_bit;

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

component counter_N_bit is
	generic(N:natural);
	port(
		CLK:in std_logic; 
		RST:in std_logic;
		SET:in std_logic;
		En:in std_logic;
		PL:in std_logic;
		DIR:in std_logic;
		UP_limit:in std_logic_vector(N-1 downto 0);
		DOWN_limit:in std_logic_vector(N-1 downto 0);
		D:in std_logic_vector(N-1 downto 0);
		Q:out std_logic_vector(N-1 downto 0);
		UP_signal:out std_logic;
		DOWN_signal:out std_logic
	);
end component counter_N_bit;

signal S:std_logic_vector(10 downto 0); 
constant down_edge:std_logic_vector(9 downto 0):="0000110010";
constant up_edge:std_logic_vector(9 downto 0):="1001001110";
constant initial_pos:std_logic_vector(9 downto 0):="0101000000";
begin
	U0:inv_simple--
	port map(dir_x(1),S(9));--
	U1:counter_n_bit--
	generic map(N=>10)
	port map(CLK,RST,SET,S(10),PL,S(9),up_edge,down_edge,initial_pos,Q,S(1),S(0));--
	U8:or_n_bit
	generic map(N=>2)
	port map(I(0)=>S(6),I(1)=>PL,Y=>S(8));
	U7:and_n_bit--
	generic map(N=>2)
	port map(I(0)=>S(2),I(1)=>dir_x(1),Y=>S(4));
	U5:inv_simple--
	port map(dir_x(1),S(7));
	U2:and_n_bit--
	generic map(N=>3)
	port map(I(0)=>S(7),I(1)=>dir_x(0),I(2)=>S(3),Y=>S(5));
	U6:or_n_bit
	generic map(N=>2)
	port map(I(0)=>S(4),I(1)=>S(5),Y=>S(6));
	U3:inv_simple
	port map(S(1),S(3));
	U4:inv_simple
	port map(S(0),S(2));
	
	---------
	U_enable:and_n_bit
	generic map(N=>2)
	port map(I(0)=>S(8),I(1)=>En,Y=>S(10));
end struct;	





































