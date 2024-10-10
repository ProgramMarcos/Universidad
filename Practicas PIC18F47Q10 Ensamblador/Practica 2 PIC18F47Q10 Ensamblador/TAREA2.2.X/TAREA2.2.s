TITLE "EDyM P9 TAREA8_9.2.2"
    
;----------ENTRADAS--------
; Se consulta la entrada del pulsador S1->RB4
;----------SALIDAS---------
;LEDS RA4,5,6,7
    
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
    valor equ 0x00
    GOTO inicio_puertos
    NOP
ORG 0x0020
inicio_puertos:
    MOVLB 15
    BCF ANSELB,4,b ;RB4 digital
    CLRF PORTA,a ;todo el puerto A digital
    
    BSF TRISB,4,a   ;RB4 ENTRADA
    CLRF TRISA,a    ;todo el puerto A como salida
pregunta_entr:
    BTFSS   PORTB,4,a ;SI hay un 1 en RB4 ignora la siguiente instruccion
    GOTO    PULS_ON
    bra pregunta_entr
PULS_OFF:
    BTFSC   PORTB,4,a ;SI hay un 1 en RB4 ignora la siguiente instruccion
    GOTO    PULS_ON
    BRA	    PULS_OFF
    
PULS_ON:
    INCF valor,f,a ;Incrementa valor
    SWAPF valor,a
    MOVFF valor,PORTA
    
    BTFSC PORTB,4,a
    BRA pregunta_entr
    BRA PULS_OFF
end mi_programa
    


