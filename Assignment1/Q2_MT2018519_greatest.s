; ARM__Assignment-1
; Sarvesh Nandkar : MT2018519
; finding greatest of three numbers
; inputs: R0, R1, R2
; outputs: R3

	 THUMB
     AREA     first, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION		 		
		MOV  r0, #4		;input A
		MOV  r1, #3 		;input B
		MOV  r2, #5		;input C	
		
		CMP r0, r1		; r0 > r1?
		IT GE			; If then statement
		MOVGE r3, r0		; YES r3 = r0
		MOVLT r3, r1		; NO r3 = r1
		
		CMP r2, r3		; r2 > r3
		IT GE			
		MOVGE r3, r2		; YES r3 = r2

stop B stop 				; stop program
     ENDFUNC
     END
