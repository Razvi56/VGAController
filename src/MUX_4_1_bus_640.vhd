library ieee;
use ieee.std_logic_1164.all;
	

package pachet_dimensiuni_intrari_mux_3 is
	constant N:natural:=2;-- vor fi 2^N intrari multiplexate
	constant M:natural:=640;-- M biti pe calea de date
	type intrare is array (2**N-1 downto 0) of std_logic_vector(M-1 downto 0);
	type aux_intrare is array (M-1 downto 0) of std_logic_vector(2**N-1 downto 0);
end pachet_dimensiuni_intrari_mux_3;	

library ieee;
use ieee.std_logic_1164.all; 
use work.pachet_dimensiuni_intrari_mux_3.all;

entity mux_4_1_bus_640 is
	port(
		I:in intrare;
		S:in std_logic_vector(N-1 downto 0);
		Y:out std_logic_vector(M-1 downto 0)
	);
end mux_4_1_bus_640;

architecture struct of mux_4_1_bus_640 is

component mux_2_n_1 is
	generic(N:natural);
	port(
		I:in std_logic_vector(2**N-1 downto 0);
		S:in std_logic_vector(N-1 downto 0);
		Y:out std_logic
	);
end component mux_2_n_1;


signal R:aux_intrare;

begin
	generate_generic_mux:
	for k in 0 to M-1 generate
		U_generic_mux_12: mux_2_n_1
		generic map(N=>N)
		port map(R(k),S,Y(k));
		generate_signals:
		for m in 0 to 2**N-1 generate
			R(k)(m)<= I(m)(k);
		end generate generate_signals;	
	end generate generate_generic_mux;	
end struct;













