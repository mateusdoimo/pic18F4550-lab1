
_interrupt_high:

;Lab1.c,8 :: 		void interrupt_high() iv 0x0008 ics ICS_AUTO {
;Lab1.c,9 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt_high0
;Lab1.c,10 :: 		if(LATB > 8){LATB = 0;}
	MOVF        LATB+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_high1
	CLRF        LATB+0 
	GOTO        L_interrupt_high2
L_interrupt_high1:
;Lab1.c,11 :: 		else{LATB++;}
	MOVF        LATB+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LATB+0 
L_interrupt_high2:
;Lab1.c,12 :: 		}
L_interrupt_high0:
;Lab1.c,13 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Lab1.c,14 :: 		return;
;Lab1.c,15 :: 		}
L_end_interrupt_high:
L__interrupt_high9:
	RETFIE      1
; end of _interrupt_high

_main:

;Lab1.c,16 :: 		void main() {
;Lab1.c,18 :: 		ADCON1 = 0x0F;         // Configurando as portas como digital
	MOVLW       15
	MOVWF       ADCON1+0 
;Lab1.c,20 :: 		TRISA.TRISA0 = 1;     // RA0 como entrada para o btn de 1s
	BSF         TRISA+0, 0 
;Lab1.c,21 :: 		TRISA.TRISA1 = 1;     // RA1 como entrada para o btn de 0.25s
	BSF         TRISA+0, 1 
;Lab1.c,23 :: 		TRISB = 0x0;           // Todas as portas B como saída
	CLRF        TRISB+0 
;Lab1.c,24 :: 		LATB = 0x0;            // Zera a saída
	CLRF        LATB+0 
;Lab1.c,26 :: 		INTCON = 0b10100000;   // Interrupção
	MOVLW       160
	MOVWF       INTCON+0 
;Lab1.c,32 :: 		TMR0H = 0x0B;          // Timer 0 High
	MOVLW       11
	MOVWF       TMR0H+0 
;Lab1.c,33 :: 		TMR0L = 0xDC;          // Timer 0 Low
	MOVLW       220
	MOVWF       TMR0L+0 
;Lab1.c,34 :: 		T0CON = 0b00000010;    // Config Timer 0
	MOVLW       2
	MOVWF       T0CON+0 
;Lab1.c,36 :: 		while(1){
L_main3:
;Lab1.c,37 :: 		if(PORTA.RA0 == 0){
	BTFSC       PORTA+0, 0 
	GOTO        L_main5
;Lab1.c,38 :: 		T0CON = 0b10000100;      // Timer prescaler 1:64
	MOVLW       132
	MOVWF       T0CON+0 
;Lab1.c,39 :: 		}
	GOTO        L_main6
L_main5:
;Lab1.c,40 :: 		else if(PORTA.RA1 == 0){
	BTFSC       PORTA+0, 1 
	GOTO        L_main7
;Lab1.c,41 :: 		T0CON = 0b10000010;     // Timer prescaler 1:16
	MOVLW       130
	MOVWF       T0CON+0 
;Lab1.c,42 :: 		}
L_main7:
L_main6:
;Lab1.c,43 :: 		}
	GOTO        L_main3
;Lab1.c,44 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
