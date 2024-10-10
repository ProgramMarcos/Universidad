/* 
 * File:   main.c
 * Author: Marcos
 *
 * Created on 2 de febrero de 2023, 15:45
 */

#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#ifndef _XTAL_FREQ
#define _XTAL_FREQ 4000000
#endif
#pragma config FEXTOSC=OFF, RSTOSC=HFINTOSC_1MHZ, LVP=ON, WDTE=OFF
float velocidad_act=0;
void configuraPA(){
    ANSELA=0; //puerto A en digital
    TRISA=0; //puerto A como salidas
}
void configuraAD(){
    ADCON1=0;
    ADCON2=0; //modo basico
    ADCON3=0; //no funciones matematicas
    ADREF=0; //referencias de convetidor, positiva=Vdd, negativa=Vss
    ADPCH=0; //selecion de ANA0 como entrada para el CAD
    ADACQ=0; //tiempo de adquisicion controlado por programa
    ADRPT=0; //conversion unica
    ADACT=0; //No disparo externo
    ADCON0=0x94; //justificacion a la derecha, permiso de funcionamiento y reloj FRC
    TRISA=0x01; //canal A.0 (ANA0 o RA0) como entrada, resto del puerto salida
    ANSELA=0x01;//canal A.0 como entrada analogica
    ADCON0=0x95; //inicia la conversion
}
void configuraT3(){
    T3CLK=0x01; //temporizador funcionando a f/4
    T3CON=0xF2; //divisor de frecuencia 8, lec y escr de 16 bits
    T3GCON=0; //inhibida funcion GATE
    TMR3H=0x0B; //carga valor 3036
    TMR3L=0xDC;
    T3CONbits.ON=1; //permiso de funcionamient0
}
void configuraT1(){
    T1CLK=0x00; //temporizador funcionando como contador
    T1CON=0x22; //divisor a 4  +  16bits lectura/escritura  
    CCP1PPS=0X10; //apunto a RC0
    T1GCON=0; //inhibida funcion GATE
    TMR1H=0; //carga valor 0
    TMR1L=0;
}
void configuraPWM(){
    LATCbits.LATC1=0;
    TRISCbits.TRISC1=0; //configura el terminal del modulo CCP como salida
    ANSELCbits.ANSELC1=0;
    RC1PPS=0x06; //RC1->CCP2
    
    CCP2CON=0; //se inicializa a 0 el registro de control
    CCP2CONbits.CCP2MODE=12; //se establece el modo PWM en la unidad CCP
    CCPTMRSbits.C2TSEL=1; //se selecciona el timer 2
    
    T2CLKCON=1; //T2CS FOSC/4
    T2PR=0xFF; //pwm periodo
    T2CON=0x80; //prescalado=1 postescalado=1 encendido temporizador 2
    CCP2CONbits.CCP2EN=1; //habilitacion de la unidad
}

void mostrarleds(){
    if (ADCON0bits.GO==0){ //si termino la conversion
        LATA=velocidad_act; //muestra en la salida los leds
        

        CCPR2H=ADRESH; //guarda los bits mas significativos del CAD
        CCPR2L=ADRESL;  //guarda los bits menos significativos*/
    }
}

void __interrupt(high_priority) interrupciones(void){
    if (PIR4bits.TMR3IF==1){
        T1CONbits.ON=0;
        TMR3H=0x0B; //carga valor 3036 en el temporizador
        TMR3L=0xDC;
        PIR4bits.TMR3IF=0; //se pone a 0 el flag del timer3
        velocidad_act=TMR1;
        TMR1H=0; //carga valor 0
        TMR1L=0;
        TMR3H=0x0B; //carga valor 3036
        TMR3L=0xDC;
        T1CONbits.ON=1;
        mostrarleds();
        
        ADCON0bits.GO=1;  //reinicia el CAD
    }
}

int main(int argc, char** argv) {
    configuraPA();
    configuraAD();
    configuraT3();
    configuraT1();
    configuraPWM();
    
    INTCONbits.IPEN=1; //PERMISO PRIORIDADES
    INTCONbits.GIEH=1; //habilita interrupciones de alta prioridad
    IPR4bits.TMR3IP=1; //prioridad alta para timer3
    PIR4bits.TMR3IF=0; //se pone a 0 el flag del timer3
    PIE4bits.TMR3IE=1; //habilitacion de interrupciones para timer3
    
    while(1){
        continue;
    }
    return (EXIT_SUCCESS);
}

