Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--Spre intensa noastra dezamagire, in ciuda eforturilor de a elabora o arhitectura structurala pentru aceasta componenta,
--acestea au fost in zadar. Forma de unda era identica cu cea pe care o avem acum, insa comportamentul nu era cel asteptat. In consecinta,
-- venim cu aceasta banala arhitectura partial comportamentala pentru generarea Hsync si Vsync.
entity VGAdrive is
  port( clr,clock : in std_logic;  
        row, column : out std_logic_vector(9 downto 0); 
		 H, V : out std_logic;
		 En_pos:inout std_logic
	   ); 
end;

architecture behave of VGAdrive is
  constant PWH:natural:=96;-- lungimea pulsului HS
  constant BPH:natural:=48;--   back porch orizontala
  constant DTH:natural:=640; -- timp de display pe orizontala
  constant FPH:natural:=16;  -- front porch orizontala
  constant TH:natural:= PWH + BPH + DTH + FPH;  -- total orizontala 
  
  constant PWV:natural:=2;   -- lungimea pulsului VS
  constant BPV:natural:=32;  -- back porch verticala
  constant DTV:natural:=480; -- timp display verticala
  constant FPV:natural:=11;  -- front porch verticala
  constant TV:natural:= PWV + BPV + DTV + FPV;  -- total verticala
  
  signal En_pos_2:std_logic;
  signal En_pos_1:std_logic;
  signal row_sig:std_logic_vector(9 downto 0);
  signal col_sig:std_logic_vector(9 downto 0);
  constant up_row:std_logic_vector(9 downto 0):="1000001100"; 
  constant up_col:std_logic_vector(9 downto 0):="1100011111"; 
  signal En_pos_unsync:std_logic;
  signal zero_1:std_logic;
  signal unu_1:std_logic;
begin
 U_gnd:entity work.my_gnd
port map(zero_1);
U_vcc:entity work.my_vcc
port map(unu_1);	

  process
    variable vertical, horizontal : std_logic_vector(9 downto 0);
  begin
    wait until clock = '1';

      if  horizontal < TH - 1  then
        horizontal := horizontal + 1;
      else	  
        horizontal := (others => '0');

        if  vertical < TV - 1  then 
          vertical := vertical + 1;
        else
          vertical := (others => '0');    
        end if;
      end if;

      if  horizontal>=(DTH + FPH) and horizontal<(DTH+FPH+PWH)  then
        H <= '0';
      else
		H<='1';
      end if;

      if  vertical>= (DTV+FPV) and  vertical < (DTV+FPV+PWV)  then
        V <= '0';
      else
        V <= '1';
      end if;

    row <= vertical;
    column <= horizontal;
	row_sig <= vertical;
    col_sig <= horizontal;

  end process;
  --------------------------------------En_pos
  	U_comp_1:entity work.f_comp_n_bit
	generic map(N=>10)
	port map(row_sig,up_row,open,en_pos_1,open);
	 U_comp_2:entity work.f_comp_n_bit
	generic map(N=>10)
	port map(col_sig,up_col,open,en_pos_2,open);
	U_and:entity work.and_n_bit
	generic map(N=>2)
	port map(I(0)=>En_pos_1,I(1)=>En_pos_2,Y=>en_pos_unsync);
	U_sync:entity work.d_falling_edge_flip_flop
	port map(D=>En_pos_unsync,Q=>En_pos,R=>clr,S=>zero_1,clk=>clock);	
	--------------------------------------En_pos
	

end architecture;
				
