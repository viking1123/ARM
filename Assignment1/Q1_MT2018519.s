;ARM__Assignment-1
;Sarvesh Nandkar : MT2018519
;FIBONACCI SERIES

THUMB
	 AREA     first, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
 	
	    MOV r1,#0 ; (f(i-2) = f(0) = 0)
        MOV r2,#1 ; (f(i-1) = f(1) = 1)
		MOV r3,#8 ; (eg:n, display first n numbers)
loop	CMP r3,#0 ; (loop iterator check (n>0))		
		SUBGT r3,r3,#1 ; (decrement iterator by 1)
		BEQ stop; jump to stop once n=0
		MOV r5,r1 ; (store r1, it stores and displays the fibonacci numbers)
		ADD r4,r1,r2 ; (f(i) = f(i-1)+f(i-2))
		MOV r1,r2 ; (f(i-2) = f(i-1))
		MOV r2,r4 ; (f(i-1) = f(i))
		BGT loop; (loop if n>0)
stop    B stop ; stop program
	   
     ENDFUNC
     END
