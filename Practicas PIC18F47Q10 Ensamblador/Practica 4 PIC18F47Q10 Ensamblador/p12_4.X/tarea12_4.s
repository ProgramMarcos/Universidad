TITLE " Practica 12 tarea 4"
    
    
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
    bra boton
    BANKSEL PIR1
    BSF PIE0,0,b ;permiso ext0
    BCF PIR1,0,B ;BORRAR INTERRUPCION
    BANKSEL ADCON0
    BCF ADCON0,0,B
    MOVLB 15 ;Registro 15
    
    MOVF ADRESH,W,B ;Lectura de los 8 bits menos significativos
    MOVWF LATA,A ;escribir en los leds
    bra fin_interrupcion
    
boton:
	BANKSEL PIR0
        BTFSS PIR0,0,b ;INT0?
	bra fin_interrupcion
	BCF PIR0,0,b ;borrado del flag
	BANKSEL ADCON0
	BSF ADCON0,0,B ; ADGO=1 inicio conversion
	BANKSEL PIE0
	BCF PIE0,0,B ;INHIBIR EXT0
	bra fin_interrupcion
fin_interrupcion:
    RETFIE

PSECT code abs
    ORG 0x100
   

iniciar_puertos:

    MOVLB 15 ;Registro 15
    CLRF ANSELA,B ;RA Digital
    CLRF TRISA,A ;RA salida
    
    BCF ANSELB,4,B
    BSF TRISB,4,A ;RB4 dig entrada
    
    

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

    MOVLW 11010000B ;ADCon,conversion continua, FRC, justf derecha
    MOVWF ADCON0,B

    BSF TRISA,0,A ;RA0 como entrada
    BSF ANSELA,0,B ;RA0 como analogico

    RETURN

iniciar_interrupcion:
	BANKSEL INTCON
	BCF INTCON,5,A ;niveles de prioridad
	BSF INTCON,7,A
	BSF INTCON,6,A
	
;interrupcion del CAD
	BANKSEL PIR1
	BCF PIR1,0,B
	BSF IPR1,0,b  ; int CAD prioridad alta
	BSF PIE1,0,B ;permiso para int del CAD
	
;INTERRUPCION EXTERNA
	BANKSEL INT0PPS
	MOVLW 00001100B
	MOVWF INT0PPS,b ;vinculo el RB4 a la int0
	
	BANKSEL INTCON
	BCF INTCON,0,a  ;flanco de bajada genera interrupción
    
	BANKSEL PIR0
	BCF PIR0,0,b
	BSF PIE0,0,b ;permiso ext0
	BSF IPR0,0,b  ; int0 prioridad alta
	
	RETURN
principal:
	CALL iniciar_puertos
	CALL iniciar_CAD
	CALL iniciar_interrupcion

	BRA $
END resetVec
