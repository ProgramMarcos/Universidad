TITLE "P11 TAREA_3"
    
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
    GOTO pcpal
PSECT code abs
    ORG 0x0018
    GOTO intH
PSECT code abs
ORG 0x0100
pcpal:
    MOVLB 15
    CLRF ANSELB, B
    CLRF TRISA, A
    CLRF ANSELA, B
    CLRF LATA, A
    
    
    
    MOVLW 0B00001100
    MOVWF INT0PPS, B
    MOVLW 0B11000110
    MOVWF INTCON, A
    MOVLW 0B00100001
    MOVWF PIE0, B
    CLRF IPR0, B
    
     BSF T0CON0, 4, A ;se configura pero no se arranca aún
    BSF T0CON1, 6, A
    
intH:
    BTFSS PIR0,0,b ;INT0?
    RETFIE
    GOTO ext0
    BTFSS PIR0,5,b ;TMR0IF?
    RETFIE
    GOTO T0
    
ext0:
    MOVLW 0XFB
    MOVWF TMR0H, A
    MOVLW 0X1E
    MOVWF TMR0L, A
    BSF T0CON0, 7, A
    BCF PIE0, 0, B  ;inhibir interrupción
    BCF PIR0, 0, B
    RETFIE  ;Regresar a la rutina principal y habilitar la llamada a nuevas subrutinas
    
T0:
  
     BTFSS PORTB, 4, A
    BTG LATA, 4, A
    BCF PIE0, 5, B
    BCF PIR0, 0, B
    BSF PIE0, 0, B
    BCF PIR0, 5, B
    BCF T0CON0, 7, A ;para que no corra contador y produzca interrupciones
    BSF PIE0, 5, B  ;esto habría que ponerlo porque si no ya no funciona más aunque no lo dice?????
    RETFIE
    
END mi_programa


