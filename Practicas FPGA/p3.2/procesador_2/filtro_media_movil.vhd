---------
---------
---------
---------
---------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE IEEE.math_real.all;

ENTITY filtro_media_movil IS 
--longitud: numero de datos que se promedian 
--n: resolucion de los datos (numero de bits)
GENERIC (longitud:INTEGER:=4;
			n:INTEGER:=8);
PORT (clk, reset: IN STD_LOGIC;
		dato_in: IN UNSIGNED ((n-1) DOWNTO 0);
		dato_out: OUT UNSIGNED ((n-1) DOWNTO 0)); 
END filtro_media_movil;

ARCHITECTURE descripcion OF filtro_media_movil IS
SIGNAL media: UNSIGNED ((integer (ceil(log2(real (longitud)))) +n-1) DOWNTO 0);
TYPE vector IS ARRAY (0 TO (longitud-1)) OF UNSIGNED ((n-1) DOWNTO 0);
SIGNAL fifo:vector; 
BEGIN

PROCESS (reset, clk) 
	BEGIN 
		IF reset='1' THEN 
			FOR i IN 0 TO (longitud-1) LOOP
				fifo (i) <= (OTHERS =>'0'); 
			END LOOP;
			
		ELSIF (clk='1' AND clk'event) THEN
			FOR i IN 1 TO (longitud-1) LOOP
				fifo(i)<=fifo (i-1); 
			END LOOP;
			fifo(0)<=dato_in;
		END IF; 
END PROCESS;

PROCESS (fifo)
	VARIABLE suma: UNSIGNED ((integer(ceil(log2(real(longitud))))+n-1) DOWNTO 0); 
	BEGIN
		suma := (OTHERS =>'0'); 
		FOR i IN 0 TO (longitud-1) LOOP
			suma:=suma+fifo(i); 
		END LOOP;
		media<= (suma/(longitud)); 
END PROCESS;

dato_out<=media((n-1) DOWNTO 0); 
END descripcion;