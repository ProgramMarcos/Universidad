LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY spi_dac_vhd_tst IS
END spi_dac_vhd_tst;
ARCHITECTURE spi_dac_arch OF spi_dac_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL cs : STD_LOGIC;
SIGNAL din : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL eoc : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL sc : STD_LOGIC;
SIGNAL sck : STD_LOGIC;
SIGNAL sdo : STD_LOGIC;
COMPONENT spi_dac
	PORT (
	clk : IN STD_LOGIC;
	cs : OUT STD_LOGIC;
	din : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	eoc : OUT STD_LOGIC;
	reset : IN STD_LOGIC;
	sc : IN STD_LOGIC;
	sck : OUT STD_LOGIC;
	sdo : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : spi_dac
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	cs => cs,
	din => din,
	eoc => eoc,
	reset => reset,
	sc => sc,
	sck => sck,
	sdo => sdo
	);
dato_entrada: PROCESS
BEGIN
  din<="0000000000"; WAIT FOR 100 ns;
  din<="0100111000"; WAIT;
END PROCESS dato_entrada;

inicio: PROCESS
BEGIN
  reset<='1'; WAIT FOR 50 ns;
  reset<='0'; WAIT FOR 200 ns;
  reset<='1'; WAIT;
END PROCESS inicio;

ini_conversion: PROCESS
BEGIN
  sc<='1'; WAIT FOR 250 ns;
  sc<='0'; WAIT FOR 450 ns;
  sc<='1'; WAIT;
END PROCESS ini_conversion;

reloj: PROCESS
BEGIN
  clk<='0';
  FOR i IN 0 TO 120 LOOP
    clk <= '1'; wait for 10 ns;
    clk <= '0'; wait for 10 ns;
  END LOOP;
WAIT;
END PROCESS reloj;
END spi_dac_arch;
