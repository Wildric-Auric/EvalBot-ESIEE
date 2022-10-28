;     R1, R0, R2 temporary values
;     R3, R4, switches 1, 2
;     R7, R8, bumpers  right, left
;     R11 value containing R14 infos

;--------------------------------------------------
MAX_CMDS        EQU  	0x64           ;actually length of cmd_list
		AREA    |.text|, CODE, READONLY
		ENTRY
		EXPORT	__main

		IMPORT	MOTEUR_INIT

		IMPORT WAIT

		IMPORT TURN_RIGHT
		IMPORT TURN_LEFT
		IMPORT GO_FORWARD
		IMPORT GO_BACKWARD
		IMPORT TURN_ON
		IMPORT TURN_OFF

		IMPORT  INIT_BTNS
__main	

		
		BL  INIT_BTNS  	
		BL  MOTEUR_INIT		

		mov R5, #0x00  	  	;cmds counter
		mov R6, #0x00           ;iterator in exec
		ldr R9, =cmds_list      ;adress to first byte
   
;------------------getting commands
cmd

		ldr     R0, [R3]
		cmp     R0, #0x00
		BLEQ	sw1

		ldr     R0, [R4]
		cmp     R0, #0x00
		BLEQ    sw2

		ldr     R0, [R7]
		cmp     R0, #0x00
		BLEQ    bmpR

		ldr     R0, [R8]
		cmp     R0, #0x00
		BLEQ    bmpL


		B	cmd


;------------------execution
exec
		cmp 		R6, R5
		BEQ 		break
		
		LDRB 		R0,[R9, R6]
		cmp 		R0, #0x01
		BLEQ 		GO_FORWARD
		BEQ			skip			;not checking next conditions since R0 is modified inside subcode

		cmp			R0, #0x02
		BLEQ		TURN_RIGHT
		BEQ    		skip

		cmp			R0, #0x03
		BLEQ		GO_BACKWARD
		BEQ			skip

		cmp			R0, #0x04
		BLEQ 		TURN_LEFT
skip
		add 		R6, #0x01
		B			exec


sw1
		ldr 		R0, [R3]
		cmp 		R0, #0x00
		BEQ 		fsw1 			;save command only when button is released; same logic for other switch and bumpers

		mov 		R1, #0x01
		STRB 		R1,[R9,R5]
		add 		R5, R5, #0x01

		BX			LR
sw2		
		ldr 		R0, [R4]
		cmp 		R0, #0x00
		BEQ 		fsw2

		mov 		R1, #0x03
		STRB  		R1,[R9,R5]
		add 		R5, R5, #0x01
		BX			LR
bmpR

		mov 		R1, #0x02
		STRB  		R1,[R9,R5]
		add 		R5, R5, #0x01
		MOV			R11, LR
		BL          WAIT
		MOV 		LR,  R11
		BX			LR

bmpL

		mov 		R1, #0x04
		STRB  		R1,[R9,R5]
		add 		R5, R5, #0x01
		MOV			R11, LR
		BL          WAIT
		MOV 		LR,  R11
		BX			LR


fsw1 		
		ldr     R1, [R4]
		ORR     R2, R0, R1
		cmp     R2, #0x00 	;if both sw1 and sw2 are pressed then we start execution
		BEQ     exec
		B 		sw1

fsw2
		ldr     R1, [R3]
		ORR     R2, R0, R1
		cmp     R2, #0x00 	;if both sw1 and sw2 are pressed then we start execution
		BEQ     exec
		B 		sw2



;end point
break
		BL TURN_OFF
		NOP

		AREA data, DATA, READWRITE
cmds_list	SPACE 	MAX_CMDS 			 ;MAX_CMDS bytes allocated

		END







