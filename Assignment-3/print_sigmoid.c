#include "stm32f4xx.h"
#include <string.h>
void printSigmoid(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "Theta = %d degrees,", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 
		 
}
