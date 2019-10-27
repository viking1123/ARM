; ARM__Assignment-1
; Sarvesh Nankdar : MT2018519
; largest number of 3  numbers

   THUMB
	 AREA     first, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	    		 		
		MOV  r0, #1		;input A
		MOV  r1, #2 	;input B
		MOV  r2, #3		;input C	
		
		CMP r0, r1		; r0 > r1?
		ITE GE			; 
		MOVGE r3, r0	; YES r3 = r0
		MOVLT r3, r1	; NO r3 = r1
		
		CMP r2, r3		; r2 > r3
		IT GE			; 
		MOVGE r3, r2	; YES r3 = r2

stop B stop 			; stop program
	   
     ENDFUNC
     END 
