TITLE "Práctica 11, tarea 11.3"
    PROCESSOR 18F47Q10
    #include <xc.inc>
    CONFIG FEXTOSC = OFF
    CONFIG RSTOSC = HFINTOSC_1MHZ
    CONFIG LVP = ON
    CONFIG WDTE = OFF
   
    PSECT code, abs

ORG 0X0
resetVec:
    GOTO inic
   
ORG 0X18
INT:
   
    BTFSC PIR0, 0, B
    GOTO ext0
    BTFSC PIR0, 5, B
    GOTO t0
    salida:
    RETFIE
    
    
    ext0:
    MOVLW 0XFB
    MOVWF TMR0H, A
    MOVLW 0X1E
    MOVWF TMR0L, A
    BSF T0CON0, 7, A
    BCF PIE0, 0, B  ;inhibir interrupción
    BCF PIR0, 0, B
    RETFIE  ;Regresar a la rutina principal y habilitar la llamada a nuevas subrutinas
   
    t0:
    BTFSS PORTB, 4, A
    BTG LATA, 4, A
    BCF PIE0, 5, B
    BCF PIR0, 0, B
    BSF PIE0, 0, B
    BCF PIR0, 5, B
    BCF T0CON0, 7, A ;para que no corra contador y produzca interrupciones
    BSF PIE0, 5, B  
    RETFIE
   
ORG 0X100
inic:
   
     ;configuración puertos
    BANKSEL ANSELB
    CLRF ANSELB, B
    CLRF TRISA, A
    CLRF ANSELA, B
    CLRF LATA, A
    
    
    ;configuración interrupciones
    BANKSEL INT0PPS
    MOVLW 0B00001100
    MOVWF INT0PPS, B ;RB4 ENTRADA
    MOVLW 0B11000110
    MOVWF INTCON, A
    MOVLW 0B00100001
    MOVWF PIE0, B
    CLRF IPR0, B
   
   
   
    ;configuración temporizador
    BSF T0CON0, 4, A 
    BSF T0CON1, 6, A
   
    BANKSEL PIE0
    BRA $


