
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity adrgenUnit is
    Port ( clk	 		 : in STD_LOGIC;
		   reset	 	 : in STD_LOGIC;
		   I_clr_PtrLine : in STD_LOGIC;
		   I_inc_PtrLine : in STD_LOGIC;
		   I_clr_PtrCol  : in STD_LOGIC;
		   I_inc_PtrCol  : in STD_LOGIC;
		   I_selPix 	 : in STD_LOGIC_VECTOR (1 downto 0);
		   O_EndImage	 : out STD_LOGIC;
		   O_NewLine	 : out STD_LOGIC;
		   O_ADR_R		 : out STD_LOGIC_VECTOR (13 downto 0); -- La profondeur de la mémoire IN = 100x100 = 10000
		   O_ADR_W	 	 : out STD_LOGIC_VECTOR (13 downto 0)  -- La profondeur de la mémoire OUT = 100x100 = 10000   
		   ); 
end adrgenUnit;


architecture Behavioral of adrgenUnit is

-- déclaration des signaux internes
signal S_PtrLine : unsigned(6 downto 0):=(others => '0');
signal S_PtrCol : unsigned(6 downto 0):=(others => '0') ;
signal S_out_mux : unsigned(7 downto 0);
signal S_temp_out_adder : unsigned(13 downto 0);

begin
	
	--sequential process, a line counter from 0 to 98
	cnt_ptrline: process( clk, reset)
	begin
		if reset = '1' then
			S_PtrLine <= (others => '0');
		elsif (clk'event and clk='1') then
			if I_clr_PtrLine = '1' then
				S_PtrLine <= (others => '0');
			elsif I_inc_PtrLine = '1' then
--				if S_PtrLine =  to_unsigned(97,7) then 
			    if S_PtrLine =  98 then 
					S_PtrLine <= (others => '0');
				else
					S_PtrLine<= S_PtrLine + 1;
				end if;
			end if;
		end if;
	end process;

	--sequential process, a line counter from 0 to 99
	cnt_ptrcol: process ( clk, reset)
	begin
		if reset = '1' then
			S_PtrCol <= (others => '0');
		elsif (clk'event and clk='1') then
			if I_clr_PtrCol = '1' then
				S_PtrCol <= (others => '0');
			elsif I_inc_PtrCol = '1' then
			    if S_PtrCol =  99 then 
					S_PtrCol <= (others => '0');
				else
					S_PtrCol<= S_PtrCol + 1;
				end if;
			end if;
		end if;
	end process;
	
	-- Combinatorial process to determinate the output that it'll be add in the "O_adrR", a Mux
	mux_px: process(I_selPix)
	begin
		case I_selPix is
							    when "00" => S_out_mux <= to_unsigned(0,8)  ;
								when "01" => S_out_mux <= to_unsigned(100,8);
								when "10" => S_out_mux <= to_unsigned(200,8);
								when others => S_out_mux <= to_unsigned(0,8);
		end case;
	end process;
	
	-- Outputs
	O_NewLine  <= '1' when S_PtrCol = to_unsigned(0,7) else '0';
	O_EndImage <= '1' when (S_PtrCol= to_unsigned(0,7) and S_PtrLine = to_unsigned(98,7)) else '0';
	
	S_temp_out_adder <= 100*S_PtrLine + S_PtrCol;
	O_ADR_R  <= std_logic_vector(S_temp_out_adder + S_out_mux);
	O_ADR_W  <= std_logic_vector(S_temp_out_adder + to_unsigned(99,7));
		

end Behavioral;

