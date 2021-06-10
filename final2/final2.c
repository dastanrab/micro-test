/*
 * final2.c
 *
 * Created: 6/7/2021 10:27:32 AM
 * Author: DASTAN
 */

#include <io.h>
#include <mega16.h>
#include <delay.h>
unsigned char numbers[16] = {0x3F, 0x06, 0x5b, 0x4F,0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
unsigned char i=0;
unsigned char j=0;
void main(void)
{
PORTA=0;
DDRA=0;
PORTB=0;
DDRB=0;
while (1)
    {
    // Please write your application code here 
    for(i=0; i<11; i++)
        {        
         for(j=0;j<6;j++)
         {
         PORTA = numbers[i];
         PORTB = numbers[j];
            delay_ms(200);
         }
            
        }

    }
}
