     
     THUMB
     AREA    first,CODE,READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	

	    MOV R1,#15; the number of times loop will run
      
		  MOV R2,#1; initial value 
		
		
; As directly generalized form of tan() contains Bernoullis constant I've made use of infinite series of sin and cos implementation

    VLDR.F32 S0,=30   ;Value of x of tanx (in degress)
		VLDR.F32 S9,=57    ;to convert the value entered into pi format for conversion to radian
		VLDR.F32 S17,=1
		VDIV.F32 S0,S0,S9 ; conversion to radian :x*3.14/180 ~ x/57
		
		VMOV.F32 S1,S0 ;Sine result
		VMOV.F32 S2,S0 ;intermediate  sine result
		
		VLDR.F32 S12,=1 ;Cos result
		VLDR.F32 S14,=1 ;intermediate Cos result
        
		VLDR.F32 S3,=2; to calculate iterations 2i	
 


loop1    CMP R2,R1   ;to compare if the loop value i reaches n 
         BLE loop2   ;if i < n goto loop2
         B stop      ;else goto stop

loop2		VMUL.F32 S2,S2,S0;      t = t*x for sine
        VNMUL.F32 S2,S2,S0;     t = -t*x*x for sine
		
		    VMUL.F32 S14,S14,S0           ;  t = t*x for cosine
        VNMUL.F32 S14,S14,S0      ; t = -t*x*x for cosine
		
		    VMOV.F32 S5,R2;Moving the bit stream in R2('i') to S5(floating point register)
        VCVT.F32.U32 S5, S5;Converting the bitstream into unsigned fp Number 32 bit
		
		    VMUL.F32 S4,S3,S5 ; to calculate 2i

        VADD.F32 S6,S4,S17 ; to calculate 2i+1 for sine term
        VSUB.F32 S7,S4,S17 ; to calculate 2i-1 for cosine term
		
        VMUL.F32 S6,S6,S4 ; to calculate 2i(2i+1)
        VMUL.F32 S7,S7,S4 ; to calculate 2i(2i-1)

        VDIV.F32 S2,S2,S6   ; to calculate (-t*x*x)/(2i*(2i+1))
        VDIV.F32 S14,S14,S7 ; to calculate (-t*x*x)/(2i*(2i-1))
		
        VADD.F32 S1,S2,S1    ; value of sine
        VADD.F32 S12,S14,S12 ; value of cosine
		
        VDIV.F32 S13,S1,S12  ; tanx = sin x / cos x
		
        ADD R2,R2,#1         ;Increment the counter variable 
        B loop1              ;Again goto comparision




stop        B stop  ; stop program
        endfunc
      end
