library IEEE;	-- Declaracion de Biblioteca de Recursos del Lenguaje
use IEEE.STD_LOGIC_1164.ALL;	-- Sentencias para precompilar los paquetes 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity decodificador7 is
	port( I : in std_logic_vector(2 downto 0);
			Y : out std_logic_vector(6 downto 0)
			
			);
end decodificador7;

architecture decode7 of decodificador7 is
	begin
	process(I)
		begin
		case I is
			when "000"=>Y<="1000000";
			when "001"=>Y<="1111001";
			when "010"=>Y<="0100100";
			when "011"=>Y<="0110000";
			when "100"=>Y<="0011001";
			when "101"=>Y<="0010010";
			when "110"=>Y<="0000010";
			when "111"=>Y<="1111000";
			when others =>Y<="1111111";
		end case;
	end process;
end decode7;