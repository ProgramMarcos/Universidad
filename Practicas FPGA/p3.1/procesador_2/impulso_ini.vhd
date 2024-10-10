LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY impulso_ini IS
	PORT (clk, reset, entrada: IN std_logic;
		salida: OUT std_logic);
END;

ARCHITECTURE comportamiento OF impulso_ini IS
	TYPE tipo IS (e0, e1, e2);
	SIGNAL estado: tipo;

BEGIN
	PROCESS (clk, reset)	
		BEGIN
			IF reset='1' THEN estado<=e0;
			ELSE
				IF clk='1' AND clk'event THEN
					CASE estado IS
						WHEN e0 => IF entrada='0' THEN estado<=e0; ELSE estado<=e1; END IF;
						WHEN e1 => estado<=e2;
						WHEN e2 => IF entrada='1' THEN estado<=e2; ELSE estado<=e0; END IF;
					END CASE;
				END IF;
			END IF;
	END PROCESS;
	PROCESS (estado)
		BEGIN
			CASE estado IS
				WHEN e0 =>salida<= '0';
				WHEN e1 => salida<='1';
				WHEN e2 => salida<='0';
			END CASE;
	END PROCESS;
END comportamiento;