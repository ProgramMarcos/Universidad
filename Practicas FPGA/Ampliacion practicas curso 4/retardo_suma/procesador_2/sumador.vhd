

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumador is
    port (
        A : in unsigned(10 downto 0);
        B : in unsigned(10 downto 0);
        Suma : out unsigned(10 downto 0)
    );
end sumador;

architecture comportamiento of sumador is
begin
    process(A, B)
    begin
		Suma <= A + B;
      
    end process;
end comportamiento;

