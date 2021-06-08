/////////////////////////////////////////////////////////
//    SEL0629 - Aplicações de Microprocessadores I     //
//    Prática 1                                        //
//    Nome: Mateus Fernandes Doimo                     //
//    NUSP: 10691971                                   //
/////////////////////////////////////////////////////////

void interrupt_high() iv 0x0008 ics ICS_AUTO {
     if(TMR0IF_bit){
         if(LATB > 8){LATB = 0;}
         else{LATB++;}
     }
     TMR0IF_bit = 0;
     return;
}
void main() {

     ADCON1 = 0x0F;         // Configurando as portas como digital
     
     TRISA.TRISA0 = 1;      // RA0 como entrada para o btn de 1s
     TRISA.TRISA1 = 1;      // RA1 como entrada para o btn de 0.25s
     
     TRISB = 0x0;           // Todas as portas B como saída
     LATB = 0x0;            // Zera a saída
      
     INTCON = 0b10100000;   // Interrupção
     
     // Timer
     // 0.25 = (2^16 - x) * 0.5 * 10^-6 * 8
     // x = 3036
     
     TMR0H = 0x0B;          // Timer 0 High
     TMR0L = 0xDC;          // Timer 0 Low
     T0CON = 0b00000010;    // Config Timer 0
     
     while(1){
         if(PORTA.RA0 == 0){
             T0CON = 0b10000100;      // Timer prescaler 1:32
         }
         else if(PORTA.RA1 == 0){
             T0CON = 0b10000010;     // Timer prescaler 1:8
         }
     }
}