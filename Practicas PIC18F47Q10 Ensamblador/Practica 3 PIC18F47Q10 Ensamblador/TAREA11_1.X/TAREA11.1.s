TITLE "P11 TAREA_1"
    
;----------ENTRADAS--------
; Se consulta la entrada del pulsador S1->RB4
;----------SALIDAS---------
;Si se pulsa s1 se apaga el LED D2->RA4 
    
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
    GOTO pcpal
PSECT code abs
    ORG 0x0008
    CALL intH

PSECT code abs
ORG 0x0030
pcpal:
    MOVLB 15
    BCF ANSELB,4,b ;RB4 digital
    BCF ANSELA,4,b
    
    BSF TRISB,4,a   ;RB4 ENTRADA
    BCF TRISA,4,a   ;RA4 SALIDA 
    
    
    
    MOVLB 14 ;me muevo al banco 14
    MOVLW 00001100B
    MOVWF INT0PPS,b ;vinculo el RB4 a la int0
    
    BCF INTCON,0,a  ;flanco de bajada genera interrupci�n
    BSF PIE0,0,b  ; permiso para int externa 0
    
    BSF INTCON,5,a ;Habilito los niveles de prioridad
    BSF INTCON,7,a ;interrupciones de alta prioridad
    BRA $
    
intH:
    BTFSS PIR0,0,b
    RETFIE
    BTG LATA,4,a
    BCF PIR0,0,b
    RETFIE
END mi_programa
    


