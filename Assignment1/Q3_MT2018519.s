; ARM__Assignment-1
; Sarvesh Nandkar : MT2018519
; EVEN or ODD
; output: R2

     THUMB
     AREA   first, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION

		  MOV r0,#0x17		; initialize a number in R0
		  AND r1,r0,#0x01 	; taking lsb bit, AND it with 1
		  CMP r1,#0x0 		; checking if this bit is 0 or 1(1=odd; 0=even)
		  ITE EQ 					
		  MOVEQ r2,#0x0		; if R1 = 0, make R2 = 0 => number is EVEN
		  MOVNE r2,#0x1		; if R1 = 1, make R2 = 1 => number is ODD

STOP B STOP       			; stop program 

ENDFUNC
END
