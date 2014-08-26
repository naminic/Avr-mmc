
#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADCSR=6;     
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb OCR0=0X3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
#endasm

typedef unsigned char DSTATUS;

typedef enum {
RES_OK = 0,		
RES_ERROR,		
RES_WRPRT,		
RES_NOTRDY,		
RES_PARERR		
} DRESULT;

DSTATUS disk_initialize (unsigned char drv);
DSTATUS disk_status (unsigned char drv);
DRESULT disk_read (unsigned char drv, unsigned char* buff, unsigned long sector, unsigned char count);
DRESULT disk_write (unsigned char drv, const unsigned char* buff, unsigned long sector, unsigned char count);
DRESULT disk_ioctl (unsigned char drv, unsigned char ctrl, void* buff);
void disk_timerproc (void);

#pragma library sdcard.lib

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
int printf(char flash *fmtstr,...);
int sprintf(char *str, char flash *fmtstr,...);
int vprintf(char flash * fmtstr, va_list argptr);
int vsprintf(char *str, char flash * fmtstr, va_list argptr);

char *gets(char *str,unsigned int len);
int snprintf(char *str, unsigned int size, char flash *fmtstr,...);
int vsnprintf(char *str, unsigned int size, char flash * fmtstr, va_list argptr);

int scanf(char flash *fmtstr,...);
int sscanf(char *str, char flash *fmtstr,...);

typedef char XCHAR;		

typedef struct _FATFS_ {
unsigned char	fs_type;	
unsigned char	drive;		
unsigned char	csize;		
unsigned char	n_fats;		
unsigned char	wflag;		
unsigned char	fsi_flag;	
unsigned short	id;		
unsigned short	n_rootdir;	
unsigned long	last_clust;	
unsigned long	free_clust;	
unsigned long	fsi_sector;	
unsigned long	cdir;		
unsigned long	sects_fat;	
unsigned long	max_clust;	
unsigned long	fatbase;	
unsigned long	dirbase;	
unsigned long	database;	
unsigned long	winsect;	
unsigned char	win[512];
} FATFS;

typedef struct _DIR_ {
FATFS*	fs;			
unsigned short	id;		
unsigned short	index;	
unsigned long	sclust;	
unsigned long	clust;	
unsigned long	sect;	
unsigned char*	dir;		
unsigned char*	fn;		
} DIR;

typedef struct _FIL_ {
FATFS*	fs;			
unsigned short	id;		
unsigned char	flag;	
unsigned char	csect;	
unsigned long	fptr;		
unsigned long	fsize;		
unsigned long	org_clust;	
unsigned long	curr_clust;	
unsigned long	dsect;		
unsigned long	dir_sect;	
unsigned char*	dir_ptr;	
unsigned char	buf[512];
} FIL;

typedef struct _FILINFO_ {
unsigned long	fsize;	
unsigned short	fdate;	
unsigned short	ftime;	
unsigned char	fattrib;	
char	fname[13];	
} FILINFO;

typedef enum {
FR_OK = 0,		
FR_DISK_ERR,		
FR_INT_ERR,		
FR_NOT_READY,		
FR_NO_FILE,		
FR_NO_PATH,		
FR_INVALID_NAME,	
FR_DENIED,		
FR_EXIST,			
FR_INVALID_OBJECT,	
FR_WRITE_PROTECTED,	
FR_INVALID_DRIVE,	
FR_NOT_ENABLED,	
FR_NO_FILESYSTEM,	
FR_MKFS_ABORTED,	
FR_TIMEOUT		
} FRESULT;

FRESULT f_mount (unsigned char vol , FATFS* fs);

FRESULT f_open (FIL* fp, const XCHAR* path, unsigned char mode);

FRESULT f_read (FIL* fp, void* buff, unsigned int btr, unsigned int* br);

FRESULT f_write (FIL* fp, const void* buff, unsigned int btw, unsigned int* bw);

FRESULT f_lseek (FIL* fp, unsigned long ofs);

FRESULT f_close (FIL* fp);

FRESULT f_opendir (DIR* dj, const XCHAR* path);

FRESULT f_readdir (DIR* dj, FILINFO* fno);

FRESULT f_stat (const XCHAR* path, FILINFO* fno);

FRESULT f_getfree (const XCHAR* path, unsigned long* nclst, FATFS** fatfs);

FRESULT f_truncate (FIL* fp);

FRESULT f_sync (FIL* fp);

FRESULT f_unlink (const XCHAR* path);

FRESULT f_mkdir (const XCHAR* path);

FRESULT f_chmod (const XCHAR* path, unsigned char value, unsigned char mask);

FRESULT f_utime (const XCHAR* path, const FILINFO* fno);

FRESULT f_rename (const XCHAR* path_old, const XCHAR* path_new);

FRESULT f_chdir (const XCHAR* path);

FRESULT f_chdrive (unsigned char drv);

extern void (*prtc_get_time) (unsigned char *hour, unsigned char *min, unsigned char *sec);

extern void (*prtc_get_date) (unsigned char *date, unsigned char *month, unsigned *year);

#pragma library ff.lib

int fgetc(FIL *fp);
char *fgets(char *str,unsigned int len,FIL *fp);
int fputc(char k,FIL* fp);
int fputs(char *str,FIL* fp);
int fputsf(char flash *str,FIL* fp);
int fprintf(FIL *fp, char flash *fmtstr,...);
int fscanf(FIL *fp, char flash *fmtstr,...);
unsigned char feof(FIL* fp);
unsigned char ferror(FIL *fp);

#pragma used-

#pragma library stdio.lib

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

interrupt [8] void timer1_compa_isr(void)
{
disk_timerproc();    
}
void usart_init(){

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

unsigned char r;
unsigned char buffer[512];
unsigned char i;
unsigned long int sector_count;
void main(){
OCR1A = 7813;        
TCCR1A = 0x00;
TCCR1B = 0x0D;
TIMSK=0x10;    
DDRB=1;

#asm("sei") 
usart_init();
r=disk_initialize(0);    

if (r & 0x01	) printf("\nDisk init failed\n\r"); 
else
if (r & 0x02	) printf("\nCard not present\n\r");
else
if (r & 0x04	) printf("\nCard write\nprotected\n\r");

else printf("\nInit OK\n\r");
delay_ms(2000); 

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
