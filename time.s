WAIT_DURATION 		EQU 0x15FFFFE ;0xAFFFFF
ROTATION_DURATION 	EQU 0x15FFFFE ;Harcoded for now, should be a value such as angle while rotating is 90 degree
	AREA    |.text|, CODE, READONLY
	ENTRY

	EXPORT  WAIT
	EXPORT  WAIT_ROTATION

WAIT		ldr r1,  =WAIT_DURATION
		B   countdown


WAIT_ROTATION 	ldr r1, =ROTATION_DURATION
	 	B countdown


countdown	subs r1, #1
        	bne countdown
		BX	LR

		END