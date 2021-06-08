#line 1 "D:/Graduação/SEL0629 - Aplicações de Microprocessadores I/Práticas/Lab 1/Lab1.c"







void interrupt_high() iv 0x0008 ics ICS_AUTO {
 if(TMR0IF_bit){
 if(LATB > 8){LATB = 0;}
 else{LATB++;}
 }
 TMR0IF_bit = 0;
 return;
}
void main() {

 ADCON1 = 0x0F;

 TRISA.TRISA0 = 1;
 TRISA.TRISA1 = 1;

 TRISB = 0x0;
 LATB = 0x0;

 INTCON = 0b10100000;





 TMR0H = 0x0B;
 TMR0L = 0xDC;
 T0CON = 0b00000010;

 while(1){
 if(PORTA.RA0 == 0){
 T0CON = 0b10000100;
 }
 else if(PORTA.RA1 == 0){
 T0CON = 0b10000010;
 }
 }
}
