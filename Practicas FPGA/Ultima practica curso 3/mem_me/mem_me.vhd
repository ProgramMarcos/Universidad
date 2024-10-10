LIBRARY ieee;
use ieee.std_logic_1164.all;

entity mem_me is 
port ( reset, reloj : in std_logic; --reset (D2) reloj (G21)
		 estado_siguiente : in std_logic_vector(2 downto 0);
		 estado_actual : out std_logic_vector(2 downto 0));
end entity ;

architecture circuito of mem_me is
begin
process(reset, reloj)
	begin
		if reset='1' then estado_actual<="000";  --reset prioritario asincrono activo a nivel alto
		elsif rising_edge(reloj) then --flanco de reloj
			estado_actual<=estado_siguiente;
		end if;
	end process;
end circuito;