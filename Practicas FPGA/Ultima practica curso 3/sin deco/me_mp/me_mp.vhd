library ieee;
use ieee.std_logic_1164.all;

entity me_mp is  
port (reloj, reset, pulsador : in std_logic;
		salida : out std_logic;
		ESTADO: out std_logic_vector(2 downto 0);
		segmentos : out std_logic_vector(6 downto 0));
end entity;

architecture circuito of me_mp is 
component comb_me
port (pulsador : in std_logic;
		estado_actual : in std_logic_vector(2 downto 0);
		estado_siguiente : out std_logic_vector(2 downto 0));
end component;

component mem_me
port (reset, reloj : in std_logic;
		estado_siguiente : in std_logic_vector(2 downto 0);
		estado_actual : out std_logic_vector(2 downto 0));
end component;

component comb_sal
port (estado_actual : in std_logic_vector(2 downto 0);
		salida : out std_logic);
end component;



SIGNAL estado_actual, estado_siguiente : std_logic_vector(2 downto 0);
signal pulsador_negado: std_logic;

begin 
estado<=estado_actual; 
pulsador_negado<= not pulsador; --la placa DE0 tiene el pulsador invertido
componente_1:comb_me port map (pulsador_negado,estado_actual,estado_siguiente);
componente_2:mem_me port map (reset,reloj,estado_siguiente,estado_actual);
componente_3:comb_sal port map (estado_actual,salida);




end circuito;