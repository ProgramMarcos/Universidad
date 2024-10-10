TITLE "Practica 10 tarea 4"

PROCESSOR 18F47Q10
#include <xc.inc>
    
CONFIG FEXTOSC=OFF
CONFIG RSTOSC=HFINTOSC_1MHZ
CONFIG LVP=ON
    
CONFIG WDTE=OFF
    
PSECT programa,abs,class=CODE,reloc=2
    
mi_programa:
	ORG 0x0000
	GOTO inicio
	NOP
ORG 0x0020

inicio:
	MOVLW 15  ;banco 15
	MOVWF BSR, a
	
	
	BCF TRISA,4,a  ;RA4 salida
	BCF ANSELA,4,b ;digital
	

	MOVLW 14  ;BANCO 14
	MOVWF BSR,a
	
	CLRF T4CON,a
	MOVLW 01111111B
	MOVWF T4CON,a ;preesc=1/128  postesc=1/16
	CLRF T4HLT,a ;Modo continuo activado por programa
			; sin sincronización CLK
	
	CLRF T4CLKCON,a
	BSF T4CLKCON,0,a ;Fosc/4
	BSF T4CON,7,a ;Habilitacion
	
	
principal:
	MOVLW 121
	MOVWF T4PR,a
repet:
    
	BTFSS PIR4,3,b ;Comprobacion del bit de rebosamiento
	BRA repet
	BTG PORTA,4,a ;CONMUTA EL BIT
	BCF PIR4,3,b ;Restaurar rebosamiento
	bra principal
	
END mi_programa

