;ARM__Assignment-1
;Sarvesh Nandkar : MT2018519
;FIBONACCI SERIES

     THUMB
     AREA     first, CODE, READONLY
     EXPORT __main
     
     ENTRY 
__main  FUNCTION		 		
		MOV  r0, #8 	;input r0 = 8
		MOV  r1, #1 	;fibo(0), result here
		MOV  r2, #1 	;fibo(1)
		SUB  r0, #1	;decrement, r0--	
		
loop	CMP r0, #0		;r0 == 0?
		BLE stop	;if YES -> stop
		
		ADD r1, r2	;r1 += r2
		EOR r1, r2	;swap r1 and r2
		EOR r2, r1
		EOR r1, r2
		SUB r0, #1	;r0--
		B loop		;go to LOOP

stop B stop 			; stop program
     ENDFUNC
     END
