	AREA    |.text|, CODE, READONLY
	ENTRY

	EXPORT  TURN_ON
	EXPORT  TURN_OFF
	EXPORT  TURN_LEFT
	EXPORT  TURN_RIGHT
	EXPORT 	GO_FORWARD
	EXPORT  GO_BACKWARD

	;Motors
	IMPORT	MOTEUR_INIT			        ; pwms + GPIO
	IMPORT	MOTEUR_DROIT_ON			
	IMPORT  MOTEUR_DROIT_OFF			
	IMPORT  MOTEUR_DROIT_AVANT			
	IMPORT  MOTEUR_DROIT_ARRIERE	
	IMPORT	MOTEUR_GAUCHE_ON	
	IMPORT  MOTEUR_GAUCHE_OFF			
	IMPORT  MOTEUR_GAUCHE_AVANT		
	IMPORT  MOTEUR_GAUCHE_ARRIERE	

	IMPORT  WAIT_ROTATION
	IMPORT  WAIT

TURN_ON
		mov     R2, LR
		BL      MOTEUR_GAUCHE_ON
		BL      MOTEUR_DROIT_ON
		mov     LR, R2
		BX      LR

TURN_OFF
		mov     R2, LR
		BL      MOTEUR_GAUCHE_OFF
		BL      MOTEUR_DROIT_OFF
		mov     LR, R2
		BX      LR


TURN_LEFT
		mov     R11, LR
		BL      TURN_ON
		BL      MOTEUR_GAUCHE_ARRIERE
		BL      MOTEUR_DROIT_AVANT
		BL      WAIT_ROTATION
		BL      TURN_OFF
		mov     LR, R11
		BX      LR

TURN_RIGHT
		mov     R11, LR  				;don't know yet how to use nasted functions, let's do it like this for now
		BL      TURN_ON
		BL     	MOTEUR_DROIT_ARRIERE
		BL      MOTEUR_GAUCHE_AVANT
		BL      WAIT_ROTATION
		BL      TURN_OFF
		mov     LR, R11
		BX 		LR;

GO_FORWARD
		mov     R11, LR  				;don't know yet how to use nasted functions, let's do it like this for now
		BL      TURN_ON
		BL     	MOTEUR_DROIT_AVANT
		BL      MOTEUR_GAUCHE_AVANT
		BL      WAIT
		BL      TURN_OFF
		mov     LR, R11
		BX 		LR;

GO_BACKWARD
		mov     R11, LR  				;don't know yet how to use nasted functions, let's do it like this for now
		BL      TURN_ON
		BL     	MOTEUR_DROIT_ARRIERE
		BL      MOTEUR_GAUCHE_ARRIERE
		BL      WAIT
		BL      TURN_OFF
		mov     LR, R11
		BX 		LR;



	END
