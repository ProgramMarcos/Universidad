TITLE "P11 TAREA_4 Grupo6"
    
;----------ENTRADAS--------
; Se consulta la entrada del pulsador S1->RB4
;----------SALIDAS---------
;Si se pulsa s1 se apaga el LED D2->RA4 
;			    LED D3->RA5
;			    LED D4->RA6
;			    LED D5->RA7
		
PROCESSOR 18F47Q10    
#include <xc.inc>
CONFIG FEXTOSC=OFF  
CONFIG RSTOSC=HFINTOSC_1MHZ
CONFIG LVP=ON			
CONFIG WDTE=OFF
		
valor equ 0x00
GLOBAL vez
PSECT udata_acs
 vez:
    DS 1

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
    CLRF ANSELA,b
    
    BSF TRISB,4,a   ;RB4 ENTRADA
    CLRF TRISA,a   ;RA(0:7) SALIDA 
    
    MOVLW 0x00
    MOVWF vez,a
    
    
    MOVLB 14 ;me muevo al banco 14
    MOVLW 00001100B
    MOVWF INT0PPS,b ;vinculo el RB4 a la int0
    
    BCF INTCON,0,a  ;flanco de bajada genera interrupción
    BSF PIE0,0,b  ; permiso para int externa 0
    BSF IPR0,0,b  ; int0 prioridad alta
    
    CLRF T2CON,a
    MOVLW 01111111B
    MOVWF T2CON,a ;preesc=1/128  postesc=1/16
    CLRF T2HLT,a ;Modo continuo activado por programa
			; sin sincronización CLK
    CLRF T2CLKCON,a
    BSF T2CLKCON,0,a ;Fosc/4
    BSF T2CON,7,a ;Habilitacion
    
    BSF INTCON,5,a ;Habilito los niveles de prioridad
    BSF INTCON,7,a ;interrupciones de alta prioridad
    
    MOVLW 0
    MOVWF vez,a
    
principal:
    MOVLW 60
    MOVWF T2PR,a
T2:   
    BTFSS PIR4,1,b ;Comprobacion del bit de rebosamiento
    BRA T2
    
    BCF PIR4,1,b
    BTFSC vez,0
    DECFSZ valor,f,a 
    INCFSZ valor,f,a
    
    SWAPF valor,a
    MOVFF valor,PORTA
    BRA principal
    
intH:
    BTFSS PIR0,0,b ;INT0?
    RETFIE
    
    BCF PIR0,0,b ;borrado del flag

    BTFSC vez,0
    CLRF vez,0
    
    MOVLW 0x01
    MOVWF vez,0
    RETFIE
    
    
END mi_programa



