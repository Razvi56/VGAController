library ieee;
use ieee.std_logic_1164.all;

entity sync_unit is
	port(
		CLK,SET,RST:in std_logic;
		HSYNC,VSYNC:inout std_logic;
		X_pos,Y_pos:out std_logic_vector(9 downto 0);
		En_pos_count:inout std_logic
	);
end sync_unit;	

architecture struct of sync_unit is


component and_n_bit is
	generic(N:natural);
	port(
		I:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component and_n_bit;

signal S:std_logic;
--signal en_pos_sig:std_logic;

begin
--	U_and_pos_en:and_n_bit
--	generic map(N=>2)
--	port map(I(0)=>S,I(1)=>en_pos_sig,Y=>open);
	U_last_0:entity work.VGAdrive
	port map(rst,clk,y_pos,x_pos,HSync,Vsync,En_pos_count);	
end struct;




















