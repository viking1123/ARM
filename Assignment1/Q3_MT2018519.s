; ARM__Assignment-1
; Sarvesh Nandkar : MT2018519
; EVEN or ODD

THUMB

AREA     first, CODE, READONLY
     export __main	 
	 ENTRY 
__main function
		  MOV r0,#0x53	; 
		  AND r1,r0,#0x01 ; To have only the 1st bit from lsb side of the required number  
		  CMP r1,#0x0 	; checking if this is 0 or 1(1=odd; 0=even)
		  ITE EQ 					
		  MOVEQ r2,#0x0	; if R1 = 0, reflect R2 as 0 which means the number is EVEN
		  MOVNE r2,#0x1	; if R1 = 1, reflect R2 as 1 which means  the number is ODD
STOP		      B STOP       ; stop program 
        endfunc
end 
