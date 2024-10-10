TITLE " Practica 12 tarea 2"
    
    
#include <xc.inc>

CONFIG FEXTOSC=OFF
CONFIG RSTOSC=110
CONFIG LVP=ON
CONFIG WDTE=OFF

PSECT resetVec,class=CODE,reloc=2

resetVec:
GOTO principal

PSECT code abs
ORG 0x100

ini_ports:

    MOVLB 15 ;Registro 15
    CLRF ANSELA,B ;RA Digital
    CLRF TRISA,A ; RA salida
    
    BCF ANSELB,4,B
    BSF TRISB,4,A ;RB4 dig entrada

    RETURN

ini_CAD:

    MOVLB 15 ; Registro 15
    CLRF ADCON1,B
    CLRF ADCON2,B
    CLRF ADCON3,B
    
    CLRF ADPCH,b ;AL MISMO TIEMPO YA ESTOY SELECCIONANDO 
		    ;EL CANAL ANA0
    CLRF ADREF,b ;tensiones de ref Vdd y Vss
    CLRF ADACQ,b ;tiempo adquisicion control por programa
    CLRF ADCAP,b ;valor por defecto del condensador del S&H
    CLRF ADRPT,b ;conversion unica
    CLRF ADACT,b ;sin disparo externo
    
    MOVLW 00001100B
    MOVWF ADACQ,b ;12 TAD

    MOVLW 10010100B ;ADCon, FRC, justf derecha
    MOVWF ADCON0,b

    bsf TRISA,0,a
    bsf ANSELA,0,b ;RA0 entr analógica
    RETURN

principal:
    CALL ini_ports
    CALL ini_CAD
    
bucle:
    BTFSC PORTB,4,A ;RB4?
    BRA bucle
bucle1:
    BTFSS PORTB,4,A
    bra bucle1
    BRA conversion
conversion:
	MOVLB 15 ; Registro 15
	BSF ADCON0,0,B ; ADGO=1 inicio conversion
fin_conversion:
	BTFSC ADCON0,0,B ;Final de la conversion?
	bra fin_conversion
	
	MOVF ADRESL,W,B ;8 bits menos signif al acumulador
	SWAPF WREG,A ;intercambio parte alta y baja
	MOVWF LATA,A ;escribir en los leds
	
	BRA bucle
	
END resetVec
	

