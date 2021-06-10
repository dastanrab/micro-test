                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               #include <stdio.h>
#include <mega16.h>
#include <delay.h>
int c=0;

unsigned char i =0;
unsigned char ports[] = { 0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80 } ;
interrupt [EXT_INT0] void ext_int0_isr(void)
{

      
      if(PIND.2==1 & c==0){ 
      
      c++;
       
         for(i=0;i<8;i++)
       {
       PORTA=ports[i];
       delay_ms(30);
       PORTB=0X00;
       PORTA=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTB=ports[i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTB=ports[7-i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTA=ports[7-i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       };
    
      }
        if(PIND.2==1 & c==1)
        { 
        c++;
           for(i=0;i<8;i++)
       {
       PORTA=ports[i];
       PORTB=ports[7-i];
       delay_ms(30);
       PORTB=0X00;
       PORTA=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTB=ports[i];
       PORTA=ports[7-i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       }
        
        } 
         if(PIND.2==1 & c==2){  
        c=0;
          for(i=0;i<4;i++)
       
       {
           if(i==0){ 
           PORTA=0x0c;
           PORTB=0x30;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;
           
           
           }
           if(i==1){
           PORTA=0x0F;
           PORTB=0xF0;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==2){
           PORTA=0xCF;
           PORTB=0xF3;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==3){
           PORTA=0xFF;
           PORTB=0xFF;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
       
       }
               for(i=0;i<4;i++)
       {
           if(i==0){ 
           
           PORTA=0xFF;
           PORTB=0xFF;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;
           
           
           }
           if(i==1){
          
           PORTA=0xCF;
           PORTB=0xF3;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==2){
            PORTA=0x0F;
           PORTB=0xF0;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==3){
           PORTA=0x0c;
           PORTB=0x30;;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
       
       }
       
       
       }
       
}

void main (void) {
 
  unsigned char j =0;
  
 DDRB=0x00;
 PORTB=0X00; 
 DDRA=0x00;
 PORTA=0X00; 
 PORTC.0=0;
 DDRC.0=1;
 PORTD.0=0;
 DDRD.0=0;
 GICR=0X40;
 MCUCR=0X03;
 GIFR=0X40;
 #asm("sei")

  
   while (1)
   {   
       if(PINC.0==1)
       {
         j++;
       
        if(j==1){
          for(i=0;i<8;i++)
       {
       PORTA=ports[i];
       delay_ms(30);
       PORTB=0X00;
       PORTA=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTB=ports[i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTB=ports[7-i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTA=ports[7-i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       }
       
       }
       
        if(j==2)
        { 
           for(i=0;i<8;i++)
       {
       PORTA=ports[i];
       PORTB=ports[7-i];
       delay_ms(30);
       PORTB=0X00;
       PORTA=0X00;
       
       } 
          for(i=0;i<8;i++)
       {
       PORTB=ports[i];
       PORTA=ports[7-i];
       delay_ms(30);
       PORTA=0X00;
       PORTB=0X00;
       
       }
        
        }
       if(j==3){  
        j=0;
          for(i=0;i<4;i++)
       
       {
           if(i==0){ 
           PORTA=0x0c;
           PORTB=0x30;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;
           
           
           }
           if(i==1){
           PORTA=0x0F;
           PORTB=0xF0;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==2){
           PORTA=0xCF;
           PORTB=0xF3;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==3){
           PORTA=0xFF;
           PORTB=0xFF;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
       
       }
               for(i=0;i<4;i++)
       {
           if(i==0){ 
           
           PORTA=0xFF;
           PORTB=0xFF;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;
           
           
           }
           if(i==1){
          
           PORTA=0xCF;
           PORTB=0xF3;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==2){
            PORTA=0x0F;
           PORTB=0xF0;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
           if(i==3){
           PORTA=0x0c;
           PORTB=0x30;;
           delay_ms(40);
           PORTB=0X00;
           PORTA=0X00;}
       
       }
       
       
       }
       }

       
   }
   
   
   
   
}
                                                                                                                                                                                  