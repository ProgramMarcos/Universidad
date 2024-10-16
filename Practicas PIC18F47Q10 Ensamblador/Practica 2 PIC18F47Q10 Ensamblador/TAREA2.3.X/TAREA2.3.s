TITLE "EDyM P9 TAREA8_9.2.3"
    
;----------ENTRADAS--------
; Se consulta la entrada del pulsador S1->RB4
;----------SALIDAS---------
;LEDS RA4,5,6,7
    
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
global pos1,pos2
PSECT udata_acs ;reservo memoria para las variables
 pos1:
    DS 1
 pos2:
    DS 1
    
PSECT programa,abs,class=CODE,reloc=2
mi_programa:
    ORG 0x0000
    valor equ 0x00
    GOTO inicio_puertos
    NOP
ORG 0x0020
inicio_puertos:
    b1 equ 0x15
    b2 equ 0x19
    MOVLB 15
    BCF ANSELB,4,b ;RB4 digital
    CLRF PORTA,a ;todo el puerto A digital
    
    BSF TRISB,4,a   ;RB4 ENTRADA
    CLRF TRISA,a    ;todo el puerto A como salida
    
pregunta_entr:
    CLRF PORTA,a    ;apaga los led
    BTFSC   PORTB,4,a ;SI hay un 1 en RB4 ignora la siguiente instruccion
    bra pregunta_entr
    call    temporizar
    
    BTFSC   PORTB,4,a ;SI hay un 1 en RB4 ignora la siguiente instruccion
    bra pregunta_entr
    goto puls_on
puls_off:
    BTFSC   PORTB,4,a ;SI hay un 1 en RB4 ignora la siguiente instruccion
    GOTO    puls_on
    BRA	    puls_off
 puls_on:
    INCF valor,f,a ;Incrementa valor
    SWAPF valor,a ; intercambia bits altos por bajos para pasarlos
		   ; a los 4 altos del RA
    MOVFF valor,PORTA,a   ; le pasa lo que tiene a la salida
    BTFSC PORTB,4,a ;si hay un 0 ignora la siguiente instruccion
    goto pregunta_entr
    goto puls_off

temporizar:
    movlw b2
    movwf pos2,a
bucle1:
    movlw b1
    movwf pos1,a
bucle2:
    decfsz pos1,f,a
    bra bucle2
    decfsz pos2,f,a
    bra bucle1
    return
    
end mi_programa


