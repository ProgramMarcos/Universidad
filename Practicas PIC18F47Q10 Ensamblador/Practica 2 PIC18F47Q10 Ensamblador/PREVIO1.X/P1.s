TITLE "EDyM P9 previo"
    

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

GLOBAL bucle2,bucle1		
PSECT udata_acs
bucle1:
    DS 1
bucle2:
    DS 1
    
PSECT programa,abs,class=CODE,reloc=2
mi_programa:
    ORG 0x0000
    GOTO inicio
    NOP
ORG 0x0020
inicio:
    MOVLW 5
    MOVWF bucle2,a
ini_bucle2:   
    MOVLW 250
    MOVWF bucle1,a
ini_bucle1:
    DECFSZ bucle1,a
    BRA ini_bucle1
    DECFSZ bucle2,a
    BRA ini_bucle2



