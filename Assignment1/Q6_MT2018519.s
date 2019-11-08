; ARM ARCHITECTURE--Assignment-1 
; Sarvesh Nandkar-MT2018519
; GCD of 2 numbers

     AREA     first, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
		MOV  r0, #12		;input A
		MOV  r1, #30 		;input B
		
loop	CMP r0, r1			; r0 == r1?
		BEQ stop		; if YES, stop
		
		CMP r0, r1		; r0 > r1
		ITE GT			
		SUBGT r0, r1		; if YES, r0 -= r1
		SUBLE r1, r0		; NO r1 -= r0
		
		B loop
		
stop B stop 			; stop program
     ENDFUNC
     END
