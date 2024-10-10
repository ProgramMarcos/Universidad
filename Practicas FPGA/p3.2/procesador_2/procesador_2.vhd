LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY procesador_2 IS
GENERIC (nbits: integer:=10);
PORT (clk: IN std_logic;
		reset:IN std_logic; 
		sdi: IN std_logic; 
		en: IN std_logic; 
		sck_dac: OUT std_logic;
		cs_dac: OUT std_logic;
		sck_adc: OUT std_logic;
		cs_adc: OUT std_logic; 
		eop: OUT STD_LOGIC;
		sdo: OUT STD_LOGIC); 
END;

ARCHITECTURE circuito OF procesador_2 IS

SIGNAL dato_in, dato_out: UNSIGNED (nbits-1 DOWNTO 0); 
SIGNAL dato_1, dato_2: STD_LOGIC_VECTOR (nbits-1 DOWNTO 0);

SIGNAL not_reset, reloj_muestreo: std_logic;
SIGNAL valor_division: STD_LOGIC_VECTOR (10 DOWNTO 0);

COMPONENT spi_adc IS
GENERIC (n: INTEGER:=10);
PORT (clk, reset, sc, sdi: IN STD_LOGIC;
		sck, cs: OUT STD_LOGIC;
		dout: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0));
END COMPONENT;

COMPONENT spi_dac
	PORT (reset, sc, clk: IN STD_LOGIC;
			din: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			sdo, eoc, sck,cs: OUT STD_LOGIC); 
END COMPONENT;

COMPONENT divisor_reloj
GENERIC (n: INTEGER);
	PORT (clkin, en: IN STD_LOGIC;
			modulo : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			clkout : OUT STD_LOGIC);
END COMPONENT;

COMPONENT filtro_media_movil
GENERIC(longitud: INTEGER:=32;
			n:INTEGER:=10); 
PORT (clk, reset: IN STD_LOGIC;
		dato_in: IN UNSIGNED ((n-1) DOWNTO 0);
		dato_out: OUT UNSIGNED ((n-1) DOWNTO 0));
END COMPONENT;

BEGIN 
not_reset <= NOT reset; 
--el reloj de 50 MHz se divide por 2000 
--para obtener una frecuencia de 25 kHz 
valor_division<="11111010000";

--se adpata la entrada del filtro a unsigned 
--y la salida a logic_vector
dato_in<=UNSIGNED (dato_1);
dato_2<=STD_LOGIC_VECTOR(dato_out);

cp1: spi_adc 
PORT MAP (clk => clk, reset => not_reset, sc => reloj_muestreo,
			sdi => sdi, sck => sck_adc, 		cs => cs_adc, 
			dout => dato_1);
			
cp2: divisor_reloj
	GENERIC MAP (n => 11) 
	PORT MAP ( clkin => clk, en => en, modulo => valor_division,
				  clkout => reloj_muestreo);
				  
cp3: spi_dac
	PORT MAP (clk => clk, reset => reset, sc => reloj_muestreo,
				 sdo => sdo, sck => sck_dac, cs => cs_dac, 
				 eoc => eop, din => dato_2);
				 
cp4: filtro_media_movil
	PORT MAP (clk => reloj_muestreo, reset => not_reset,
				 dato_in => dato_in, dato_out => dato_out);
END circuito;