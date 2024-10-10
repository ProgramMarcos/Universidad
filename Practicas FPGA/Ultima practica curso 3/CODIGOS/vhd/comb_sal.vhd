library ieee;
use ieee.std_logic_1164.all;

entity comb_sal is
port (estado_actual : in std_logic_vector(2 downto 0);
		salida : out std_logic);
end entity;

architecture circuito of comb_sal is 
begin 
	with estado_actual select salida<=
		'0' when "000",
		'0' when "001",
		'1' when "010",
		'1' when "011",
		'0' when "100",
		'0' when "101",
		'0' when "110",
		'1' when "111",
		'0' when others;
end circuito;