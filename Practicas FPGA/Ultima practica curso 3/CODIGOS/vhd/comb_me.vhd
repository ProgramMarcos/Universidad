LIBRARY ieee;
use ieee.std_logic_1164.all;

entity comb_me is 
port ( pulsador: in std_logic;  --pulsador2 DE0 (F1)
		 estado_actual : std_logic_vector(2 downto 0);
		 estado_siguiente : out std_logic_vector(2 downto 0));
END entity;

architecture circuito of comb_me is

begin

	with (estado_actual & pulsador) select estado_siguiente<=  --concateno entrada y estado actual para seleccionar el estado siguiente
	"100" when "0000",  --(estado siguiente) when (concatenacion)
	"001" when "0001",
	"001" when "0010",
	"010" when "0011",
	"110" when "0100",
	"011" when "0101",
	"011" when "0110",
	"100" when "0111",
	"101" when "1000",  --(estado siguiente) when (concatenacion)
	"101" when "1001",
	"100" when "1010",
	"110" when "1011",
	"110" when "1100",
	"111" when "1101",
	"111" when "1110",
	"000" when "1111",
	"000" when others;

end circuito;