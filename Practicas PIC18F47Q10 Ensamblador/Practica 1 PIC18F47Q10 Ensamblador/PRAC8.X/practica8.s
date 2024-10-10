TITLE "EDyM P8 TAREA8_6"
    
;----------ENTRADAS--------
; Se consulta la entrada del pulsador S1->RB4
;----------SALIDAS---------
;Si se pulsa s1 se apaga el LED D2->RA4
    
PROCESSOR 18F47Q10
    
#include <xc.inc>

;configuración para después de un reset
CONFIG FEXTOSC=OFF  ;no utilizo F ext de oscilación
CONFIG RSTOSC=HFINTOSC_1MHZ
CONFIG LVP=ON	;deshabilitado ISCP (In-Circuit Serial Programing)
		;se habilita la programación de bajo voltaje
		;la función del terminal MCLR/VPP es MCLR. El bit de configuración MCLRE se ignora
CONFIG WDTE=OFF
		
;se define la sección de memoria para el programa:
; --la sección se denomina mi_programa
; --las posiciones de memoria indicadas son absolutas
; --las direcciones van de dos en dos

PSECT programa,abs,class=CODE,reloc=2
mi_programa:
    ORG 0x0000
    GOTO inicio
    NOP
ORG 0x0020
inicio:
    MOVLB   15
    BCF	    ANSELA,4,b
    BCF	    ANSELB,4,b
    
    BCF	    TRISA,4,a
    BSF	    TRISB,4,a
    
    BCF	    LATA,4,a
    BCF	    PORTA,4,a
    
bucle:
    BTFSC   PORTB,4,a
    GOTO    es_uno
    
es_cero:
    BCF	    PORTA,4,a
    BRA	    bucle
    
es_uno:
    BSF	    PORTA,4,a
    BRA	    bucle
END mi_programa


