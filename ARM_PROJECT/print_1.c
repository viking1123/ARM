#include "stm32f4xx.h"
#include <string.h>
void print_1(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "Result:%d\t", a);
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
      ++ptr;
   }
}