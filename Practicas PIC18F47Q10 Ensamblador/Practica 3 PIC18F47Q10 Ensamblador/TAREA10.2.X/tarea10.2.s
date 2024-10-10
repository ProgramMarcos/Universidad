TITLE "Practica 10 tarea 2"

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
	BSF T1CON,0,a ;Habilitacion on
	
	BSF T1CON,4,a ;A 1 el bit 4 del T1CON
	BSF T1CON,5,a ;A1 el bit 5 del T1CON
	;Con esto consigo Preescalado 1/8
	
	CLRF T1CLK,a
	BSF T1CLK,0,a ;Fosc/4
	CLRF T1GCON,a ;inhibo GATE
	
	
	
bucle:
	;Recarga TMR1=34286 -> 0x85 + 0xEE
	MOVLW 0x85
	MOVWF TMR1H,a  ;recargo parte alta
	MOVLW 0xEE
	MOVWF TMR1L,a ; recargo parte baja
	BSF T1CON,0,a ;Habilitacion on
	
repet:
    
	BTFSS PIR4,0,b ;Comprobacion del bit de rebosamiento
	BRA repet
	BTG PORTA,4,a ;CONMUTA EL BIT
	BCF PIR4,0,b ;Restaurar rebosamiento
	bra bucle
	
END mi_programa


