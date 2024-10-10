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

PSECT programa,abs,class=CODE,reloc=2
programa_demo:
    ORG 0x0000
    GOTO inicio
    NOP
ORG 0X0020
inicio:
	bsf TRISB,4,0 ;bit de entrada rb4
	clrf TRISA,0 ;bit de salida del RA6
	clrf WREG,b 
	clrf LATA,0
	MOVFF WREG,ANSELB
lazo:
	btfss PORTB,4,0 ;consulta el bit de entrada del RB4
	bra lazo
incremento:
	incf LATA,1,0
	bra lazo
END programa_demo


