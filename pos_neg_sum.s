@ An Arm Program that outputs the sum of only negative numbers and 
@ the sum of only positive numbers in a list
@ Data is stored in memory location named Vec with length 16 word

@------Assembler Directives----------------					
	@ Data Variables
     	.data
     	.align

Vec: 	.word -7,3,5,1  		@ vector initiation 
     	.word -3,5,-18,-10
     	.word 2,-1,0,6
     	.word -10,-9,8,2

NSUM:   .asciz "Sum of Negative Numbers: "
PSUM:   .asciz "\nSum of Positive Numbers: "

.EQU	SUM, 0x00001200


	@ Code
	.TEXT
@------End of Assembler Directives----------------	
main:	LDR	R1, =Vec	@ load the beginning address of Vec to R1
	MOV	R2, #16		@ R2 is the counter
	BL	GET_SUM		@ jump to the subroutine
	LDR	R4, =SUM	@ load the address of SUM to R0
	STR	R0, [R4]	@ store the final result

        MOV 	R0,#1      	@ To print out using SWI 0x6b
        LDR 	R1, =NSUM 	@ Load asciz message to R1
        SWI 	0x69 		@ Prints the string
	MOV 	R1,R6      	@ Making R1 ready for print out
	SWI 	0x6b       	@ Printing the integer of R1

	MOV 	R0, #1 		@ To print out using SWI 0x6b
        LDR 	R1, =PSUM 	@ Load asciz message to R1
        SWI 	0x69 		@ Prints the string
	MOV 	R1, R5		@ Making R1 ready for print out
	SWI 	0x6b       	@ Printing the integer of R1

	SWI 0x11		@ Stop program execution

GET_SUM:
	MOV	R0, #0		@ R0 is to store temporary result of addition
loop:	LDR	R3, [R1], #4	@ load the value of current number to R3; increment R1 by 4 to move the pointer to the next number
	CMP	R3, #0		@ sets flag after evaluating [R3} - 0
	BPL	IF_POS		@ branch if N = 0
	BMI	IF_NEG		@ branch if N = 1
	BGT	loop 		@ if counter > 1, branch to loop
	BX	LR		@ return to the main routine

IF_NEG:
	ADDMI	R6, R6, R3	@ add the number to R0
	SUBS R2, R2, #1		@ decrement counter by 1; result sets condition flags
	BGT	loop 		@ if counter > 1, branch to loop
	BX	LR		@ return to the main routine

IF_POS:
	ADDPL	R5, R5, R3	@ add the number to R0
	SUBS	R2, R2, #1	@ decrement counter by 1; result sets condition flags
	BGT	loop 		@ if counter > 1, branch to loop
	BX	LR		@ return to the main routine
