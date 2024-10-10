--Conexion de las señales de entrada:
--	 clk: se conecta al reloj de 50 MHz de la placa
--	 reset: se conecta al interruptor sw0
--	 sc: Start Conversion, se conecta al pulsador BUTTON2
--  din: se conecta al terminal 6 del ADC
--Conexión de las señales de salida:
--  sck: es el reloj SPI de 1 MHz
--  cs: es la señal SPI de selección del periférico 
--  dout: es la palabra de datos 

library ieee;
use ieee.std_logic_1164.all;

entity spi_adc is 
generic(n: integer:=10); --numero de bits del dato
port
	(clk,reset,sc,sdi: in std_logic;
	sck,cs: out std_logic;
	dout: out std_logic_vector (n-1 downto 0) );
end;

architecture comportamiento of spi_adc is 

signal ck,sc_prev: std_logic;

component clkout port 
	( areset: in std_logic:='0';
		inclk0: in std_logic:='0';
		c0 : out std_logic
	);
end component;

begin 

clkadc: clkout port map(areset=>reset, inclk0=>clk, c0=>ck);

sck<=ck;

datoin: process(reset, ck)
	variable start, scint: std_logic;
	variable dato: std_logic_vector (9 downto 0);
	variable indice: integer range 0 to 11;
	variable altaimp: integer range 0 to 15;

begin    --inicialización asíncrona
	if reset='1' then
		dout<= (others =>'0');
		scint:='0';
		indice:=0;
		altaimp:=0; 						--CONTADOR DE LOS DOS CICLOS INICIALES
		sc_prev<='1';
	else											--ACTIVO A FLANCO POSITIVO 
		if (ck'event and ck='1') then
			if (sc='0' and scint='0') then
				sc_prev<='0';
				scint:='0';
				altaimp:=altaimp+1;
				if (sdi='0' and altaimp>=4 and indice=0) then --ciclos iniciales
					indice:=1;
					sc_prev<= '0';			--habilitación 
					dato:=(others=> '0');
				elsif (indice>=1 and indice<11) then --estados de transmision de datos
					dato(10-indice):= sdi; 		--mas deshabilitacion
					if (indice<10) then --transmision de dato
						sc_prev<= '0';
					else dout <= dato;
						scint:='1';
						sc_prev<= '1';
					end if;
					indice:=indice+1;
				else null;
				end if;
			elsif sc='1' then --requiere flanco positivo en habilitación externa 
				scint:='0';		--para nueva transmisión 
				indice:=0;
				altaimp:=0;
			else null;
			end if;
		else null; --clk
		end if;
	end if;
dout<= dato;

end process;

habil: process(reset,ck)
begin 
	if (ck'event and ck='0') then 
		cs<= sc_prev;
		else null;
	end if;
end process;
end architecture;

		