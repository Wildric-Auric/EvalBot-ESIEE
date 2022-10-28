   	
		AREA    |.text|, CODE, READONLY
 
SYSCTL_PERIPH_GPIO EQU		0x400FE108	; SYSCTL_RCGC2_R (p291 datasheet de lm3s9b92.pdf)
GPIO_PORTD_BASE		EQU		0x40007000	; APB
GPIO_PORTE_BASE		EQU		0x40024000


GPIO_O_DIR   		EQU 	0x00000400 

GPIO_O_DR2R   		EQU 	0x00000500 

GPIO_O_DEN  		EQU 	0x0000051C

GPIO_I_PUR   		EQU 	0x00000510 

PINS             	EQU     0xFFFFFFFF  ;all of them
PIN0			 	EQU     0x01
PIN1             	EQU     0x02
PIN6			 	EQU 	0x40	
PIN7             	EQU     0x80

		
	AREA    |.text|, CODE, READONLY
	ENTRY
	EXPORT  INIT_BTNS
INIT_BTNS
									
		ldr r6, = SYSCTL_PERIPH_GPIO  			;; RCGC2
        mov r0, #0x00000018  					;; Enable D and E (0x08 == 0b011000) for switches and bumpers
        str r0, [r6]
		
		nop	   						
		nop	   
		nop	   						
		
		
		;switches config
		ldr r3, = GPIO_PORTD_BASE+GPIO_I_PUR
        ldr r0, = PINS		
        str r0, [r3]
		ldr r3, = GPIO_PORTD_BASE+GPIO_O_DEN
        ldr r0, = PINS	
        str r0, [r3]     
        ; --------------------------sw1
		ldr r3, = GPIO_PORTD_BASE + (PIN6<<2) 
		;---------------------------sw2  
		ldr r4, = GPIO_PORTD_BASE + (PIN7<<2) 

		;bumpers config
 		ldr r7, = GPIO_PORTE_BASE+GPIO_I_PUR
        ldr r0, = PINS		
        str r0, [r7]
		ldr r7, = GPIO_PORTE_BASE+GPIO_O_DEN
        ldr r0, = PINS	
        str r0, [r7]     
		;--------------------------bumper Right
		ldr r7, = GPIO_PORTE_BASE + (PIN0<<2) 
		;--------------------------bumper left
		ldr r8, = GPIO_PORTE_BASE + (PIN1<<2)


		BX LR
	END