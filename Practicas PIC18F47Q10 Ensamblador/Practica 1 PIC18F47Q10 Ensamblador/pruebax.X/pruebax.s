TITLE "EDyM Practica 8 tarea8_1"
PROCESSOR 18F47Q10
#include <xc.inc>
    
;configuración para después de un reset
CONFIG FEXTOSC=OFF  ;no utilizo F ext de oscilación
CONFIG RSTOSC=HFINTOSC_1MHZ
CONFIG LVP=ON	;deshabilitado ISCP (In-Circuit Serial Programing)
		;se habilita la programación de bajo voltaje
		;la función del terminal MCLR/VPP es MCLR. El bit de configuración MCLRE se ignora
CONFIG WDTE=OFF

etiqueta    EQU	13 ;Etiqueta cuyo nombre se asocia con el num 13
    
GLOBAL valor1,valor2 ;declaración de var globales
    
PSECT udata_acs ;se reserva memoria de datos para las variables
 valor1:
    DS 1 ;Se reserva un byte
 valor2:
    DS 1 ;Se reserva un byte

;se define la sección de memoria para el programa
;   --La sección se denomina mi_programa
;   --las posiciones de memoria indicadas son absolutas
;   --las direcciones van de dos en dos
PSECT programa,abs,class=CODE,reloc=2
mi_programa:
    ORG 0x0000
    GOTO inicio
    NOP
    
    ORG 0x0020
inicio:
    MOVLW   etiqueta
    MOVWF   valor1
    DECF    WREG,w,a
    MOVWF   valor2
    NOP
    CLRF    WREG
    MOVWF   valor1
bucle:
    ADDWF   valor1,f,a
    INCF    WREG,w,a
    NOP
    BRA	    bucle
END mi_programa
    


