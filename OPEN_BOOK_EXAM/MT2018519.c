#include "stm32f4xx.h"
#include <string.h>
void printMsg1(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%d\t", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

void printMsg2(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "%d\n", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}

