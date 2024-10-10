LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE IEEE.math_real.all;

ENTITY rectificador IS 
--longitud: numero de datos que se promedian 
--n: resolucion de los datos (numero de bits)
GENERIC (longitud:INTEGER:=3;
			n:INTEGER:=10);
PORT (clk, reset: IN STD_LOGIC;
		dato_in: IN UNSIGNED ((n-1) DOWNTO 0);
		dato_out,leds: OUT UNSIGNED ((n-1) DOWNTO 0)); 
END rectificador;

ARCHITECTURE descripcion OF rectificador IS
SIGNAL media: UNSIGNED ((integer (ceil(log2(real (longitud)))) +n-1) DOWNTO 0);
TYPE vector IS ARRAY (0 TO (longitud-1)) OF UNSIGNED ((n-1) DOWNTO 0);
SIGNAL memoria:vector; 
signal dato_in_usig,comparador,valorMax: UNSIGNED ((n-1) DOWNTO 0);
signal posicion: INTEGER:=0;
--SIGNAL comparador: INTEGER RANGE 0 TO (2**n)-1;
BEGIN
dato_in_usig<=unsigned(dato_in);
--comparador<=((2**n)-1)/2;
valorMax<=(OTHERS =>'1');
PROCESS (reset, clk) 
	BEGIN 
		comparador<=(OTHERS =>'0');
		comparador(n-1)<='1'; --todos los bits a 1 menos el mas significativo
		IF reset='1' THEN 
			FOR i IN 0 TO (longitud-1) LOOP
				memoria (i) <= (OTHERS =>'0'); 
			END LOOP;
			
		ELSIF (clk='1' AND clk'event) THEN
--			if dato_in_usig>=comparador then
				memoria(posicion)<=dato_in-comparador;
--			else memoria(posicion)<=valorMax-(dato_in+comparador);
--			end if;
			dato_out<=memoria(posicion);
			posicion<=posicion+1;
			if posicion=longitud then
				posicion<=0;
			end if;
		END IF; 
END PROCESS;

PROCESS (memoria)
	VARIABLE suma: UNSIGNED ((integer(ceil(log2(real(longitud))))+n-1) DOWNTO 0); 
	BEGIN
		suma := (OTHERS =>'0'); 
		FOR i IN 0 TO (longitud-1) LOOP
			suma:=suma+memoria(i); 
		END LOOP;
		media<= (suma/(longitud)); 
END PROCESS;

leds<=media((n-1) DOWNTO 0); 
END descripcion;