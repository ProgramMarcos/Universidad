TITLE "EDyM P9 TAREA8_9.1"
    
;----------ENTRADAS--------
; Se consulta la entrada del pulsador S1->RB4
;----------SALIDAS---------
;Si se pulsa s1 se apaga el LED D2->RA4 y LED D3->RA5
    
PROCESSOR 18F47Q10
    
#include <xc.inc>

;configuraci�n para despu�s de un reset
CONFIG FEXTOSC=OFF  ;no utilizo F ext de oscilaci�n
CONFIG RSTOSC=HFINTOSC_1MHZ
CONFIG LVP=ON	;deshabilitado ISCP (In-Circuit Serial Programing)
		;se habilita la programaci�n de bajo voltaje
		;la funci�n del terminal MCLR/VPP es MCLR. El bit de configuraci�n MCLRE se ignora
CONFIG WDTE=OFF
		
;se define la secci�n de memoria para el programa:
; --la secci�n se denomina mi_programa
; --las posiciones de memoria indicadas son absolutas
; --las direcciones van de dos en dos

PSECT programa,abs,class=CODE,reloc=2
mi_programa:
    ORG 0x0000
    GOTO inicio_puertos
    NOP
ORG 0x0020
inicio_puertos:
    MOVLB 15
    BCF ANSELB,4,b ;RB4 digital
    BCF ANSELA,4,b
    BCF ANSELA,5,b
    
    BSF TRISB,4,a   ;RB4 ENTRADA
    BCF TRISA,5,a
    BCF TRISA,4,a   ;RA4,RA5 SALIDAS 
    
    ;BCF LATA,4,a
    ;BCF PORTA,4,a
    ;BCF LATA,5,a
    ;BCF PORTA,5,a
    
inicio_LEDS:
    BTFSS   PORTB,4,a ;SI hay un 1 en RB4 ignora la siguiente instruccion
    GOTO    PULS_ON
PULS_OFF:
    BSF PORTA,4,a
    BCF PORTA,5,a
    BRA inicio_LEDS
PULS_ON:
    BCF PORTA,4,a
    BSF PORTA,5,a
    btfsc PORTB,4,a ;si tengo un 1
    BRA PULS_OFF
    BRA inicio_LEDS
end mi_programa
    
    


