-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "03/26/2023 15:34:10"
                                                            
-- Vhdl Test Bench template for design  :  procesador_2
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY procesador_2_vhd_tst IS
END procesador_2_vhd_tst;
ARCHITECTURE procesador_2_arch OF procesador_2_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL cs_adc : STD_LOGIC;
SIGNAL cs_dac : STD_LOGIC;
SIGNAL en : STD_LOGIC;
SIGNAL eop : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL sck_adc : STD_LOGIC;
SIGNAL sck_dac : STD_LOGIC;
SIGNAL sdi : STD_LOGIC;
SIGNAL sdo : STD_LOGIC;
COMPONENT procesador_2
	PORT (
	clk : IN STD_LOGIC;
	cs_adc : BUFFER STD_LOGIC;
	cs_dac : BUFFER STD_LOGIC;
	en : IN STD_LOGIC;
	eop : BUFFER STD_LOGIC;
	reset : IN STD_LOGIC;
	sck_adc : BUFFER STD_LOGIC;
	sck_dac : BUFFER STD_LOGIC;
	sdi : IN STD_LOGIC;
	sdo : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : procesador_2
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	cs_adc => cs_adc,
	cs_dac => cs_dac,
	en => en,
	eop => eop,
	reset => reset,
	sck_adc => sck_adc,
	sck_dac => sck_dac,
	sdi => sdi,
	sdo => sdo
	);
reset<='0','1' after 1000 ns;
en<= '0','1' after 1000 ns;
dato:process
begin
  sdi<='0'; wait for 6500 ns;
  sdi<='1'; wait for 1000 ns;
  sdi<='0'; wait for 1000 ns;
  sdi<='1'; wait for 2000 ns;
  sdi<='0'; wait for 2000 ns;
  sdi<='1'; wait for 7500 ns;  
end process dato;
reloj:process
begin
  clk<='0'; wait for 20 ns;
  clk<='1'; wait for 20 ns;  
end process reloj;                                         
END procesador_2_arch;
