library ieee;
use ieee.std_logic_1164.all;

entity color_select is
	port(
		B:in std_logic_vector(3 downto 0);
		SET,RST,clk:in std_logic;
		Out_v:out std_logic_vector(3 downto 0)
	);
	
end color_select; 

architecture arh_struct of color_select is

component d_falling_edge_flip_flop is
	port(
		D,S,R,CLK:in std_logic;	
		Q,nonQ:inout std_logic
	);
end component d_falling_edge_flip_flop;

component mux_2_n_1 is
	generic(N:natural);
	port(
		I:in std_logic_vector(2**N-1 downto 0);
		S:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component mux_2_n_1; 

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

component or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component or_n_bit;

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;


signal Z:std_logic_vector(1 downto 0);
signal O:std_logic;
signal S:std_logic;
signal M1:std_logic;
signal M0:std_logic;
signal cond:std_logic;
signal P:std_logic;
signal G:std_logic;
signal H:std_logic;
signal I:std_logic;
signal A:std_logic_vector(3 downto 0);
signal R1:std_logic;
signal R2:std_logic;
signal R3:std_logic;
signal N1:std_logic;
signal N26:std_logic;
signal N27:std_logic;
signal N28:std_logic;
signal N29:std_logic; 
signal N15:std_logic;
signal N17:std_logic; 
signal N19:std_logic;
signal N30:std_logic;
signal N31:std_logic;
signal N32:std_logic;
signal N33:std_logic;
signal N34:std_logic;
signal N35:std_logic;
signal N36:std_logic;
signal N37:std_logic;

begin
	U1:mux_2_n_1
	generic map(N=>2)
	port map(B,Z,O);
	U2:and_n_bit
	generic map(N=>2)
	port map(I(0)=>O,I(1)=>S,Y=>cond);
	U3:mux_2_N_1
	generic map(N=>1)
	port map(I(0)=>M1,I(1)=>Z(0),S(0)=>cond,Y=>P);	  
	U4:d_falling_edge_flip_flop
	port map(P,set,rst,clk,Z(0),open);
	U5:mux_2_n_1
	generic map(N=>1)
	port map(I(0)=>M0,I(1)=>Z(1),S(0)=>cond,Y=>G);
	U6:d_falling_edge_flip_flop
	port map(G,set,rst,clk,Z(1),open);
	U7:inv_simple
	port map(N1,H);
	U8:d_falling_edge_flip_flop
	port map(H,set,rst,clk,S,open);
	U9:or_n_bit
	generic map(N=>4)
	port map(B,I);
	U10:inv_simple
	port map(I,N1);
	U11:inv_simple
	port map(B(0),N15);
	U12:and_n_bit
	generic map(N=>2)
	port map(I(0)=>N15,I(1)=>B(1),Y=>R1);
	U13:inv_simple
	port map(B(1),N17);
	U14:and_n_bit
	generic map(N=>3)
	port map(I(0)=>N15,I(1)=>N17,I(2)=>B(2),Y=>R2);
	U15:inv_simple
	port map(B(2),N19);
	U16:and_n_bit
	generic map(N=>4)
	port map(I(0)=>N15,I(1)=>N17,I(2)=>N19,I(3)=>B(3),Y=>R3);
	U17:or_n_bit
	generic map(N=>2)
	port map(I(0)=>R2,I(1)=>R3,Y=>M0);
	U18:or_n_bit
	generic map(N=>2)
	port map(I(0)=>R1,I(1)=>R3,Y=>M1);
	U19:mux_2_n_1
	generic map(N=>1)
	port map(I(0)=>B(0),I(1)=>A(0),S(0)=>N30,Y=>N34);
	U20:mux_2_n_1
	generic map(N=>1)
	port map(I(0)=>R1,I(1)=>A(1),S(0)=>N31,Y=>N35);
	U21:mux_2_n_1
	generic map(N=>1)
	port map(I(0)=>R2,I(1)=>A(2),S(0)=>N32,Y=>N36);
	U22:mux_2_n_1
	generic map(N=>1)
	port map(I(0)=>R3,I(1)=>A(3),S(0)=>N33,Y=>N37);
	U23:or_n_bit
	generic map(N=>2)
	port map(I(0)=>cond,I(1)=>N1,Y=>N30);
	U24:or_n_bit
	generic map(N=>2)
	port map(I(0)=>cond,I(1)=>N1,Y=>N31);
	U25:or_n_bit
	generic map(N=>2)
	port map(I(0)=>cond,I(1)=>N1,Y=>N32);
	U26:or_n_bit
	generic map(N=>2)
	port map(I(0)=>cond,I(1)=>N1,Y=>N33);
	U31:d_falling_edge_flip_flop
	port map(N34,set,rst,clk,A(0),open);
	U32:d_falling_edge_flip_flop
	port map(N35,set,rst,clk,A(1),open);
	U33:d_falling_edge_flip_flop
	port map(N36,set,rst,clk,A(2),open);
	U34:d_falling_edge_flip_flop
	port map(N37,set,rst,clk,A(3),open);
	out_v<=A;
end arh_struct;