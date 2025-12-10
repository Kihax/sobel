
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity gradientUnit is
    Port ( I_Pix11, I_Pix12, I_Pix13 : in STD_LOGIC_VECTOR (7 downto 0);
		   I_Pix21, I_Pix22, I_Pix23 : in STD_LOGIC_VECTOR (7 downto 0);
		   I_Pix31, I_Pix32, I_Pix33 : in STD_LOGIC_VECTOR (7 downto 0);
		   O_pixEdge : out  STD_LOGIC		   
		   ); 
end gradientUnit;


architecture Behavioral of gradientUnit is

-- déclaration des signaux internes
signal S_Pix11, S_Pix12, S_Pix13, S_Pix21, S_Pix22, S_Pix23, S_Pix31, S_Pix32, S_Pix33 : signed(8 downto 0);
signal S_Gx, S_Gy : signed(10 downto 0); -- on change le nombre de bit car la valeur max est 255+2*255+255 et la valeur min est l'opposée
signal S_G : unsigned(10 downto 0);

begin

	-- associe les variables aux entrées et "adapte" le format
	S_Pix11 <= signed('0'&I_Pix11);
	S_Pix12 <= signed('0'&I_Pix12);
	S_Pix13 <= signed('0'&I_Pix13);

	S_Pix21 <= signed('0'&I_Pix21);
	S_Pix22 <= signed('0'&I_Pix22);
	S_Pix23 <= signed('0'&I_Pix23);

	S_Pix31 <= signed('0'&I_Pix31);
	S_Pix32 <= signed('0'&I_Pix32);
	S_Pix33 <= signed('0'&I_Pix33);

	-- Calculs des gradients, il faut faire attention car il faut adapté la taille des signaux par rapport aux nombres de bits
	-- le &'0' à la fin des variables permet de multiplier par 2 de manière optimale
	-- et le "000"& et "00"& permet d'adapter la taille des variables pour passer sur du 11 bits
	S_Gy <= ("00"&S_Pix31) + ('0'&S_Pix32&'0') + ("00"&S_Pix33) - ("00"&S_Pix11) - ('0'&S_Pix12&'0') - ("00"&S_Pix13);
	S_Gx <= ("00"&S_Pix13) + ('0'&S_Pix23&'0') + ("00"&S_Pix33) - ("00"&S_Pix11) - ('0'&S_Pix21&'0') - ("00"&S_Pix31);

	-- calcul des valeurs absoulues et convertion en unsigned
	S_G <= unsigned(abs(S_Gx)) + unsigned(abs(S_Gy));

	-- compare à la valeur seuil
	O_pixEdge <= '1' when S_G > 255 else '0';
		

end Behavioral;

