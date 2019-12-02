      THUMB
      AREA     first, CODE, READONLY
      IMPORT printMsg1
      IMPORT printMsg2
      EXPORT __main
      ENTRY 
__main  FUNCTION	
	
      
       VLDR.F32 s31, =5
       VLDR.F32 s30, =180	   
       VLDR.F32 s21, =-180
       
loop1  BL func_calc
       VADD.F32 s21,s21,s31


       VLDR.F32 s18, =40 	;focal point A of the ellipse
	   VLDR.F32 S19, =60	;focal point B of the ellipse

       VMUL.F32 s28,s18,s7       ;x=a * costheta
	   VMUL.F32 s29,s19,s5       ;y=b * sintheta

;change origin (0.0) to (239,319) for VGA plot
       VLDR.F32 s27, =239
       VLDR.F32 s26, =319
       
;Ellipse equation: x= X+a*costheta	y=Y+b*sintheta  

;(a,b) centre point of the ellipse

      VADD.F32 s28,s28,s27
      VADD.F32 s29,s29,s26

     
	  VCVT.U32.F32 s28,s28
       VMOV.F32 R0,S28
	  BL printMsg1				;printing x coordinate
	 
	 VCVT.U32.F32 s29,s29
       VMOV.F32 R0,S29
       BL printMsg2 			;printing y coordinate
   
   
       VCMP.F32 s21,s30  
	   vmrs APSR_nzcv,FPSCR
	   BLE loop1

	
func_calc 

;storing pi value
       VLDR.F32 s22, =3.14159
       VLDR.F32 s23, =180
       VDIV.F32 s24,s22,s23		;(pi/180)
       VMUL.F32 s0,s24,s21	
	
	
      MOV R0,#0x00000010  		;no of iterations = 10
	 
	 VLDR.F32 s2, =1			;keep track of number of iterations
	  MOV R5,#0x00000001
	  
;incrementor i	  
	  VLDR.F32 s3, =1
	  MOV R2,#0x00000001
	  
	  VMUL.F32 s8,s0,s0		;x * x
	  VLDR.F32 s9, =2		;2 * i

;immediate sin value: s4	 
	  VMOV.F32 s4, s0

;result sin: s5	 
	  VMOV.F32 s5, s0
	  
;immediate cos value: s6	 
	  VLDR.F32 s6, =1

;result cos s7	 
	  VLDR.F32 s7, =1	  

Loop  
	  VMUL.F32 s10,s2,s9
      VADD.F32 s11,s10,s3
      VMUL.F32 s12,s10,s11
      VDIV.F32 s13,s8,s12
      
      VSUB.F32 s14,s10,s3
      VMUL.F32 s15,s10,s14 				
      
	  ;iterate the product: sin x * x/ 2i * 2i+1
      VDIV.F32 s16,s8,s15
      
      ;Product_sin s4	
      VNMUL.F32 s4,s4,s13 
      
      ;Product_cos s6	
      VNMUL.F32 s6,s6,s16 
      
      ;sine_result
      VADD.F32 s5,s5,s4
      
      ;cos_result
      VADD.F32 s7,s7,s6

      VADD.F32 s2,s2,s3
	  ADD R5,R5,R2
	  CMP R5,R0	
	  BLT Loop
      BX lr

	
stop    B stop ; stop program
      ENDFUNC
      END 
