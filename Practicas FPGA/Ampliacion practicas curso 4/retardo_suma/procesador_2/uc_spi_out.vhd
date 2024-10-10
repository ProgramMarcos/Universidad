LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY uc_spi_out IS
PORT (clk, reset, din, sc, eoc: IN std_logic;
		cs, en, sck, sdo: OUT std_logic);
END;

ARCHITECTURE comportamiento OF uc_spi_out IS
TYPE tipo IS (e0, e1,e2);
SIGNAL est: tipo;
BEGIN
 PROCESS (clk, reset)
	BEGIN
	IF reset='1' THEN est<=e0;
		ELSE
			IF clk='1' AND clk'event THEN
			 CASE est IS
				WHEN e0 => IF sc='1' THEN est<=e1; ELSE est<=e0; END IF;
				WHEN e1 => est<=e2; 
				WHEN e2 => IF eoc='1' THEN est<=e0; ELSE est<=e2; END IF;
			 END CASE;
			END IF;
	END IF;
 END PROCESS;

 PROCESS (est, eoc, clk, din) 
	BEGIN
		CASE est IS
			WHEN e0=> cs<='1'; en<='0'; sdo<= '0'; sck<='0'; 
			WHEN e1=> cs<='0'; en<='0'; sdo<=din; sck<='0';
			WHEN e2=> en<='1'; sdo<=din; IF eoc='0' THEN cs<='0'; sck<=clk; ELSE cs<='1'; sck<='0'; END IF; 
								
		END CASE;
 END PROCESS;
END comportamiento;