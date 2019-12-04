		AREA	appcode, CODE, READONLY
		IMPORT printMsg
		export __main
		ENTRY
__main  function

		;INPUTS
		VLDR.F32 S29,=1 ;X0
		VLDR.F32 S30,=0	;X1
		VLDR.F32 S31,=1	;X2
		
		MOV R0,#1
		MOV R1,#0
		MOV R2,#1
		
		MOV R7,#4		;Input to R7 decides the logic_gate
		
		CMP R7,#1
		BEQ LOGIC_AND
		
		CMP R7,#2
		BEQ LOGIC_OR
		
		CMP R7,#3
		BEQ LOGIC_NOT
		
		CMP R7,#4
		BEQ LOGIC_NAND
		
		CMP R7,#5
		BEQ LOGIC_NOR
		B NXT
	
;S0 = W0,S1 = W1, S2 = W2, S3 = bias	
LOGIC_AND	VLDR.F32 S0,=-0.1
			VLDR.F32 S1,=0.2
			VLDR.F32 S2,=0.2
			VLDR.F32 S3,=-0.2
			B EXP_CALC
			
LOGIC_OR	VLDR.F32 S0,=-0.1
			VLDR.F32 S1,=0.7
			VLDR.F32 S2,=0.7
			VLDR.F32 S3,=-0.1
			B EXP_CALC
			
LOGIC_NOT	VLDR.F32 S0,=0.5
			VLDR.F32 S1,=-0.7
			VLDR.F32 S2,=0
			VLDR.F32 S3,=0.1
			B EXP_CALC
			
LOGIC_NAND	VLDR.F32 S0,=0.6
			VLDR.F32 S1,=-0.8
			VLDR.F32 S2,=-0.8
			VLDR.F32 S3,=0.3
			B EXP_CALC
			
LOGIC_NOR	VLDR.F32 S0,=0.5
			VLDR.F32 S1,=-0.7
			VLDR.F32 S2,=-0.7
			VLDR.F32 S3,=0.1
			B EXP_CALC
			
NXT			CMP R7,#6
			BEQ LOGIC_XOR
			
			CMP R7,#7
			BEQ LOGIC_XNOR
			
LOGIC_XOR	VLDR.F32 S0,=-5
			VLDR.F32 S1,=20
			VLDR.F32 S2,=10
			VLDR.F32 S3,=1
			B EXP_CALC
			
LOGIC_XNOR	VLDR.F32 S0,=-5
			VLDR.F32 S1,=20
			VLDR.F32 S2,=10
			VLDR.F32 S3,=1
			B EXP_CALC
			
;S28 STORES X0*W0 + X1*W1 + X2*W2 + Bias
EXP_CALC	VMLA.F32 S28, S0, S29
			VMLA.F32 S28, S1, S30
			VMLA.F32 S28, S2, S31
			VADD.F32 S28, S28, S3
			B EXP
					
;e^x stored in S2
EXP			VMOV.F32 S2, #1 			; Sum Variable
			VMOV.F32 S6, #25			; 'n' variable - sequence size
			;VMOV.F32 S1, #5 			; 'x' varaiable - in e^x
			VMOV.F32 S3, #1 			; constant
			
loop		VCMP.F32 S6, #0
			VMRS.F32 APSR_nzcv,FPSCR 	; Transfer floating-point flags to the APSR flags
			BEQ SIGMOID
			VDIV.F32 S4, S2, S6 		; sum/i
			;VMUL.F32 S5, S1, S4 		; x*sum/i
			VMUL.F32 S5, S28, S4 		; x*sum/i
			VADD.F32 S2, S3, S5 		; sum = 1 + (x * (sum/i))
			VSUB.F32 S6, S6, S3
			B loop
			
SIGMOID		VDIV.F32 S2, S3, S2 		; 1/e^x
			VADD.F32 S2, S3, S2 		; 1 + 1/e^x
			VDIV.F32 S2, S3, S2 		; 1/(1 + 1/e^x)
			B OUTPUT
		

;S15 will hold 0.5 for comparison to finalise the logical output for a particular gate
OUTPUT		VLDR.F32 S15 ,=0.5
			VCMP.F32 S2, S15 			; compare the output with S15
			VMRS.F32 APSR_nzcv,FPSCR 	; Transfer floating-point flags to the APSR flags
			ITE HI
			MOVHI R3,#1					; if S2 > S15
			MOVLS R3,#0					; if S2 < S15
			BL printMsg
			
stop 		B  stop 
			endfunc
			end
