
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pixedgeReg is
    Port ( clk			:in STD_LOGIC;
		   reset		:in STD_LOGIC;
		   I_pixEdge : in  STD_LOGIC;
		   I_ldPixEdge : in STD_LOGIC;
		   O_pixEdge : out  STD_LOGIC		   
		   ); 
end pixedgeReg;


architecture Behavioral of pixedgeReg is

-- déclaration des signaux internes
signal S_Sobel : STD_LOGIC;

begin

	
	process(clk, reset)
	begin 
	
	if(reset = '1') then
	   S_Sobel <= '0';
	elsif(rising_edge(clk)) then
	   if(I_ldPixEdge = '1') then
           S_Sobel <= I_pixEdge;
        end if; 
	end if;
	end process;
	
	O_pixEdge <= S_Sobel;
		

end Behavioral;

