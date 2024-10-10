TITLE "Práctica 11, tarea 11.2"
    PROCESSOR 18F47Q10
    #include <xc.inc>
    CONFIG FEXTOSC = OFF
    CONFIG RSTOSC = HFINTOSC_1MHZ
    CONFIG LVP = ON
    CONFIG WDTE = OFF
   
    PSECT code, abs

ORG 0X0
resetVec:
    GOTO inicializacion
   
ORG 0X8
alta_prioridad:
    MOVLW 0XFB
    MOVWF TMR0H, A
    MOVLW 0X1E
    MOVWF TMR0L, A
    BSF T0CON0, 7, A
    BCF PIE0, 0, B  ;inhibir interrupción
    BCF PIR0, 0, B
    RETFIE  ;Regresar a la rutina principal y habilitar la llamada a nuevas subrutinas
   
ORG 0X18
baja_prioridad:
    BTFSS PORTB, 4, A
    BTG LATA, 4, A
    BCF PIE0, 5, B
    BCF PIR0, 0, B
    BSF PIE0, 0, B
    BCF PIR0, 5, B
    BCF T0CON0, 7, A ;para que no corra contador y produzca interrupciones
    BSF PIE0, 5, B  ;esto habría que ponerlo porque si no ya no funciona más aunque no lo dice?????
    RETFIE
   
ORG 0X30
inicializacion:
   
    ;configuración interrupciones
    BANKSEL INT0PPS
    MOVLW 0B00001100
    MOVWF INT0PPS, B
    MOVLW 0B11100110
    MOVWF INTCON, A
    MOVLW 0B00000001
    MOVWF IPR0, B
    MOVLW 0B00100001
    MOVWF PIE0, B
   
    ;configuración puertos
    BANKSEL ANSELB
    CLRF ANSELB, B
    CLRF TRISA, A
    CLRF ANSELA, B
    CLRF LATA, A
   
    ;configuración temporizador
    BSF T0CON0, 4, A ;se configura pero no se arranca aún
    BSF T0CON1, 6, A
   
    BANKSEL PIE0
   
espera_interrupcion:
    GOTO espera_interrupcion