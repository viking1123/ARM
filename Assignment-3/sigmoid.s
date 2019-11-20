 AREA    sigmoid,CODE,READONLY
     IMPORT printSigmoid
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
        VLDR.F32 S9,=-5;
	    VLDR.F32 S14,=5
	    VMOV.F32 R10,S14
		VMOV.F32 R9,S9



x_values        MOV R2,#10 ;   number of times the loop runs ,the value 'n'
	            MOV R1,#1;initial value from which the loop starts 'i'
				VLDR.F32 S10,=1;Holding the sum of series elements 's'
				VLDR.F32 S11,=1;Temp Variable to hold the intermediate series elements 't'
   				CMP R9,R10
				BLE exp1
stop       B   stop		   


exp1    		;VMOV.F32 S9,R9;Moving the bit stream in R1('i') to S5(floating point register)
				;VCVT.F32.U32 S9, S9;Converting the bitstream into unsigned fp Number 32 bit
				CMP R1,R2;Compare 'i' and 'n' 
				BLE exp;if i < n goto LOOP
				B Sigmoid

exp				VMUL.F32 S11,S11,S9;t = t*x
				VMOV.F32 S5,R2;Moving the bit stream in R1('i') to S5(floating point register)
				VCVT.F32.U32 S5, S5;Converting the bitstream into unsigned fp Number 32 bit
 				VDIV.F32 S11,S11,S5;Divide t by 'i' and store it back in 't'
				VADD.F32 S11,S10,S11;Finally add 's' to 't' and store it in 's'
				;VNEG.F32 S11,S11
				SUB R2,R2,#1;Increment the counter variable 'i'
				B exp1;Again goto comparision


Sigmoid  		VLDR.F32 S12,=1
				VDIV.F32 S11,S12,S11
				VADD.F32 S13,S11,S12
				VDIV.F32 S14,S12,S13
				VMOV.F32 R0,S14
				BL printSigmoid
				VADD.F32 S9,S9,S12
				VMOV.F32 R9,S9;
				B x_values
				
				
				
				
        endfunc
      end
