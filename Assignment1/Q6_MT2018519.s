;ARM ARCHITECTURE--Assignment-1 
; Sarvesh Nandkar-MT2018519

     AREA     first, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
		MOV  r0, #60	;input A
		MOV  r1, #40 	;input B
		
loop	CMP r0, r1		; r0 == r1?
		BEQ stop		; YES stop
		
		CMP r0, r1		; r0 > r1
		ITE GT			; Works without ITE aswell
		SUBGT r0, r1	; YES r0 -= r1
		SUBLE r1, r0	; NO r1 -= r0
		
		B loop
		
stop B stop 			; stop program
     ENDFUNC
     END
