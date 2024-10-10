TITLE "P12 tarea 1"
#include <xc.inc>
CONFIG FEXTOSC=OFF
CONFIG RSTOSC=HFINTOSC_1MHZ
CONFIG WDTE=OFF
PSECT resetVec,class=CODE,reloc=2

resetVec:
    GOTO pcpal

PSECT code abs
    ORG 0X100
ini_ports:
   
     ;configuración puertos
    BANKSEL ANSELA
    ;CLRF ANSELA,b
    ;CLRF TRISA,a
    
    BCF ANSELA,7,b
    BCF TRISA,7,a ;RA7 salida digital
    BCF ANSELA,6,b
    BCF TRISA,6,a ;RA6 salida digital
    BCF ANSELA,5,b
    BCF TRISA,5,a ;RA5 salida digital
    BCF ANSELA,4,b
    BCF TRISA,4,a ;RA4 salida digital
    RETURN
    
ini_CAD:
    ;reseteo de los registros
    BANKSEL ADCON1
    CLRF ADCON1,b
    CLRF ADCON2,b
    CLRF ADCON3,b
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

    
pcpal:
    call ini_ports
    call ini_CAD

conversion:
    MOVLB 15
    BSF ADCON0,0,b ;ADGO=1 inicio conversion

fin_conversion:
    BTFSC ADCON0,0,B ;Final de la conversion?
    bra fin_conversion

    MOVF ADRESL,W,B ;8 bits menos signif al acumulador
    SWAPF WREG,A ;intercambio parte alta y baja
    MOVWF LATA,A ;escribir en los leds


    BRA conversion
   
END resetVec

