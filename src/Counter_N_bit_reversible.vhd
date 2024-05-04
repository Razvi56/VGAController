library ieee;
use ieee.std_logic_1164.all;

entity counter_N_bit is
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
end counter_N_bit;

architecture struct of counter_N_bit is

signal T:std_logic_vector(N-1 downto 0);
signal CI:std_logic_vector(N-2 downto 0);
signal A:std_logic_vector(N-1 downto 0);
signal R0:std_logic_vector(N-1 downto 0);
signal R1:std_logic_vector(N-2 downto 0);
signal R2:std_logic_vector(N-2 downto 0);
signal R3:std_logic_vector(N-3 downto 0);
signal R4:std_logic_vector(N-1 downto 0);
signal up:std_logic;
signal down:std_logic;
signal aux:std_logic;
signal NCLK:std_logic;

component nor_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component nor_n_bit;

component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

component inv_simple is
	port(
		I0:in std_logic;
		Y0:out std_logic
	);	
end component inv_simple;

component xor_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component xor_n_bit;

component MUX_2_1 is
	port(
		I0,I1:in std_logic;
		S:in std_logic;
		Y:out std_logic
	);
end component MUX_2_1;

component d_falling_edge_flip_flop is
	port(
		D,S,R,CLK:in std_logic;	
		Q,nonQ:inout std_logic
	);
end component d_falling_edge_flip_flop;

component f_comp_n_bit is
	generic(N:natural);--N>=2
	port(
		A,B:in std_logic_vector(N-1 downto 0);
		F_sm,F_eq,F_gr:out std_logic
	);
end component f_comp_n_bit;

component or_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y: out std_logic
	);
end component or_n_bit;
signal s_or:std_logic;

begin 
CI(0)<=A(0);
T(0)<=En;
U_load:or_n_bit
generic map(N=>2)
port map(I(0)=>En,I(1)=>PL,Y=>S_or);
U_first:and_n_bit
generic map(N=>2)
port map(I(0)=>S_or,I(1)=>CLK,Y=>NCLK);
generate_counter:
for k in 0 to N-3 generate
	U0: xor_n_bit
	generic map(N=>2)
	port map(I(0)=>T(k),I(1)=>A(k),Y=>R4(k));
	U1: MUX_2_1
	port map(R4(k),D(k),PL,R0(k));
	U2:d_falling_edge_flip_flop
	port map(R0(k),SET,RST,NCLK,A(k),open);
	U3:nor_n_bit
	generic map(N=>2)
	port map(I(0)=>CI(k),I(1)=>A(k),Y=>R1(k));
	U4:and_n_bit
	generic map(N=>2)
	port map(I(0)=>CI(k),I(1)=>A(k),Y=>R2(k));
	U5:inv_simple
	port map(R1(k),R3(k));
	U6:mux_2_1
	port map(R1(k),R2(k),DIR,T(k+1));
	U7:mux_2_1
	port map(R3(k),R2(k),DIR,CI(k+1));
end generate generate_counter;
--penultima->toate fara U5 si U7-- k=N-2
	P_U0: xor_n_bit
	generic map(N=>2)
	port map(I(0)=>T(N-2),I(1)=>A(N-2),Y=>R4(N-2));
	P_U1: MUX_2_1
	port map(R4(N-2),D(N-2),PL,R0(N-2));
	P_U2:d_falling_edge_flip_flop
	port map(R0(N-2),SET,RST,NCLK,A(N-2),open);
	P_U3:nor_n_bit
	generic map(N=>2)
	port map(I(0)=>CI(N-2),I(1)=>A(N-2),Y=>R1(N-2));
	P_U4:and_n_bit
	generic map(N=>2)
	port map(I(0)=>CI(N-2),I(1)=>A(N-2),Y=>R2(N-2));
	P_U6:mux_2_1
	port map(R1(N-2),R2(N-2),DIR,T(N-1));
	--ultima->doar U0,U1,U2--- k=N-1
	L_U0: xor_n_bit
	generic map(N=>2)
	port map(I(0)=>T(N-1),I(1)=>A(N-1),Y=>R4(N-1));
	L_U1: MUX_2_1
	port map(R4(N-1),D(N-1),PL,R0(N-1));
	L_U2:d_falling_edge_flip_flop
	port map(R0(N-1),SET,RST,NCLK,A(N-1),open);
	Q<=A;
	
	--Semnalizarea capetelor 
	C_U0:f_comp_n_bit
	generic map(N=>N)
	port map(A,up_limit,open,open,up);
	C_U01:and_n_bit
	generic map(N=>2)
	port map(I(0)=>up,I(1)=>DIR,Y=>up_signal);
	C_U1:f_comp_n_bit
	generic map(N=>N)
	port map(A,down_limit,down,open,open);
	C_U11:inv_simple
	port map(DIR,aux);
	C_U12:and_n_bit
	generic map(N=>2)
	port map(I(0)=>down,I(1)=>aux,Y=>down_signal);
end struct;





