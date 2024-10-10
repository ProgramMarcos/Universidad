library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_fifo is
GENERIC (longitud:INTEGER:=25);
port (
   e : in unsigned(9 downto 0);
	clk: in std_logic;
   sal : out unsigned(9 downto 0) 
);
end mem_fifo;

ARCHITECTURE guarda OF mem_fifo IS
TYPE vector IS ARRAY (0 TO (longitud-1)) OF UNSIGNED (9 DOWNTO 0);
SIGNAL fifo:vector;

begin
PROCESS (clk) 
	BEGIN 	
		IF (clk='1' AND clk'event) THEN
			FOR i IN (longitud-1) downto 1 LOOP
				fifo(i)<=fifo (i-1);
			END LOOP;
			fifo(0)<=e;
		END IF; 
END PROCESS;
sal<=fifo(longitud-1);
end guarda;
