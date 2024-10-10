TITLE "Practica 10 tarea 1"

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
	
	
	CLRF TRISA,a  ;puerto A salida
	CLRF ANSELA,b ;digital
	
	BSF TRISD,0,b ;RC0 entrada
	BCF ANSELD,0,b ;Digital
	
	MOVLW 0x18
	MOVWF T1CKIPPS,a ;RD0 ENTRADA

	MOVLW 14  ;BANCO 14
	MOVWF BSR,a
	
	BSF T1CON,0,a ;Habilitacion on
	BCF PIR4,0,b ;Borrar Rebosamiento para evitar interrupcion
	;(borrado de flag)
	
	
bucle:
	MOVLW 0xFF
	MOVWF TMR1H,a  ;recargo parte alta
	MOVLW 0xF6
	MOVWF TMR1L,a ; recargo parte baja
	;BSF T1CON,0,a
rebosamiento:
    
	BTFSS PIR4,0,b ;Comprobacion del bit de rebosamiento
	BRA rebosamiento
	BCF PIR4,0,b ;Restaurar rebosamiento
	INCF PORTA,f,a ;Incremento PORTA
	bra bucle
	
END mi_programa



