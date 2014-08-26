#include <mega32.h>
#include <sdcard.h>
#include <stdio.h>
#include <delay.h>


interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
disk_timerproc();    /* Drive timer procedure of low level disk I/O module */
}
void usart_init(){
// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: Off
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x08;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x33;
} 
void status(unsigned char st){
if(st & RES_OK) printf("success\n\r");
else
if(st & RES_ERROR) printf("a write error occured\n\r");
else
if(st & RES_WRPRT) printf("the MMC/SD/SD HC card is write protected\n\r");
else
if(st & RES_NOTRDY) printf("the disk drive has not been initialized\n\r");
else
if(st & RES_PARERR) printf("invalid parameters were passed to the function\n\r");
}
    
//Drv mmc;
unsigned char r;
unsigned char buffer[512];
unsigned char i;
unsigned long int sector_count;
void main(){
    OCR1A = 7813;        // Timer1: 100Hz interval (OCR1A)
    TCCR1A = 0x00;
    TCCR1B = 0x0D;
    TIMSK=0x10;    
    DDRB=1;

    #asm("sei") 
    usart_init();
    r=disk_initialize(0);    
   
   if (r & STA_NOINIT) printf("\nDisk init failed\n\r"); 
   else
   if (r & STA_NODISK) printf("\nCard not present\n\r");
   else
   if (r & STA_PROTECT) printf("\nCard write\nprotected\n\r");
   /* all status flags are 0, disk initialization OK */
   else printf("\nInit OK\n\r");
   delay_ms(2000); 
   //while(1);
   
   for(i=0;i<=100;i++){
    buffer[i]=i;
    }
   status(disk_write(0,buffer,1000,1)); 
   
   for(i=0;i<=100;i++){
    buffer[i]=0;
    }                       
    
   status(disk_read(0,buffer,1000,1));
   
   printf("\ndata=%d\n",buffer[20]);

   
   while(1);
   
}