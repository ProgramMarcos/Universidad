--DIVISOR DE FRECUENCIA 
--Entidad que genera una seÃ±al clkout de un bit de frecuecnia f_out,
--a partir de una seÃ±al de entrada clkin de frecuencia f_in
--de modo que:
--si modulo es cero o uno, entonces f_out=f_in,
--y si modulo es mayor que 1, entonces f_out-f_in/modulo.
--En donde modulo es el dato de entrada que representa el valor
--por el cual se divide la frecuencia fin.

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY divisor_reloj IS
--el modulo del divisor debe ser menor que (2^n)-1
--si n es 16, entonces el modulo maximo sera 65535

GENERIC (n: INTEGER:=3);

PORT( clkin: IN std_logic;
		clkout: OUT std_logic;
		en: IN std_logic; 
		modulo: IN std_logic_vector (n-1 downto 0)
		);

END divisor_reloj;

ARCHITECTURE decripcion OF divisor_reloj IS
--contador es la variable que se incrementara
SIGNAL contador: INTEGER RANGE 0 TO (2**n)-1;

--se utiliza una seÃ±al que representa la mitad de la division
SIGNAL mitad_modulo: std_logic_vector ((n-1) DOWNTO 0);

--seÃ±ales de tipo entero con el valor del divisor y su mitad 
SIGNAL divisor, mitad_divisor: INTEGER RANGE 0 TO (2**n)-1;

BEGIN
--se rota a la derecha de forma que quede dividido a la mitad 1);
mitad_modulo ((n-2) DOWNTO 0) <=modulo ((n-1) DOWNTO 1);

--se pone a cero el bit mÃ¡s significativo --se pasan a datos de tipo entero para compararse con contador
mitad_modulo(n-1) <='0';
--se pasan a datos de tipo entero para compararse con contador 
divisor<=TO_INTEGER (UNSIGNED (modulo)); 
mitad_divisor<=TO_INTEGER (UNSIGNED (mitad_modulo));

PROCESS (clkin, divisor, mitad_divisor, en)
BEGIN
	IF en='0' THEN
		clkout <='0';
		contador<=1;
	ELSE
		IF (divisor <= 1) THEN
			clkout<=clkin;
			contador<=1;
		ELSE
			IF (clkin='1' AND clkin'EVENT) THEN
				IF (contador<=mitad_divisor) THEN
					clkout <='1';
					contador<=contador+1;
				ELSE IF (contador>mitad_divisor AND contador<divisor) THEN
					clkout<='0';
					contador<=contador+1;
				ELSE
					contador<=1;
					clkout<='0';

				END IF;
			END IF;
		END IF;
	END IF;
END IF;

END PROCESS;
END decripcion;