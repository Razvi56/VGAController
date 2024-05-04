

library ieee;
use ieee.std_logic_1164.all;

entity shape_generator is
	port(
		clk,clr:in std_logic;
		X,Y:in std_logic_vector(9 downto 0);
		CX,CY:in std_logic_vector(9 downto 0);
		C,SH:in std_logic_vector(1 downto 0);
		RED,GREEN,BLUE:out std_logic_vector(3 downto 0)
	);
end shape_generator;

architecture struct of shape_generator is

signal a_jos:std_logic_vector(10 downto 0);
signal b_jos:std_logic_vector(10 downto 0);
signal a_sus:std_logic_vector(10 downto 0);
signal b_sus:std_logic_vector(10 downto 0);
signal sig_slice:std_logic_vector(639 downto 0);--U9
signal curr_bit_sig:std_logic;--U15
signal curr_bit_in_shape:std_logic;--U15
signal RGB_selected_color:std_logic_vector(11 downto 0);
signal zero_384:std_logic_vector(383 downto 0);
signal X_m:std_logic_vector(10 downto 0);
signal Y_m:std_logic_vector(10 downto 0);
signal R:std_logic_vector(2 downto 0);
	

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

component mux_2_n_1 is
	generic(N:natural);
	port(
		I:in std_logic_vector(2**N-1 downto 0);
		S:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component mux_2_n_1;


component sum_sub_n_bit is
	generic(N:natural);
	port(
	A,B:in std_logic_vector(N-1 downto 0);
	sel:in std_logic;
		S_D:out std_logic_vector(N-1 downto 0);
		cout_bout: out std_logic
	);
end component sum_sub_n_bit;

component f_comp_n_bit is
	generic(N:natural);
	port(
		A,B:in std_logic_vector(N-1 downto 0);
		F_sm,F_eq,F_gr:out std_logic
	);
end component f_comp_n_bit;

constant Not_really_Initial_pos_X:std_logic_vector(9 downto 0):="0101000000";
constant Not_really_Initial_pos_Y:std_logic_vector(9 downto 0):="0011110000";
signal zero_1:std_logic;
signal unu_1:std_logic;

signal RGB_alb:std_logic_vector(11 downto 0);
signal RGB_rosu:std_logic_vector(11 downto 0);
signal RGB_galben:std_logic_vector(11 downto 0);
signal RGB_albastru:std_logic_vector(11 downto 0);
signal RGB_verde:std_logic_vector(11 downto 0);
-------------------------------------------------Enable display
signal RGB_negru:std_logic_vector(11 downto 0);

constant HL:std_logic_vector(9 downto 0):="0010001111";
constant VL:std_logic_vector(9 downto 0):="0000100010";
constant HH:std_logic_vector(9 downto 0):="1010000000";
constant VH:std_logic_vector(9 downto 0):="0111100000";

signal comp_sig:std_logic_vector(3 downto 0);
signal EDS:std_logic;							
signal Final_color:std_logic_vector(11 downto 0); 
signal EDS_sync:std_logic;
-------------------------------------------------Enable display

begin
	---------------------------------------NEGRU
	generate_black_1:
	for k in 11 downto 0 generate
	   RGB_negru(k)<=zero_1;
	end generate generate_black_1;	
	--RGB_negru="000000000000"  
	---------------------------------------NEGRU
	
	---------------------------------------ALB
	generate_white_1:
	for k in 11 downto 0 generate
	   RGB_alb(k)<=unu_1;
	end generate generate_white_1;	
	--RGB_alb="111111111111"  
	---------------------------------------ALB
	
	---------------------------------------ROSU
	generate_red_1:
	for k in 11 downto 8 generate
		RGB_rosu(k)<=unu_1;
	end generate generate_red_1;
	
	generate_red_2:
	for k in 7 downto 0 generate
		RGB_rosu(k)<=zero_1;
	end generate generate_red_2;
	--RGB_rosu="111100000000"
	---------------------------------------ROSU 
	
	---------------------------------------GALBEN
	generate_yellow_1:
	for k in 11 downto 4 generate
		RGB_galben(k)<=unu_1;
	end generate generate_yellow_1;
	
	generate_yellow_2:
	for k in 3 downto 0 generate
		RGB_galben(k)<=zero_1;
	end generate generate_yellow_2;
	--RGB_galben="111111110000"
	---------------------------------------GALBEN
	
	---------------------------------------ALBASTRU
	generate_blue_1:
	for k in 11 downto 4 generate
		RGB_albastru(k)<=zero_1;
	end generate generate_blue_1;
	
	generate_blue_2:
	for k in 3 downto 0 generate
		RGB_albastru(k)<=unu_1;
	end generate generate_blue_2;
	--RGB_albastru="000000001111"
	---------------------------------------ALBASTRU
	
	---------------------------------------VERDE
	generate_green_1:
	for k in 11 downto 8 generate
		RGB_verde(k)<=zero_1;
	end generate generate_green_1;
	
	generate_green_2:
	for k in 7 downto 4 generate
		RGB_verde(k)<=unu_1;
	end generate generate_green_2;
	
	generate_green_3:
	for k in 3 downto 0 generate
		RGB_verde(k)<=zero_1;
	end generate generate_green_3;
	--RGB_verde="000011110000"
	---------------------------------------VERDE
	
	U_gnd0:entity work.my_gnd(behave)
	port map(zero_1);
	U_gnd1:entity work.my_vcc(behave)
	port map(unu_1);
	
	U1:sum_sub_n_bit
	generic map(N=>10)
	port map(Not_really_initial_pos_x,x,zero_1,S_D=>a_jos(9 downto 0),cout_bout=>a_jos(10));
	U3:sum_sub_n_bit
	generic map(N=>11)
	port map(A=>a_jos,B(9 downto 0)=>CX,B(10)=>zero_1,sel=>unu_1,S_D=>X_m,cout_bout=>R(0));
	U5:sum_sub_n_bit
	generic map(N=>10)
	port map(Not_really_initial_pos_y,y,zero_1,S_D=>a_sus(9 downto 0),cout_bout=>a_sus(10));
	U7:sum_sub_n_bit
	generic map(N=>11)
	port map(a_sus,B(9 downto 0)=>CY,B(10)=>zero_1,sel=>unu_1,S_D=>Y_m,cout_bout=>R(1));
	U12:nor_n_bit
	generic map(N=>5)
	port map(I(0)=>R(1),I(1)=>R(0),I(2)=>X_m(10),I(3)=>Y_m(10),I(4)=>Y_m(9),Y=>R(2));
	U9:entity work.memory_shape_selection(struct) 
	port map(Y_m(8 downto 0),SH,SIG_slice);
	U14:mux_2_n_1
	generic map(N=>10)
	port map(I(639 downto 0)=>SIG_slice,I(1023 downto 640)=>ZERO_384,S=>X_m(9 downto 0),Y=>curr_bit_sig);
	U15:mux_2_n_1
	generic map(N=>1)
	port map(I(0)=>R(2),I(1)=>curr_bit_sig,S(0)=>R(2),Y=>curr_bit_in_shape);
	U16:entity work.mux_2_1_bus_12(struct)
	port map(I(0)=>RGB_alb,I(1)=>RGB_selected_color,S(0)=>curr_bit_in_shape,Y=>Final_color);
	U17:entity work.mux_4_1_bus_12(struct)
	port map(I(0)=>RGB_rosu,I(1)=>RGB_galben,I(2)=>RGB_albastru,I(3)=>RGB_verde,S=>C,Y=>RGB_selected_color);
	generate_zero_shape:
	for k in 0 to 383 generate
		 zero_384(k)<=zero_1;
	end generate generate_zero_shape;
	
	-------------------------------------------------Enable display
	--U_test_0:f_comp_n_bit
--	generic map(N=>10)
--	port map(x,HL,open,open,comp_sig(0));
	U_test_1:f_comp_n_bit
	generic map(N=>10)
	port map(x,HH,comp_sig(1),open,open);
--	U_test_2:f_comp_n_bit
--	generic map(N=>10)
--	port map(y,VL,open,open,comp_sig(2));
	U_test_3:f_comp_n_bit
	generic map(N=>10)
	port map(y,VH,comp_sig(3),open,open);
	U_and_0:and_n_bit
	generic map(N=>2) 
	port map(I(0)=>comp_sig(1),I(1)=>comp_sig(3),Y=>EDS);
	U_d:entity work.d_falling_edge_flip_flop
	port map(D=>EDS,S=>zero_1,r=>clr,clk=>clk,Q=>eds_sync,nonQ=>open);	
	U_mux_0:entity work.mux_2_1_bus_12(struct)
	port map(I(0)=>RGB_negru,I(1)=>Final_color,S(0)=>EDS_sync,Y(11 downto 8)=>RED,Y(7 downto 4)=>GREEN,Y(3 downto 0)=>BLUE);	
	-------------------------------------------------Enable display
		
		
end struct;












