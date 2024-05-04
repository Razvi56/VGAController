library ieee;
use ieee.std_logic_1164.all;

entity sum_sub_n_bit is
	generic(N:natural);
	port(
	A,B:in std_logic_vector(N-1 downto 0);
	sel:in std_logic;
		S_D:out std_logic_vector(N-1 downto 0);
		cout_bout: out std_logic
	);
end sum_sub_n_bit;

architecture struct of sum_sub_n_bit is

  
   component f_sum_1_bit is
	port(
		A,B,cin:in std_logic;
		S,cout:out std_logic
	);
   end component f_sum_1_bit;
   
   component xor_n_bit is
	generic(N:natural);
	port(
		I: in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component xor_n_bit;

   signal R0:std_logic_vector(N-1 downto 0);
   signal R1:std_logic_vector(N downto 0);
begin 	
	R1(0)<= sel;
	generate_sum_sub:
	for k in 0 to N-1 generate
		U_sum_sub: f_sum_1_bit
		port map(A(k),R0(k),R1(k),S_D(k),R1(k+1));
		U_xor_sum_sub: xor_n_bit
		generic map(N=>2)
		port map(I(0)=>sel,I(1)=>B(k),Y=>R0(k));
	end generate generate_sum_sub;
	U_aux:xor_n_bit
	generic map(N=>2)
	port map(I(0)=>R1(N),I(1)=>sel,Y=>cout_bout);
end struct;  











