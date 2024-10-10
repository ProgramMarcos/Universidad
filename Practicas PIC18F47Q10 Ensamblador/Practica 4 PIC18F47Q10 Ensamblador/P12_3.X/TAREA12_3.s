TITLE " Practica 12 tarea 3"
    
    
#include <xc.inc>

CONFIG FEXTOSC=OFF
CONFIG RSTOSC=110
CONFIG LVP=ON
CONFIG WDTE=OFF

PSECT resetVec,class=CODE,reloc=2

resetVec:
GOTO principal

;Interrupcion con prioridad alta
PSECT code abs
ORG 0X008
MOVLB 14 ;Registro 14
    BTFSS PIR1,0,B  ;ADIF?
    BRA fin_interrupcion

    BCF PIR1,0,B ;BORRAR INTERRUPCION
    MOVLB 15 ;Registro 15

    MOVF ADRESL,W,B ;Lectura de los 8 bits menos significativos
    SWAPF WREG,A ;intercambio parte alta y baja
    MOVWF LATA,A ;escribir en los leds
fin_interrupcion:
    RETFIE

PSECT code abs
    ORG 0x100

iniciar_puertos:

    MOVLB 15 ;Registro 15
    CLRF ANSELA,B ;RA Digital
    CLRF TRISA,A ;RA salida

    RETURN

iniciar_CAD:
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

    MOVLW 11010100B ;ADCon,conversion continua, FRC, justf derecha
    MOVWF ADCON0,B

    BSF TRISA,0,A ;RA0 como entrada
    BSF ANSELA,0,B ;RA0 como analogico

    RETURN

iniciar_interrupcion:
	BANKSEL INTCON
	BCF INTCON,5,A ;niveles de prioridad
	BSF INTCON,7,A
	BSF INTCON,6,A
	
	BANKSEL PIR1
	BCF PIR1,0,B
	BSF PIE1,0,B ;permiso para int del CAD
	
	RETURN
principal:
	CALL iniciar_puertos
	CALL iniciar_CAD
	CALL iniciar_interrupcion

conversion:
	MOVLB 15 ; Registro 15
	BSF ADCON0,0,B ;INICIO CONVERSION
	BRA $
END resetVec
