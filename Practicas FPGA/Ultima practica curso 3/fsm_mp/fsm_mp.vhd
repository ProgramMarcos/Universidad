LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity fsm_mp is  --declaracion de la entidad, entradas y salida
port(reloj,reset,pulsador : in std_logic;
		est : out std_logic_vector(2 downto 0);
		salida : out std_logic);

end fsm_mp;

architecture comportamiento of fsm_mp is 
type estado is(E0,E1,E2,E3,E4,E5,E6,E7);
signal estado_actual,estado_siguiente: estado;
signal pulsador_negado : std_logic; --declaraciÃƒÆ’Ã‚Â³n de variables internas

begin 
pulsador_negado<= not pulsador;

fsm_mem: process (reloj, reset)  --funcionamiento de la memoria
begin 
	if reset='1' then estado_actual<=E0; --reset prioritario activo a nivel alto (si activo paso a est0)
	elsif rising_edge(reloj) then  --cuando hay flanco de reloj
		estado_actual<=estado_siguiente; --actualizo el estado
	end if;
end process fsm_mem;

comb_fsm: process(estado_actual,pulsador_negado)
begin 
	case estado_actual is 
		when E0 =>
			est<= "000";
			if pulsador_negado='1' then estado_siguiente<=E1; 
				else estado_siguiente<=E4;
			end if;
			--Si estoy en estado 0 y hay pulsador_negado evoluciono al estado 1
			-- sinÃƒÆ’Ã‚Â³ voy al estado 4
		
		when E1 =>
		est<= "001";
			if pulsador_negado='1' then estado_siguiente<=E2; 
				else estado_siguiente<=E1;
			end if;
			--Si estoy en estado 1 y hay pulsador_negado voy a est 2
			-- sinÃƒÆ’Ã‚Â³ evoluciono me quedo en est1
			
		when E2 =>
		est<= "010";
			if pulsador_negado='1' then estado_siguiente<=E3; 
				else estado_siguiente<=E6;
			end if;
			--Si estoy en estado 2 y hay pulsador_negado evoluciono al estado 3
			-- sinÃƒÆ’Ã‚Â³ voy a est6
		
		when E3 =>
		est<= "011";
			if pulsador_negado='1' then estado_siguiente<=E4; 
				else estado_siguiente<=E3;
			end if;
			--Si estoy en estado 3 y hay pulsador_negado voy a est 4
			-- sinÃƒÆ’Ã‚Â³ vuelvo al estado 3
		when E4 =>
			est<= "100";
			if pulsador_negado='1' then estado_siguiente<=E5; 
				else estado_siguiente<=E5;
			end if;
			--en el estado 4 evoluciono al 5 incondicionalmente
		when E5 =>
			est<= "101";
			if pulsador_negado='1' then estado_siguiente<=E6; 
				else estado_siguiente<=E4;
			end if;
			--Si estoy en estado 5 y hay pulsador_negado voy a est 6
			-- sinÃƒÆ’Ã‚Â³ vuelvo al estado 4
		when E6 =>
			est<= "110";
			if pulsador_negado='1' then estado_siguiente<=E7; 
				else estado_siguiente<=E6;
			end if;
			--Si estoy en estado 6 y hay pulsador_negado voy a est 7
			-- sinÃƒÆ’Ã‚Â³ vuelvo al estado 6
		when E7 =>
			est<= "111";
			if pulsador_negado='1' then estado_siguiente<=E0; 
				else estado_siguiente<=E7;
			end if;
			--Si estoy en estado 7 y hay pulsador_negado voy a est 0
			-- sinÃƒÆ’Ã‚Â³ vuelvo al estado 7
			
	end case;
end process comb_fsm;

with estado_actual select salida <=
		'0' when E0,
		'0' when E1,
		'1' when E2,
		'1' when E3,  --salida activa en estado 2 y 3
		'0' when E4,
		'0' when E5,
		'0' when E6,
		'1' when E7,  --salida activa en estado 7
		'0' when OTHERS;
END comportamiento;


--segmentos : out std_logic_vector(6 downto 0);
--component decodificador7
--port( I : in std_logic_vector(2 downto 0);
--			Y : out std_logic_vector(6 downto 0));
--end component;
--componente_segmentos: decodificador7 port map (estado_actual,segmentos);
			