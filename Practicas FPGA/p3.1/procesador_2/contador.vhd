LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY contador IS
PORT (clk, inicio, en: IN std_logic;
		fin: OUT std_logic);
END contador;

ARCHITECTURE algoritmo OF contador IS
SIGNAL Q: unsigned (4 downto 0);
BEGIN
	PROCESS (inicio, clk)
	BEGIN
		IF inicio='1' THEN Q<="00000";
		  ELSIF clk'event AND clk='0' THEN
			   IF en='1' THEN Q<=Q + 1;
			   END IF;
		END IF;
	END PROCESS;
	fin<=Q(4) AND NOT Q(3) AND NOT Q(2) AND NOT Q(1) AND NOT Q(0);
END algoritmo;