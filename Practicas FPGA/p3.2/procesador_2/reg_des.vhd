LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg_des IS
PORT (dato_in: IN std_logic_vector (9 DOWNTO 0);
		reset, carga, clk, en: IN std_logic; 
		dato_out: OUT std_logic);
END reg_des;

ARCHITECTURE circuito OF reg_des IS 
SIGNAL Q:std_logic_vector (15 DOWNTO 0);

BEGIN
	PROCESS (reset, CLK)
	BEGIN
	IF reset='1' THEN Q<="0000000000000000";
		ELSE
			IF (CLK'event AND CLK='0') THEN
				IF carga='1' THEN Q(11 DOWNTO 2) <=dato_in; Q(15 DOWNTO 12) <= "0111";
				ELSIF en='1' THEN Q<=Q (14 DOWNTO 0) & '0';
				END IF;
			END IF;
	END IF;
	END PROCESS;
	dato_out<=Q (15);
END circuito;