--PrÃƒÆ’Ã‚Â¡ctica 7: Sistemas ElectrÃƒÆ’Ã‚Â³nicos Digitales 
--Universidad de Vigo, EE Industrial, curso 2013-2014 
--Camilo QuintÃƒÆ’Ã‚Â¡ns GraÃƒÆ’Ã‚Â±a

LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;

ENTITY spi_dac IS
PORT (reset, sc, clk: IN STD_LOGIC; 
		din : IN STD_LOGIC_VECTOR (9 DOWNTO 0); 
		sdo, eoc, sck, cs: OUT STD_LOGIC);
END spi_dac;

ARCHITECTURE circuito OF spi_dac IS

COMPONENT reg_des
	PORT (reset, carga, clk, en: IN STD_LOGIC;
			dato_in: IN STD_LOGIC_VECTOR (9 DOWNTO 0); 
			dato_out: OUT STD_LOGIC);
END COMPONENT;

COMPONENT divisor_reloj
GENERIC (n: INTEGER);
	PORT (clkin, en: IN STD_LOGIC; 
			--para el modulo se pone n-1
			modulo: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			clkout: OUT STD_LOGIC);
	
END COMPONENT;

COMPONENT impulso_ini
	PORT (clk, reset, entrada: IN STD_LOGIC;
			salida: OUT STD_LOGIC);
END COMPONENT;

COMPONENT contador
	PORT (clk, inicio, en: IN STD_LOGIC; 
			fin: OUT STD_LOGIC);
END COMPONENT;

COMPONENT uc_spi_out  
	PORT (clk, reset, din, sc, eoc: IN STD_LOGIC;
			cs, en, sck, sdo : OUT STD_LOGIC);
END COMPONENT;

SIGNAL clk_spi : STD_LOGIC;
SIGNAL fin_de_conversion : STD_LOGIC;
SIGNAL habilitacion : STD_LOGIC;
SIGNAL impulso_inicio_conversion : STD_LOGIC;
SIGNAL not_sc : STD_LOGIC;
SIGNAL not_reset : STD_LOGIC;
SIGNAL valor_division : STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL dato_serie: STD_LOGIC;

BEGIN

cp1:reg_des
PORT MAP(reset => not_reset,
			carga => impulso_inicio_conversion, 
			clk => clk_spi,
			en => habilitacion,
			dato_in=> din,
			dato_out => dato_serie);

cp2: divisor_reloj
GENERIC MAP (n => 3)
PORT MAP(clkin => clk,
			en => reset, --habilitar_reloj,
			modulo => valor_division,
			clkout => clk_spi);

cp3: impulso_ini

PORT MAP(clk => clk_spi,
			reset => not_reset,
			entrada => not_sc,	
			salida => impulso_inicio_conversion);

not_sc <= NOT (sc);
not_reset <= NOT (reset);

cp4: contador 
PORT MAP(clk => clk_spi,
			inicio =>impulso_inicio_conversion, 
			en => habilitacion, 
			fin => fin_de_conversion) ;
			
cp5: uc_spi_out
PORT MAP(clk => clk_spi,
			reset => not_reset,
			din => dato_serie,
			sc => impulso_inicio_conversion, 
			eoc=> fin_de_conversion,
			cs => CS,
			en => habilitacion,
			sck => sck,
			sdo => sdo) ;
			
valor_division<="101";
eoc <= fin_de_conversion;

END circuito;