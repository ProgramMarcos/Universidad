TITLE "P11 TAREA_2"
    
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
    ORG 0x0008
    CALL intH
    ORG 0x0018
    CALL intL

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
    
    BCF INTCON,0,a  ;flanco de bajada genera interrupción
    BSF PIE0,0,b  ; permiso para int externa 0
    BSF IPR0,0,b  ; int0 prioridad alta
    
    CLRF T0CON0,a ;reset TIMER 0 reg 0
    BSF T0CON0,4,a ;modo rebosabiento 16 bits
    CLRF T0CON1,a ;reset timer 0 REG 1
    BSF T0CON1,6,a ;Fosc/4
    BCF IPR0,5,b ;prioridad baja a la interrupcion por rebosamiento del timer0
    
    MOVLW 0xFB
    MOVWF TMR0H,a ;recarga parte alta
    MOVLW 0x1E
    MOVWF TMR0L,a ;recarga parte baja
    
    BSF INTCON,5,a ;Habilito los niveles de prioridad
    BSF INTCON,6,a ;Interrup de baja prioridad
    BSF INTCON,7,a ;interrupciones de alta prioridad
    BRA $
    
intH:
    MOVLW 0XFB
    MOVWF TMR0H, A
    MOVLW 0X1E
    MOVWF TMR0L, A
    BSF T0CON0, 7, A
    BCF PIE0, 0, B  ;inhibir interrupción
    BCF PIR0, 0, B
    RETFIE  ;Regresar a la rutina principal y habilitar la llamada a nuevas subrutinas
   
    
intL:
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
    


