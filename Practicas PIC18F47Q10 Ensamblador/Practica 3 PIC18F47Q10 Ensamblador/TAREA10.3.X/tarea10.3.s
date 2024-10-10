TITLE "Practica 10 tarea 3"

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
	valor equ 0x00
	MOVLW 15  ;banco 15
	MOVWF BSR, a
	
	
	CLRF TRISA,a  ;puerto A salida
	CLRF ANSELA,b ;digital
	
	BSF TRISC,5,b ;RC5 entrada
	BCF ANSELC,5,b ;Digital
	
	
	MOVLW 0x15
	MOVWF T4INPPS,a
	
	;(lo mismo que meter un 0x15 en T4INPPS) para seleccionar
	;el pin RC5

	MOVLW 14  ;BANCO 14
	MOVWF BSR,a
	
	CLRF T4CON,b
	CLRF T4HLT,a ;Modo continuo activado por programa
			; sin sincronización CLK
	
	CLRF T4CLKCON,a
	BSF T4CLKCON,0,a ;Fosc/4
	BSF T4CON,7,b ;Habilitacion
	BCF PIR4,3,b
	
	
principal:
	MOVLW 9
	MOVWF T4PR,a
rebosamiento:
    
	BTFSS PIR4,3,b ;Comprobacion del bit de rebosamiento
	BRA rebosamiento
	BCF PIR4,3,b ;Restaurar rebosamiento
	 INCF valor,f,a ;Incrementa valor
	SWAPF valor,a ; intercambia bits altos por bajos para pasarlos
		   ; a los 4 altos del RA
	MOVFF valor,PORTA   ; le pasa lo que tiene a la salida
	
	bra principal
	
END mi_programa





