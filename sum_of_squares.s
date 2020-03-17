@ An Arm Program to calculate the sum of squares of a dataset.
@ Data is stored in memory location name Vec with length 16 word. 
@ 


	.text           @ Directive 
 	.global _start  @ declare global beginning
	 _start:

	 MOV 	R0, #1 
         LDR 	R1, =Str @ Load asciz message to R1
         SWI 	0x69 	@ Prints the string   
      
	 LDR R1,=idx    @ content of idx is length of Vec and now R1 is a counter. 
         LDR R1,[R1]    @ R1 is now the length of Vec. read indirectly 
         LDR R2,=Vec    @ R2 is the address of first element of vector 
         MOV R0,#0      @ R0 is a register to accumulate the summation of the element of the vector. 
   LOOP: LDR R3,[R2]    @ R3 = Vec[i]
	 MUL R4,R3,R3   @ R4 = Vec[i] * Vec[i]
         ADD R0,R0,R4   @ R0 = R0 + Vec[i]
         ADD R2,R2,#4   @ R2 pointing to the next element of vector  
         SUB R1,R1,#1   @ decrements the counter by 1
         CMP R1,#0      @ if counter = 0, end of Vec
         BNE LOOP       @ loop until R1=0

         LDR R1,=Sum    @ R1 now is the address of the Sum
         STR R0,[R1]    @ Indirect writing for results in Sum 
         MOV R1,R0      @ Making R1 ready for print out
         MOV R0,#1      @ To print out using SWI 0x6b
         SWI 0x6b       @ Printing the constant of R1
         SWI 0x11       @ Terminates the program
	 
         .data          @ Directive for beginning of data part 
         .align         @ Directive for alignment of memory addresses 
    idx: .word 16       @ Total number of elements of vector 
    Vec: .word -7,3,5,1  @ vector initiation 
         .word -3,5,-18,-10
         .word 2,-1,0,6
         .word -10,-9,8,2
    Sum: .skip 4        @ results 
    Str: .asciz "Sum of Squares: "
         .end
