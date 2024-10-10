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


SIGNAL dato_in, sal_mem: UNSIGNED (nbits-1 DOWNTO 0); --creo un nuevo signal UNSIGNED pra la salida de la memoria 
SIGNAL dato_out: UNSIGNED (nbits downto 0);


SIGNAL dato_1: STD_LOGIC_VECTOR (nbits-1 DOWNTO 0);
SIGNAL dato_2: STD_LOGIC_VECTOR (nbits DOWNTO 0);

SIGNAL not_reset, reloj_muestreo: std_logic;
SIGNAL valor_division: STD_LOGIC_VECTOR (11 DOWNTO 0); --adaptado a la frecuencia requerida

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


-------------MEMORIA FIFO----------
COMPONENT mem_fifo
GENERIC(longitud: INTEGER:=50); 

PORT (clk: IN STD_LOGIC;
		e: IN UNSIGNED (9 DOWNTO 0);
		sal: OUT UNSIGNED (9 DOWNTO 0));
END COMPONENT;
-------------------------------------

-------------SUMADOR-----------------
COMPONENT sumador is
	port(A,B: in unsigned(10 downto 0);
			suma : out unsigned(10 downto 0));
end component;
-------------------------------------



BEGIN 
not_reset <= NOT reset; 
--el reloj de 50 MHz se divide por 2000 
--para obtener una frecuencia de 25 kHz 
--valor_division<="11111010000"; -- VALOR 2000 DECIMAL
valor_division<="111110100000"; --divido los 50MHz entre 4 para la seÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â±al de 12.5Mhz,
											-- esto conlleva una adaptaciÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â³n en el cÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â³digo, pues pasamos a tener 12 bits


--se adpata la entrada del filtro a unsigned 
--y la salida a logic_vector
dato_in<=UNSIGNED (dato_1);
dato_2<=STD_LOGIC_VECTOR(dato_out);

cp2: divisor_reloj
	GENERIC MAP (n => 12) --adaptado a la frecuencia requerida
	PORT MAP ( clkin => clk, en => en, modulo => valor_division,
				  clkout => reloj_muestreo);
				  

cp1: spi_adc 
PORT MAP (clk => clk, reset => not_reset, sc => reloj_muestreo,
			sdi => sdi, sck => sck_adc, 		cs => cs_adc, 
			dout => dato_1);
			
fifo: mem_fifo
	port map( e => dato_in,
		  clk => reloj_muestreo,
        sal => sal_mem
	);

sum: sumador
	port map (A=>'0' & sal_mem,
				 B=>'0' & dato_in,
				 suma=>dato_out);

cp3: spi_dac
	PORT MAP (clk => clk, reset => reset, sc => reloj_muestreo,
				 sdo => sdo, sck => sck_dac, cs => cs_dac, 
				 eoc => eop, din => dato_2(10 downto 1));
				 


END circuito;