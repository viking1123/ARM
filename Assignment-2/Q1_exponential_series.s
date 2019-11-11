
     
     THUMB
     AREA   first,CODE,READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	

  VMOV.F32 S1, #6  ;The value of x in e^x
	MOV R1, #8       ;Number of terms in the infinite series expansion
	MOV R4, #1       ;The counting variable      
	VMOV.F32 S3, #1
	VMOV.F32 S4, #1   ;The count variable 
	VMOV.F32 S5, #1   ; Save the result
	VMOV.F32 S7, #1;
	MOV R8, #1;
Loop 
	 CMP R1, R4         ; Comparing if the count has become the no. of terms or not
	 BLT stop           ; Condition to check to enter inside loop
	 VDIV.F32 S6, S1, S4
	 VMUL.F32 S3, S3, S6 
	 VADD.F32 S5, S5, S3 
	 VADD.F32 S4, S4, S7
	 ADD R4, R4, R8     ; incrementing count
	 B Loop; 
	 
stop B stop ; stop program
	 ENDFUNC
	 END
