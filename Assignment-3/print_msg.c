#include "stm32f4xx.h"
void printMsg(const int a,const int b,const int c,const int d)
{
	 char Msg[100];
	 char *ptr;
	switch (a) {
            case 1:
                sprintf(Msg, "\n Dataset is 1 0 0%x", a);
                break;
            case 2:
                sprintf(Msg, "\n Dataset is 1 0 1  %x", a);
                break;
            case 3:
                sprintf(Msg, "\n Dataset is 1 1 0%x", a);
                break;
						case 4:
                sprintf(Msg, "\n Logic used is nand %x", a);
         
            default:
               sprintf(Msg, "\n Data set not possible %x", a);
                break;
        }
	
	 sprintf(Msg, "\n The value of sigmoid in floating point  %x", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
switch (b) {
            case 1:
                sprintf(Msg, "\n Logic used is and %x", b);
                break;
            case 2:
                sprintf(Msg, "\n Logic used is or %x", b);
                break;
            case 3:
                sprintf(Msg, "\n Logic used is not %x", b);
                break;
						case 4:
                sprintf(Msg, "\n Logic used is nand %x", b);
                break;
            case 5:
                sprintf(Msg, "\n Logic used is nor %x", b);
                break;
            case 6:
                sprintf(Msg, "\n Logic used is xor %x", b);
                break;
            case 7:
                sprintf(Msg, "\n Logic used is xnor %x", b);
                break;						
            default:
               sprintf(Msg, "\n Logic not possible %x", b);
                break;
        }

	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
     sprintf(Msg, "\n Value of sigmoid is %x", c);
	   ptr = Msg ;
     while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 
	 sprintf(Msg, "\n Trained data is %x", d);
	   ptr = Msg ;
     while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}
