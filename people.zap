

	.FUNCT	PREVENTS-YOU?,L=0,DIR=0,PER=0
	ZERO?	L \?CND1
	SET	'L,HERE
?CND1:	ZERO?	DIR \?CND4
	CALL1	EXIT-VERB? >DIR
?CND4:	ZERO?	PER \?CND7
	SET	'PER,PLAYER
?CND7:	ZERO?	ON-TRAIN /FALSE
	ZERO?	TICKETS-PUNCHED? /?ELS16
	ZERO?	CUSTOMS-SWEEP /FALSE
?ELS16:	IN?	CONDUCTOR,L \FALSE
	EQUAL?	DIR,P?NORTH \FALSE
	FSET?	PER,LOCKED /TRUE
	RFALSE


	.FUNCT	PLAYER-F,ARG=0,L=0
	EQUAL?	ARG,M-WINNER /?CND1
	EQUAL?	PRSO,PLAYER \FALSE
	EQUAL?	PRSA,V?GOODBYE,V?HELLO \?ELS9
	CALL1	HAR-HAR
	JUMP	?CND4
?ELS9:	EQUAL?	PRSA,V?SEARCH,V?EXAMINE \?CND4
	CALL2	PERFORM,V?INVENTORY
	RTRUE	
?CND4:	
?CND1:	ZERO?	KILLED-PERSON /?CND14
	IN?	KILLED-PERSON,PLAYER \?CND14
	CALL2	ANYONE-VISIBLE?,KILLED-PERSON >L
	ZERO?	L /?CND14
	CALL	ARREST-PLAYER,STR?28,L,TRUE-VALUE,KILLED-PERSON
	RETURN	2
?CND14:	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?ELS25
	CALL2	NOISY?,HERE
	ZERO?	STACK /?ELS25
	SET	'P-CONT,FALSE-VALUE
	PRINTR	"You can't make yourself heard above the noise."
?ELS25:	CALL1	PREVENTS-YOU?
	ZERO?	STACK /?ELS31
	CALL2	START-SENTENCE,CONDUCTOR
	PRINTI	" prevents you from passing him."
	CRLF	
	RETURN	2
?ELS31:	ZERO?	PLAYER-SEATED \?ELS37
	ZERO?	PLAYER-HIDING /FALSE
?ELS37:	EQUAL?	PRSO,FALSE-VALUE,ROOMS \?ELS41
	EQUAL?	PRSA,V?STAND /?THN47
	CALL1	EXIT-VERB?
	ZERO?	STACK /FALSE
?THN47:	IN?	BRIEFCASE,PLAYER \FALSE
	FSET?	BRIEFCASE,OPENBIT \FALSE
	FCLEAR	BRIEFCASE,OPENBIT
	CALL	INSIDE-OBJ-TO,BRIEFCASE-TBL,BRIEFCASE,1
	PRINTI	"(You close the briefcase first.)"
	CRLF	
	RFALSE	
?ELS41:	ZERO?	P-WALK-DIR /?ELS52
	CALL1	TOO-BAD-SIT-HIDE
	RSTACK	
?ELS52:	EQUAL?	PRSA,V?FIND /?THN56
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH,V?WALK-TO \?ELS55
?THN56:	CALL1	TOO-BAD-SIT-HIDE
	RSTACK	
?ELS55:	CALL1	SPEAKING-VERB?
	ZERO?	STACK \FALSE
	CALL1	GAME-VERB?
	ZERO?	STACK \FALSE
	CALL1	REMOTE-VERB?
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?SMILE,V?SHOOT /FALSE
	EQUAL?	PRSA,V?NOD,V?LOOK-ON,V?AIM /FALSE
	CALL2	HELD?,PRSO
	ZERO?	STACK \FALSE
	CALL2	TABLE?,HERE
	CALL	HELD?,PRSO,STACK
	ZERO?	STACK \FALSE
	CALL	HELD?,PRSO,GLOBAL-OBJECTS
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?EXAMINE \?ELS75
	EQUAL?	P-ADVERB,W?CAREFULLY \FALSE
?ELS75:	CALL	HELD?,PRSO,PLAYER-SEATED
	ZERO?	STACK \?ELS79
	CALL1	TOO-BAD-SIT-HIDE
	RSTACK	
?ELS79:	ZERO?	PRSI /FALSE
	CALL2	HELD?,PRSI
	ZERO?	STACK \FALSE
	CALL	HELD?,PRSI,GLOBAL-OBJECTS
	ZERO?	STACK \FALSE
	CALL	HELD?,PRSI,PLAYER-SEATED
	ZERO?	STACK \FALSE
	CALL1	TOO-BAD-SIT-HIDE
	RSTACK	


	.FUNCT	TOO-BAD-SIT-HIDE
	ZERO?	PLAYER-SEATED /?ELS5
	EQUAL?	PRSA,V?LIE \?ELS11
	GRTR?	0,PLAYER-SEATED \?ELS11
	CALL	ALREADY,WINNER,STR?29
	RSTACK	
?ELS11:	EQUAL?	PRSA,V?SIT \?ELS15
	LESS?	0,PLAYER-SEATED \?ELS15
	CALL	ALREADY,WINNER,STR?30
	RSTACK	
?ELS15:	SET	'PLAYER-SEATED,FALSE-VALUE
	PRINTI	"(You "
	IN?	BRIEFCASE,PLAYER \?CND22
	FSET?	BRIEFCASE,OPENBIT \?CND22
	PRINTI	"close the briefcase and "
	FCLEAR	BRIEFCASE,OPENBIT
	CALL	INSIDE-OBJ-TO,BRIEFCASE-TBL,BRIEFCASE,1
?CND22:	PRINTI	"stand up first.)"
	CRLF	
	RFALSE	
?ELS5:	ZERO?	PLAYER-HIDING /FALSE
	SET	'CLOCK-WAIT,TRUE-VALUE
	EQUAL?	PRSA,V?HIDE-BEHIND \?ELS38
	ZERO?	PRSI \?ELS38
	CALL	ALREADY,WINNER,STR?31
	RSTACK	
?ELS38:	PRINTR	"(You can't do that while you're hiding.)"


	.FUNCT	CONDUCTOR-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,CONDUCTOR
	RSTACK	


	.FUNCT	CONDUCTOR-GIVE-SHOW
	EQUAL?	PRSA,V?GIVE \?ELS5
	RETURN	PRSO
?ELS5:	EQUAL?	PRSA,V?SHOW \FALSE
	RETURN	PRSI


	.FUNCT	CONDUCTOR-F,ARG=0,OBJ
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL	PERSON-F,CONDUCTOR,ARG
	RSTACK	
?ELS5:	CALL2	PASS-OBJECT?,MCGUFFIN
	ZERO?	STACK /?ELS7
	CALL2	SHOW-MCGUFFIN,CONDUCTOR
	RSTACK	
?ELS7:	CALL1	CONDUCTOR-GIVE-SHOW >OBJ
	ZERO?	OBJ /?ELS9
	EQUAL?	OBJ,PASSPORT,BRIEFCASE /?THN12
	EQUAL?	OBJ,TICKET,TICKET-OTHER \?ELS9
?THN12:	EQUAL?	OBJ,PASSPORT,BRIEFCASE \?ELS18
	ZERO?	CUSTOMS-SWEEP /FALSE
	CALL	HE-SHE-IT,CONDUCTOR,TRUE-VALUE
	PRINTI	" nods and points toward"
	ZERO?	ON-TRAIN /?ELS29
	CALL2	HIM-HER-IT,PLATFORM-GLOBAL
	JUMP	?CND27
?ELS29:	CALL2	HIM-HER-IT,CUSTOMS-AGENT
?CND27:	PRINTR	"."
?ELS18:	ZERO?	ON-TRAIN /FALSE
	CALL2	START-SENTENCE,CONDUCTOR
	EQUAL?	OBJ,TICKET \?ELS50
	CALL	ZMEMZ,TICKET-VIA,TRAIN-TABLE
	ZERO?	STACK \?ELS50
	GETP	TICKET,P?CAPACITY
	CALL	ZMEMZ,STACK,TRAIN-TABLE
	ZERO?	STACK /?THN47
?ELS50:	EQUAL?	OBJ,TICKET-OTHER \?ELS46
	CALL	ZMEMZ,TICKET-OTHER-VIA,TRAIN-TABLE
	ZERO?	STACK \?ELS46
	GETP	TICKET-OTHER,P?CAPACITY
	CALL	ZMEMZ,STACK,TRAIN-TABLE
	ZERO?	STACK \?ELS46
?THN47:	CALL2	ARREST-PLAYER,STR?33
	PRINTI	" looks at"
	CALL2	HIM-HER-IT,OBJ
	PRINTR	" and rushes away."
?ELS46:	FSET?	PLAYER,LOCKED /?ELS56
	PRINTI	" looks at"
	JUMP	?CND44
?ELS56:	FCLEAR	PLAYER,LOCKED
	SET	'TICKET-COUNT,0
	PRINTI	" punches"
?CND44:	MOVE	OBJ,PLAYER
	CALL2	PRINTT,OBJ
	PRINTR	" and then gives it back to you."
?ELS9:	CALL	PERSON-F,CONDUCTOR,ARG
	RSTACK	


	.FUNCT	CUSTOMS-AGENT-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,CUSTOMS-AGENT
	RSTACK	


	.FUNCT	CUSTOMS-AGENT-F,ARG=0,OBJ
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL	PERSON-F,CUSTOMS-AGENT,ARG
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?PASS \?ELS7
	IN?	CUSTOMS-AGENT,HERE \FALSE
	CALL2	DO-WALK,P?NORTH
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?SHOW \?ELS14
	EQUAL?	PRSI,GLOBAL-MONEY \?ELS14
	CALL	HE-SHE-IT,CUSTOMS-AGENT,TRUE-VALUE,STR?34
	PRINTR	" approvingly."
?ELS14:	CALL1	CONDUCTOR-GIVE-SHOW >OBJ
	ZERO?	OBJ /?ELS20
	EQUAL?	OBJ,PASSPORT,BRIEFCASE,MCGUFFIN \?ELS20
	EQUAL?	OBJ,PASSPORT \?ELS27
	CALL2	START-SENTENCE,CUSTOMS-AGENT
	FSET?	PASSPORT,LOCKED \?CND28
	FCLEAR	PASSPORT,LOCKED
	PRINTI	" looks at you and "
	PRINTD	PASSPORT
	PRINTI	", barely suppresses a smirk, stamps it, and then"
?CND28:	MOVE	PASSPORT,PLAYER
	PRINTI	" gives it back to you."
	CRLF	
	LOC	BRIEFCASE
	EQUAL?	STACK,HERE,PLAYER \TRUE
	ZERO?	BRIEFCASE-PASSED \TRUE
	PRINTI	"Then"
	CALL2	HE-SHE-IT,CUSTOMS-AGENT
	PRINTI	" notices the "
	PRINTD	BRIEFCASE
	PRINTR	", points to it and says, ""Fleegle quidpro mushnets?"""
?ELS27:	EQUAL?	OBJ,BRIEFCASE \?ELS43
	CALL	HE-SHE-IT,CUSTOMS-AGENT,TRUE-VALUE
	ZERO?	BRIEFCASE-PASSED /?ELS48
	PRINTR	" gives it back to you."
?ELS48:	FSET?	BRIEFCASE,OPENBIT /?ELS53
	PRINTR	" refuses it, making an ""open it"" gesture."
?ELS53:	IN?	MCGUFFIN,BRIEFCASE \?ELS57
	CALL1	CONFISCATE-MCGUFFIN
	RTRUE	
?ELS57:	SET	'BRIEFCASE-PASSED,TRUE-VALUE
	PRINTR	" looks in it and then gives it back to you."
?ELS43:	EQUAL?	OBJ,MCGUFFIN \FALSE
	CALL	HE-SHE-IT,CUSTOMS-AGENT,TRUE-VALUE
	CALL1	CONFISCATE-MCGUFFIN
	RSTACK	
?ELS20:	CALL	PERSON-F,CUSTOMS-AGENT,ARG
	RSTACK	


	.FUNCT	CONFISCATE-MCGUFFIN
	PRINTI	" examines"
	CALL2	HIM-HER-IT,MCGUFFIN
	PRINTI	" for a moment, realizes its import, confiscates it, and arrests you!"
	CRLF	
	CALL1	FINISH
	RSTACK	


	.FUNCT	WAITER-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,WAITER
	RSTACK	


	.FUNCT	WAITER-F,ARG=0
	EQUAL?	HERE,PANTRY \?ELS5
	CALL2	INVASION?,WAITER
	ZERO?	STACK \TRUE
?ELS5:	EQUAL?	ARG,M-WINNER \?ELS9
	CALL1	BRING-GIVE
	ZERO?	STACK \TRUE
	CALL	PERSON-F,WAITER,ARG
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?GOODBYE,V?THANKS \?ELS18
	CALL	ESTABLISH-GOAL-TRAIN,WAITER,PANTRY,DINER-CAR
	RFALSE	
?ELS18:	CALL	PERSON-F,WAITER,ARG
	RSTACK	


	.FUNCT	BRING-GIVE
	EQUAL?	PRSI,PLAYER \?ELS5
	EQUAL?	PRSA,V?BRING,V?GIVE \?ELS5
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?BUY,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSO,PLAYER \FALSE
	EQUAL?	PRSA,V?SBRING,V?SGIVE \FALSE
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?BUY,PRSI
	RTRUE	


	.FUNCT	COOK-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,COOK
	RSTACK	


	.FUNCT	COOK-F,ARG=0
	EQUAL?	HERE,GALLEY \?ELS5
	CALL2	INVASION?,COOK
	ZERO?	STACK \TRUE
?ELS5:	EQUAL?	ARG,M-WINNER \?ELS9
	CALL	PERSON-F,COOK,ARG
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS11
	PRINTI	"He's dressed all in white, from a "
	IN?	HAT-COOK,COOK \?ELS18
	PUSH	STR?36
	JUMP	?CND14
?ELS18:	PUSH	STR?37
?CND14:	PRINT	STACK
	PRINTI	" to his well-worn sneakers. You can tell from the size of his gut that he likes his own cooking."
	CRLF	
	CALL2	CARRY-CHECK,COOK
	RTRUE	
?ELS11:	CALL	PERSON-F,COOK,ARG
	RSTACK	


	.FUNCT	HAT-COOK-F
	EQUAL?	PRSA,V?TAKE,V?ASK-FOR \FALSE
	IN?	HAT-COOK,COOK \FALSE
	CALL2	BRIBED?,COOK
	ZERO?	STACK \?ELS12
	CALL2	START-SENTENCE,COOK
	PRINTR	" won't give you his hat yet."
?ELS12:	FSET	HAT-COOK,TAKEBIT
	RFALSE	


	.FUNCT	BRIBED?,PER,N
	EQUAL?	PER,BAD-SPY /FALSE
	GETP	PER,P?NORTH >N
	ZERO?	N /FALSE
	GETP	PER,P?SOUTH
	GRTR?	N,STACK \TRUE
	RFALSE


	.FUNCT	CLERK-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,CLERK
	RSTACK	


	.FUNCT	CLERK-F,ARG=0,N
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL	PERSON-F,CLERK,ARG
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?ASK-ABOUT \?ELS7
	IN?	CLERK,TICKET-AREA \?ELS7
	CALL	ZMEMQ,PRSI,STATIONS
	ZERO?	STACK /?ELS7
	GETP	PRSI,P?NORTH >N
	ZERO?	N /?ELS7
	PRINTI	"""Lizlong frmzi "
	PRINTC	CURRENCY-SYMBOL
	PRINTN	N
	PRINTR	"."""
?ELS7:	CALL	PERSON-F,CLERK,ARG
	RSTACK	


	.FUNCT	BOND-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,BOND
	RSTACK	


	.FUNCT	BOND-OTHER-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,BOND-OTHER
	RSTACK	


	.FUNCT	BOND-F,ARG=0
	CALL	PERSON-F,BOND,ARG
	RSTACK	


	.FUNCT	BOND-OTHER-F,ARG=0
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL	PERSON-F,BOND-OTHER,ARG
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?SHOW \?ELS7
	EQUAL?	PRSO,BOND-OTHER \?ELS7
	EQUAL?	PRSI,GUN \?ELS7
	SET	'SUPPRESS-INTERRUPT,TRUE-VALUE
	CALL	HE-SHE-IT,BOND-OTHER,TRUE-VALUE
	PRINTR	" bobs and weaves, trying to avoid your aim."
?ELS7:	EQUAL?	PRSA,V?SLAP /?THN14
	EQUAL?	PRSA,V?SHOOT,V?PUSH,V?MUNG /?THN14
	EQUAL?	PRSA,V?MOVE-DIR,V?KILL,V?ATTACK \?ELS13
?THN14:	SET	'SUPPRESS-INTERRUPT,TRUE-VALUE
	RANDOM	100
	LESS?	33,STACK /?ELS20
	EQUAL?	PRSA,V?SHOOT /?THN24
	EQUAL?	PRSI,GUN \?ELS23
?THN24:	IN?	GUN,POCKET \?CND26
	MOVE	GUN,PLAYER
?CND26:	PRINTI	"Your shot goes wild. "
	JUMP	?CND21
?ELS23:	PRINTI	"You go for him, but he dodges. "
?CND21:	CALL	HE-SHE-IT,BOND-OTHER,TRUE-VALUE
	PRINTI	" hesitates, "
	RANDOM	100
	LESS?	50,STACK /?ELS41
	PRINTR	"then lunges at you!"
?ELS41:	PRINTR	"preparing his next move."
?ELS20:	RANDOM	100
	LESS?	50,STACK /?ELS49
	ZERO?	PLAYER-SEATED \?ELS49
	CALL	HE-SHE-IT,BOND-OTHER,TRUE-VALUE
	PRINTI	" dodges away. A sudden lurch knocks you off balance, and your last sight is the ground speeding up to meet you."
	CRLF	
	CALL1	FINISH
	RSTACK	
?ELS49:	MOVE	BOND-OTHER,LIMBO-FWD
	CALL	QUEUE,I-BOND-OTHER,0
	SET	'SUPPRESS-INTERRUPT,FALSE-VALUE
	EQUAL?	PRSA,V?SHOOT /?THN59
	EQUAL?	PRSI,GUN \?ELS58
?THN59:	IN?	GUN,POCKET \?CND61
	MOVE	GUN,PLAYER
?CND61:	PRINTI	"Your shot almost misses, but it wings him and he "
	JUMP	?CND56
?ELS58:	PRINTI	"You lunge at him and almost miss, but he loses footing and "
?CND56:	PRINTR	"falls off the edge of the roof! The train quickly leaves his body behind."
?ELS13:	CALL	PERSON-F,BOND-OTHER,ARG
	RSTACK	


	.FUNCT	THIN-MAN-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,THIN-MAN
	RSTACK	


	.FUNCT	THIN-MAN-F,ARG=0
	CALL	PERSON-F,THIN-MAN,ARG
	RSTACK	


	.FUNCT	FAT-MAN-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,FAT-MAN
	RSTACK	


	.FUNCT	FAT-MAN-F,ARG=0
	CALL	PERSON-F,FAT-MAN,ARG
	RSTACK	


	.FUNCT	HUNK-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,HUNK
	RSTACK	


	.FUNCT	HUNK-F,ARG=0
	CALL	PERSON-F,HUNK,ARG
	RSTACK	


	.FUNCT	PEEL-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,PEEL
	RSTACK	


	.FUNCT	PEEL-F,ARG=0
	CALL	PERSON-F,PEEL,ARG
	RSTACK	


	.FUNCT	DUCHESS-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,DUCHESS
	RSTACK	


	.FUNCT	DUCHESS-F,ARG=0
	CALL	PERSON-F,DUCHESS,ARG
	RSTACK	


	.FUNCT	NATASHA-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,NATASHA
	RSTACK	


	.FUNCT	NATASHA-F,ARG=0
	CALL	PERSON-F,NATASHA,ARG
	RSTACK	


	.FUNCT	GUARD-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,GUARD
	RSTACK	


	.FUNCT	GUARD-F,ARG=0,OBJ
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL	PERSON-F,GUARD,ARG
	RSTACK	
?ELS5:	CALL2	PASS-OBJECT?,MCGUFFIN
	ZERO?	STACK /?ELS7
	CALL2	SHOW-MCGUFFIN,GUARD
	RSTACK	
?ELS7:	CALL1	CONDUCTOR-GIVE-SHOW >OBJ
	ZERO?	OBJ /?ELS9
	EQUAL?	OBJ,PASSPORT \?ELS9
	SET	'GUARD-SAW-PASSPORT,TRUE-VALUE
	SET	'GUARD-SUSPICION,0
	CALL2	START-SENTENCE,GUARD
	MOVE	PASSPORT,PLAYER
	PRINTI	" looks at you and "
	PRINTD	PASSPORT
	PRINTR	", barely suppresses a smirk, then gives it back to you."
?ELS9:	CALL	PERSON-F,GUARD,ARG
	RSTACK	


	.FUNCT	THUG-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,THUG
	RSTACK	


	.FUNCT	THUG-F,ARG=0,OBJ
	CALL	PERSON-F,THUG,ARG
	RSTACK	


	.FUNCT	DEFECTOR-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,DEFECTOR
	RSTACK	


	.FUNCT	DEFECTOR-F,ARG=0,OBJ
	CALL	PERSON-F,DEFECTOR,ARG
	RSTACK	


	.FUNCT	WAITRESS-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,WAITRESS
	RSTACK	


	.FUNCT	WAITRESS-F,ARG=0
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL1	BRING-GIVE
	ZERO?	STACK \TRUE
	CALL	PERSON-F,WAITRESS,ARG
	RSTACK	
?ELS5:	CALL	PERSON-F,WAITRESS,ARG
	RSTACK	


	.FUNCT	OFFICER-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	FCLEAR	OFFICER,NDESCBIT
	CALL2	DESCRIBE-PERSON,OFFICER
	RSTACK	


	.FUNCT	OFFICER-F,ARG=0
	FCLEAR	OFFICER,NDESCBIT
	EQUAL?	ARG,M-WINNER \?ELS5
	CALL	PERSON-F,OFFICER,ARG
	RSTACK	
?ELS5:	CALL2	PASS-OBJECT?,MCGUFFIN
	ZERO?	STACK /?ELS7
	CALL2	SHOW-MCGUFFIN,OFFICER
	RSTACK	
?ELS7:	CALL	PERSON-F,OFFICER,ARG
	RSTACK	


	.FUNCT	YOUNG-MAN-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,YOUNG-MAN
	RSTACK	


	.FUNCT	YOUNG-MAN-F,ARG=0
	CALL	PERSON-F,YOUNG-MAN,ARG
	RSTACK	


	.FUNCT	YOUNG-WOMAN-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,YOUNG-WOMAN
	RSTACK	


	.FUNCT	YOUNG-WOMAN-F,ARG=0
	CALL	PERSON-F,YOUNG-WOMAN,ARG
	RSTACK	


	.FUNCT	BOY-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,BOY
	RSTACK	


	.FUNCT	BOY-F,ARG=0
	CALL	PERSON-F,BOY,ARG
	RSTACK	


	.FUNCT	GIRL-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,GIRL
	RSTACK	


	.FUNCT	GIRL-F,ARG=0
	CALL	PERSON-F,GIRL,ARG
	RSTACK	


	.FUNCT	OLD-MAN-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,OLD-MAN
	RSTACK	


	.FUNCT	OLD-MAN-F,ARG=0
	CALL	PERSON-F,OLD-MAN,ARG
	RSTACK	


	.FUNCT	OLD-WOMAN-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,OLD-WOMAN
	RSTACK	


	.FUNCT	OLD-WOMAN-F,ARG=0
	CALL	PERSON-F,OLD-WOMAN,ARG
	RSTACK	


	.FUNCT	YOUNG-COUPLE-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,YOUNG-COUPLE
	RSTACK	


	.FUNCT	YOUNG-COUPLE-F,ARG=0
	CALL	PERSON-F,YOUNG-COUPLE,ARG
	RSTACK	


	.FUNCT	MIDDLE-COUPLE-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,MIDDLE-COUPLE
	RSTACK	


	.FUNCT	MIDDLE-COUPLE-F,ARG=0
	CALL	PERSON-F,MIDDLE-COUPLE,ARG
	RSTACK	


	.FUNCT	OLD-COUPLE-DESC,ARG
	EQUAL?	ARG,M-OBJDESC \FALSE
	CALL2	DESCRIBE-PERSON,OLD-COUPLE
	RSTACK	


	.FUNCT	OLD-COUPLE-F,ARG=0
	CALL	PERSON-F,OLD-COUPLE,ARG
	RSTACK	


	.FUNCT	ELIMINATE,TBL,CNT,N
	LESS?	CNT,N \FALSE
?PRG4:	ADD	1,CNT
	GET	TBL,STACK
	PUT	TBL,CNT,STACK
	IGRTR?	'CNT,N \?PRG4
	RTRUE	


	.FUNCT	MONEY?
	EQUAL?	PRSO,DOLLARS \?ELS5
	RETURN	P-NUMBER
?ELS5:	EQUAL?	PRSO,INTNUM \FALSE
	ZERO?	P-DOLLAR-FLAG /FALSE
	RETURN	P-AMOUNT


	.FUNCT	PERSON-F,PER,ARG,OBJ,X,Y,Z,L,C,N
	LOC	PER >L
	GETP	PER,P?CHARACTER >C
	IN?	PER,GLOBAL-OBJECTS \?ELS3
	CALL2	GLOBAL-PERSON,PER
	RSTACK	
?ELS3:	CALL2	META-LOC,PER
	EQUAL?	HERE,STACK /?CND1
	EQUAL?	EXTRA-C,C /?CND1
	GET	GLOBAL-CHARACTER-TABLE,C >PER
?CND1:	EQUAL?	ARG,M-WINNER \?ELS12
	CALL2	GRAB-ATTENTION,PER
	ZERO?	STACK /TRUE
	CALL2	COM-CHECK,PER >X
	ZERO?	X /?ELS19
	EQUAL?	X,M-FATAL \TRUE
	RFALSE	
?ELS19:	CALL2	PRODUCE-SOMETHING,PER
	RTRUE	
?ELS12:	EQUAL?	PRSA,V?ALARM \?ELS30
	CALL2	UNSNOOZE,PER
	ZERO?	STACK /FALSE
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?1
	PRINTR	" startled to see you so close!"
?ELS30:	EQUAL?	PRSA,V?GIVE \?ELS39
	EQUAL?	PRSI,PER \FALSE
	CALL2	HELD?,PRSO
	ZERO?	STACK /FALSE
	CALL2	GRAB-ATTENTION,PER
	ZERO?	STACK /TRUE
	SET	'X,0
	GETP	PER,P?NORTH >Y
	GETP	PER,P?SOUTH >Z
	CALL1	MONEY? >N
	ZERO?	N /?ELS52
	ADD	N,Z >X
	PUTP	PER,P?SOUTH,X
	GETP	PLAYER,P?SOUTH
	SUB	STACK,N
	PUTP	PLAYER,P?SOUTH,STACK
	JUMP	?CND50
?ELS52:	EQUAL?	PRSO,MCGUFFIN \?CND55
	FCLEAR	PRSO,TAKEBIT
?CND55:	MOVE	PRSO,PER
?CND50:	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?55
	PRINTI	" your gift and"
	CALL	HE-SHE-IT,PER,-1,STR?34
	PRINTC	32
	ADD	X,X
	GRTR?	Y,STACK \?ELS64
	PRINTR	"briefly."
?ELS64:	GRTR?	Y,X \?ELS68
	ZERO?	Z \?ELS73
	PRINTR	"hopefully."
?ELS73:	PRINTR	"longer."
?ELS68:	PRINTR	"broadly."
?ELS39:	EQUAL?	PRSA,V?LISTEN \?ELS85
	GETP	PER,P?LDESC >X
	EQUAL?	X,8 \FALSE
	CALL1	PRODUCE-GIBBERISH
	RTRUE	
?ELS85:	EQUAL?	PRSA,V?SLAP,V?MUNG \?ELS92
	CALL	ZMEMQ,PER,SPY-TABLE
	ZERO?	STACK /FALSE
	ZERO?	MUNGED-PERSON \FALSE
	CALL2	GRAB-ATTENTION,PER
	ZERO?	STACK /TRUE
	RANDOM	100
	LESS?	33,STACK /?CND103
	FSET	PER,MUNGBIT
	SET	'MUNGED-PERSON,PER
	GETP	PER,P?CHARACTER
	GET	GOAL-TABLES,STACK
	GET	STACK,GOAL-ENABLE >MUNGED-ENABLE
	RANDOM	6
	ADD	9,STACK
	CALL	QUEUE,I-COME-TO,STACK
	PUT	STACK,0,1
	PUTP	PER,P?LDESC,34
	CALL2	IMMOBILIZE,PER
	CALL2	ANYONE-VISIBLE?,PER >X
	ZERO?	X /TRUE
	CALL	ARREST-PLAYER,STR?56,X,TRUE-VALUE,PER
	RTRUE	
?CND103:	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?57
	PRINTI	" your thrust and"
	RANDOM	100
	LESS?	50,STACK /?ELS115
	CALL	HE-SHE-IT,PER,-1,STR?58
	PRINTI	" a chop to your "
	RANDOM	100
	LESS?	50,STACK /?ELS122
	PRINTR	"nose."
?ELS122:	PRINTR	"breadbasket."
?ELS115:	CALL	HE-SHE-IT,PER,-1,STR?59
	PRINTI	" you unconscious."
	CALL2	GENERIC-REST-ROOM-F,0 >X
	MOVE	PER,X
	CALL	FIND-FLAG-LG,X,DOORBIT >Y
	ZERO?	Y /?CND133
	FSET	Y,LOCKED
?CND133:	CALL1	UNCONSCIOUS-FCN
	RTRUE	
?ELS92:	EQUAL?	PRSA,V?SHOOT,V?KILL \?ELS137
	CALL	ZMEMQ,PER,SPY-TABLE
	ZERO?	STACK /FALSE
	EQUAL?	PRSI,KNIFE,GUN \FALSE
	FSET?	PER,PERSONBIT \FALSE
	ZERO?	KILLED-PERSON \FALSE
	FSET	PER,LOCKED
	SET	'KILLED-PERSON,PER
	EQUAL?	MUNGED-PERSON,PER \?CND145
	SET	'MUNGED-PERSON,FALSE-VALUE
	CALL	QUEUE,I-COME-TO,0
?CND145:	PUTP	PER,P?LDESC,36
	CALL2	IMMOBILIZE,PER
	CALL2	ANYONE-VISIBLE?,PER >X
	ZERO?	X /?CND148
	CALL	ARREST-PLAYER,STR?28,X,TRUE-VALUE,PER
?CND148:	FCLEAR	PER,PERSONBIT
	RTRUE	
?ELS137:	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH \?ELS152
	EQUAL?	PER,PRSO \FALSE
	FSET?	PER,PERSONBIT \FALSE
	FSET?	PER,MUNGBIT /FALSE
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?5
	PRINTI	" you away and"
	CALL	HE-SHE-IT,PER,-1,STR?60
	PRINTI	", "
	CALL1	PRODUCE-GIBBERISH
	RTRUE	
?ELS152:	EQUAL?	PRSA,V?SHOW \?ELS163
	EQUAL?	PER,PRSO \FALSE
	CALL2	GRAB-ATTENTION,PER
	ZERO?	STACK /TRUE
	EQUAL?	PRSI,GUN \?ELS175
	EQUAL?	PER,CONDUCTOR,GUARD,WAITER \?ELS178
	CALL	ARREST-PLAYER,STR?61,PER,TRUE-VALUE,GUN
	RTRUE	
?ELS178:	CALL2	ANYONE-VISIBLE?,PER >X
	ZERO?	X /?CND176
	CALL	ARREST-PLAYER,STR?61,X,TRUE-VALUE,GUN
?CND176:	CALL2	GENERIC-REST-ROOM-F,0
	CALL	ESTABLISH-GOAL,PER,STACK
	EQUAL?	PER,BAD-SPY \?CND183
	SET	'BAD-SPY-KNOWS-YOU,TRUE-VALUE
	GET	GOAL-TABLES,BAD-SPY-C
	PUT	STACK,GOAL-FUNCTION,TRAVELER-FLEES
	CALL2	INT,I-TRAVELER
	PUT	STACK,0,0
?CND183:	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?12
	CALL	HIM-HER-IT,PER,FALSE-VALUE,TRUE-VALUE
	PRINTI	" eyes wider and"
	CALL	HE-SHE-IT,PER,-1,STR?6
	PRINTI	", "
	CALL1	PRODUCE-GIBBERISH
	RTRUE	
?ELS175:	EQUAL?	PRSI,CIGARETTE \FALSE
	IN?	LIGHTER,PRSO /?ELS195
	EQUAL?	PRSO,WAITRESS,WAITER \?ELS195
	CALL	CALL-FOR-PROP,LIGHTER,PRSO
	ZERO?	STACK /FALSE
?ELS195:	EQUAL?	PRSO,BAD-SPY /FALSE
	FSET	LIGHTER,TAKEBIT
	FSET	LIGHTER,TOUCHBIT
	MOVE	LIGHTER,PLAYER
	CALL	HE-SHE-IT,PER,TRUE-VALUE
	PRINTI	" kindly"
	CALL	HE-SHE-IT,PER,-1,STR?62
	PRINTI	" you a "
	PRINTD	LIGHTER
	PRINTR	"."
?ELS163:	CALL2	ASK-WHAT?,PER >OBJ
	ZERO?	OBJ /?ELS199
	CALL2	GRAB-ATTENTION,PER
	ZERO?	STACK /TRUE
	CALL2	SAID-TO,PER
	ZERO?	ON-TRAIN \?ELS207
	CALL	ZMEMZ,OBJ,TRAIN-TABLE
	ZERO?	STACK /?ELS207
	EQUAL?	PER,CONDUCTOR,GUARD \?ELS207
	CALL	HE-SHE-IT,PRSI,TRUE-VALUE,STR?63
	PRINTR	" to this train track."
?ELS207:	CALL	DONT-KNOW,PER,OBJ
	RSTACK	
?ELS199:	CALL2	COMMON-OTHER,PER
	RSTACK	


	.FUNCT	ASK-WHAT?,PER
	EQUAL?	PRSA,V?CONFRONT,V?ASK-ABOUT \?ELS5
	ZERO?	PRSI /FALSE
	EQUAL?	PRSO,PER \FALSE
	RETURN	PRSI
?ELS5:	EQUAL?	PRSA,V?WHAT,V?FIND \FALSE
	ZERO?	PRSO /FALSE
	IN?	PRSO,GLOBAL-OBJECTS \FALSE
	RETURN	PRSO


	.FUNCT	IMMOBILIZE,PER,X
	GETP	PER,P?CHARACTER
	GET	GOAL-TABLES,STACK >X
	PUT	X,GOAL-ENABLE,0
	FSET	PER,OPENBIT
	FSET	PER,TAKEBIT
	FCLEAR	PER,TOUCHBIT
	EQUAL?	PER,BAD-SPY \?CND1
	IN?	GUN,OTHER-LIMBO-FWD \?CND1
	MOVE	GUN,PER
?CND1:	FIRST?	PER >X /?KLU22
?KLU22:	
?PRG6:	ZERO?	X \?ELS10
	JUMP	?REP7
?ELS10:	FSET	X,TAKEBIT
	NEXT?	X >X /?KLU23
?KLU23:	JUMP	?PRG6
?REP7:	CALL	HE-SHE-IT,PER,TRUE-VALUE
	IN?	BRIEFCASE,PER \?CND15
	LOC	PER
	MOVE	BRIEFCASE,STACK
	CALL	HE-SHE-IT,PER,-1,STR?64
	CALL2	HIM-HER-IT,BRIEFCASE
	PRINTI	" and"
?CND15:	CALL	HE-SHE-IT,PER,-1,STR?65
	PRINTC	32
	CALL1	GROUND-DESC
	PRINT	STACK
	PRINTR	"."


	.FUNCT	UNCONSCIOUS-FCN,TIM=0,HR
	ZERO?	TIM \?CND1
	RANDOM	6
	ADD	9,STACK >TIM
?CND1:	SET	'MUNGED-PERSON,PLAYER
	SET	'HR,HERE
	MOVE	PLAYER,UNCONSCIOUS
	SET	'HERE,UNCONSCIOUS
	PRINTI	"...

"
	CALL1	STATUS-LINE
	CALL	QUEUE,I-COME-TO,TIM
	PUT	STACK,0,1
	CALL	V-WAIT,TIM,FALSE-VALUE,TRUE-VALUE
	MOVE	PLAYER,HR
	SET	'HERE,HR
	ZERO?	PLAYER-SEATED \TRUE
	SUB	0,HERE >PLAYER-SEATED
	RTRUE	


	.FUNCT	ANYONE-VISIBLE?,VICTIM=0,CNT,X,VAL=0
	SET	'X,COR-ALL-DIRS
	SET	'COR-ALL-DIRS,TRUE-VALUE
	SET	'CNT,0
?PRG1:	IGRTR?	'CNT,CHARACTER-MAX \?ELS5
	SET	'VAL,FALSE-VALUE
	JUMP	?REP2
?ELS5:	GET	CHARACTER-TABLE,CNT >VAL
	EQUAL?	VICTIM,VAL \?ELS7
	JUMP	?PRG1
?ELS7:	CALL2	VISIBLE?,VAL
	ZERO?	STACK /?PRG1
?REP2:	ZERO?	VAL /?CND10
	SET	'COR-ALL-DIRS,X
	RETURN	VAL
?CND10:	GET	EXTRA-TABLE,0 >CNT
?PRG13:	GET	EXTRA-TABLE,CNT >VAL
	EQUAL?	VICTIM,VAL \?ELS17
	JUMP	?PRG13
?ELS17:	CALL2	VISIBLE?,VAL
	ZERO?	STACK /?ELS19
	JUMP	?REP14
?ELS19:	DLESS?	'CNT,1 \?PRG13
	SET	'VAL,FALSE-VALUE
?REP14:	SET	'COR-ALL-DIRS,X
	RETURN	VAL


	.FUNCT	BODY-F
	ZERO?	KILLED-PERSON \?ELS5
	CALL2	NOT-HERE,BODY
	RSTACK	
?ELS5:	CALL	DO-INSTEAD-OF,KILLED-PERSON,BODY
	RTRUE	


	.FUNCT	I-COME-TO,GARG=0,P,L,V,X
	ZERO?	IDEBUG \?THN4
	EQUAL?	GARG,G-DEBUG \?CND1
?THN4:	PRINTI	"[I-COME-TO:"
	EQUAL?	GARG,G-DEBUG /FALSE
?CND1:	SET	'P,MUNGED-PERSON
	ZERO?	P \?ELS15
	ZERO?	IDEBUG /FALSE
	PRINTI	"(0)]"
	CRLF	
	RFALSE	
?ELS15:	SET	'MUNGED-PERSON,FALSE-VALUE
	EQUAL?	P,PLAYER \?CND24
	PRINTI	"You shake your head and come to."
	CRLF	
	RETURN	2
?CND24:	CALL2	META-LOC,P
	MOVE	P,STACK
	FCLEAR	P,TAKEBIT
	FCLEAR	P,MUNGBIT
	FCLEAR	P,TOUCHBIT
	PUTP	P,P?LDESC,1
	GETP	P,P?CHARACTER
	GET	GOAL-TABLES,STACK
	PUT	STACK,GOAL-ENABLE,MUNGED-ENABLE
	FIRST?	P >X /?KLU81
?KLU81:	
?PRG31:	ZERO?	X \?ELS35
	JUMP	?REP32
?ELS35:	FCLEAR	X,TAKEBIT
	NEXT?	X >X /?KLU82
?KLU82:	JUMP	?PRG31
?REP32:	EQUAL?	P,BAD-SPY \?CND38
	IN?	GUN,P \?CND38
	MOVE	GUN,OTHER-LIMBO-FWD
?CND38:	CALL2	VISIBLE?,P >V
	ZERO?	V \?THN46
	ZERO?	DEBUG /?CND43
?THN46:	ZERO?	V \?CND48
	PRINTC	91
?CND48:	CALL2	START-SENTENCE,P
	CALL2	WHERE?,P
	ZERO?	STACK /?CND53
	PRINTI	","
?CND53:	PRINTI	" shakes"
	CALL	HIM-HER-IT,P,FALSE-VALUE,TRUE-VALUE
	PRINTI	" head and comes to."
	CRLF	
?CND43:	EQUAL?	P,CONTACT \?ELS62
	CALL	ARREST-PLAYER,STR?56,CONTACT,V,PLAYER
	JUMP	?CND60
?ELS62:	EQUAL?	P,BAD-SPY \?CND60
	SET	'BAD-SPY-KNOWS-YOU,TRUE-VALUE
	LOC	P >L
	CALL	MCG-SAFE?,MCGUFFIN,L
	ZERO?	STACK /?ELS67
	EQUAL?	L,HERE \?CND65
	PRINTI	"Then"
	CALL2	HE-SHE-IT,P
	PRINTI	" sees you, jumps up, and lands a haymaker on you."
	CALL1	UNCONSCIOUS-FCN
	JUMP	?CND65
?ELS67:	FCLEAR	BAD-SPY,TOUCHBIT
	SET	'BAD-SPY-DONE-PEEKING,FALSE-VALUE
	GET	GOAL-TABLES,BAD-SPY-C >X
	PUT	X,GOAL-SCRIPT,I-BAD-SPY
	PUT	X,GOAL-ENABLE,1
	CALL	ESTABLISH-GOAL-TRAIN,BAD-SPY,HERE,CAR-HERE
?CND65:	
?CND60:	ZERO?	IDEBUG /?CND75
	PRINTN	V
	PRINTI	"]"
	CRLF	
?CND75:	RETURN	V


	.FUNCT	MCG-SAFE?,OBJ,L
	IN?	OBJ,CONTACT /TRUE
	CALL2	META-LOC,OBJ
	EQUAL?	L,STACK \?ELS7
	LOC	OBJ
	FSET?	STACK,PERSONBIT \TRUE
?ELS7:	CALL	ZMEMQ,OBJ,FILM-TBL
	ZERO?	STACK /?ELS14
	CALL	MCG-SAFE?,FILM,L
	ZERO?	STACK \TRUE
?ELS14:	CALL	ZMEMQ,OBJ,BRIEFCASE-TBL
	ZERO?	STACK /FALSE
	IN?	BRIEFCASE,CONTACT /TRUE
	CALL2	META-LOC,BRIEFCASE
	EQUAL?	L,STACK \FALSE
	LOC	BRIEFCASE
	FSET?	STACK,PERSONBIT \TRUE
	RFALSE


	.FUNCT	CARRY-CHECK,PER
	CALL	PRINT-CONT,PER,0,TRUE-VALUE
	RSTACK	


	.FUNCT	COM-CHECK,PER
	EQUAL?	PRSA,V?WALK-TO \?ELS5
	CALL2	PRODUCE-SOMETHING,PER
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?THANKS \?ELS12
	RETURN	2
?ELS12:	EQUAL?	PRSA,V?TAKE /?THN17
	EQUAL?	PRSA,V?SEND-TO,V?SEND,V?BRING \?ELS16
?THN17:	IN?	PRSO,PLAYER \FALSE
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?GIVE,PRSO,PER
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?EXAMINE \?ELS25
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?SHOW,PER,PRSO
	RTRUE	
?ELS25:	EQUAL?	PRSA,V?GIVE \?ELS27
	EQUAL?	PRSI,PLAYER \?ELS27
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?TAKE,PRSO,PER
	RTRUE	
?ELS27:	EQUAL?	PRSA,V?SGIVE \?ELS31
	EQUAL?	PRSO,PLAYER \?ELS31
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?TAKE,PRSI,PER
	RTRUE	
?ELS31:	EQUAL?	PRSA,V?GOODBYE,V?HELLO \?ELS35
	ZERO?	PRSO /?THN41
	EQUAL?	PRSO,PER \FALSE
?THN41:	SET	'WINNER,PLAYER
	CALL	PERFORM,PRSA,PER
	RTRUE	
?ELS35:	EQUAL?	PRSA,V?INVENTORY \?ELS44
	CALL2	CARRY-CHECK,PER
	ZERO?	STACK \TRUE
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?1
	PRINTR	"n't holding anything."
?ELS44:	EQUAL?	PRSA,V?TELL-ABOUT \?ELS51
	EQUAL?	PRSO,PLAYER \FALSE
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,PER,PRSI
	RTRUE	
?ELS51:	EQUAL?	PRSA,V?WAIT-FOR \?ELS58
	EQUAL?	PRSO,ROOMS,PLAYER \?ELS58
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?$CALL,PER
	RTRUE	
?ELS58:	EQUAL?	PRSA,V?TALK-ABOUT,V?WHAT \FALSE
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,PER,PRSO
	RTRUE	


	.FUNCT	COMMON-OTHER,PER,LPER=0,X,N
	IN?	PER,GLOBAL-OBJECTS \?ELS3
	GETP	PER,P?CHARACTER
	GET	CHARACTER-TABLE,STACK >LPER
	JUMP	?CND1
?ELS3:	SET	'LPER,PER
?CND1:	EQUAL?	PRSA,V?ASK /FALSE
	EQUAL?	PRSA,V?EXAMINE \?ELS12
	GETP	LPER,P?TEXT >X
	ZERO?	X /?ELS15
	PRINT	X
	CRLF	
	JUMP	?CND13
?ELS15:	CALL	ZMEMQ,LPER,EXTRA-TABLE >X
	ZERO?	X /?CND13
	GET	EXTRA-SEEN-TABLE,X >N
	LESS?	0,N /?CND20
	SUB	0,N
	ADD	1,STACK >N
	PUT	EXTRA-SEEN-TABLE,X,N
?CND20:	ADD	N,X >N
	CALL	HE-SHE-IT,LPER,TRUE-VALUE,STR?1
	PRINTI	" dressed for "
	CALL	PICK-THIS,DRESSED-FOR-TBL,N
	PRINT	STACK
	PRINTI	", in shades of "
	CALL	PICK-THIS,COLOR-TBL,N
	PRINT	STACK
	PRINTI	", with "
	CALL	PICK-THIS,ACCESS-TBL,N
	PRINT	STACK
	PRINTI	". "
	GETP	LPER,P?LDESC >X
	IN?	LPER,HERE \?THN28
	EQUAL?	X,2,32,33 /?THN28
	EQUAL?	X,34,36 \?ELS27
?THN28:	CRLF	
	RTRUE	
?ELS27:	CALL	PICK-THIS,REMARKS-TBL,N
	CALL	STACK,LPER
	RTRUE	
?CND13:	CALL2	THIS-IS-IT,LPER
	IN?	LPER,HERE \?CND32
	CALL2	CARRY-CHECK,LPER
	ZERO?	STACK /?CND32
	SET	'X,TRUE-VALUE
?CND32:	FSET?	LPER,MUNGBIT \?ELS40
	ZERO?	X /?CND41
	PRINTI	"And"
?CND41:	ZERO?	X \?PRD46
	PUSH	1
	JUMP	?PRD47
?PRD46:	PUSH	0
?PRD47:	CALL	HE-SHE-IT,LPER,STACK,STR?1
	SET	'X,TRUE-VALUE
	PRINTI	" out cold."
	CRLF	
	RETURN	X
?ELS40:	FSET?	LPER,PERSONBIT /?CND38
	ZERO?	X /?CND52
	PRINTI	"And"
?CND52:	FSET	LPER,PERSONBIT
	ZERO?	X \?PRD57
	PUSH	1
	JUMP	?PRD58
?PRD57:	PUSH	0
?PRD58:	CALL	HE-SHE-IT,LPER,STACK,STR?1
	FCLEAR	LPER,PERSONBIT
	SET	'X,TRUE-VALUE
	PRINTI	" dead."
	CRLF	
	RETURN	X
?CND38:	RETURN	X
?ELS12:	EQUAL?	PRSO,PER \FALSE
	EQUAL?	PRSA,V?SHOW \FALSE
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSI
	RTRUE	


	.FUNCT	PICK-THIS,FROB,N
	GET	FROB,0
	MOD	N,STACK
	ADD	1,STACK
	GET	FROB,STACK
	RSTACK	


	.FUNCT	REM-NULL,PER
	CRLF	
	RTRUE	


	.FUNCT	REM-EYES-BLK,PER
	CALL	HIM-HER-IT,PER,TRUE-VALUE,TRUE-VALUE
	PRINTR	" glittering black eyes turn away whenever you try to look into them."


	.FUNCT	REM-EYES-BLU,PER
	CALL	HIM-HER-IT,PER,TRUE-VALUE,TRUE-VALUE
	PRINTR	" lucid blue eyes look straight into yours, without a flinch."


	.FUNCT	REM-FINGER,PER
	CALL	HIM-HER-IT,PER,TRUE-VALUE,TRUE-VALUE
	PRINTR	" teeth and fingers are well-stained with nicotine."


	.FUNCT	REM-MARK,PER
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?2
	PRINTR	" a birthmark on one cheek like a wine stain."


	.FUNCT	REM-WART,PER
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?2
	PRINTR	" a wart that's hard to avoid looking at."


	.FUNCT	NEW-LDESC,OBJ,STR=0,HERE
	LOC	OBJ >HERE
	FSET?	OBJ,PERSONBIT /?ELS3
	SET	'STR,36
	JUMP	?CND1
?ELS3:	FSET?	OBJ,MUNGBIT \?ELS5
	SET	'STR,34
	JUMP	?CND1
?ELS5:	ZERO?	STR /?ELS7
	JUMP	?CND1
?ELS7:	CALL2	ON-PLATFORM?,HERE
	ZERO?	STACK /?ELS9
	CALL2	PICK-ONE,PLATFORM-ACTS >STR
	JUMP	?CND1
?ELS9:	CALL	ZMEMQ,HERE,STATION-ROOMS
	ZERO?	STACK /?ELS11
	CALL2	PICK-ONE,STATION-ACTS >STR
	JUMP	?CND1
?ELS11:	FSET?	OBJ,PLURALBIT \?ELS13
	CALL2	PICK-ONE,PLURAL-ACTS >STR
	JUMP	?CND1
?ELS13:	CALL2	PICK-ONE,TOURIST-ACTS >STR
?CND1:	EQUAL?	STR,2 \?ELS18
	EQUAL?	OBJ,BAD-SPY /?THN22
	CALL	ZMEMQ,HERE,CAR-ROOMS-CORRID
	ZERO?	STACK /?ELS21
?THN22:	SET	'STR,3
	JUMP	?CND16
?ELS21:	CALL	ZMEMQ,HERE,CAR-ROOMS-VESTIB
	ZERO?	STACK /?CND16
	SET	'STR,1
	JUMP	?CND16
?ELS18:	EQUAL?	STR,5 \?ELS27
	CALL	CALL-FOR-PROP,LIGHTER,OBJ
	ZERO?	STACK \?CND28
	SET	'STR,4
?CND28:	CALL	CALL-FOR-PROP,CIGARETTE,OBJ
	ZERO?	STACK \?CND16
	SET	'STR,4
	JUMP	?CND16
?ELS27:	EQUAL?	STR,6,7 \?ELS35
	CALL	CALL-FOR-PROP,NEWSPAPER,OBJ
	ZERO?	STACK \?CND16
	SET	'STR,4
	JUMP	?CND16
?ELS35:	EQUAL?	STR,11,31 \?CND16
	CALL	CALL-FOR-PROP,LUGGAGE,OBJ
	ZERO?	STACK \?CND16
	SET	'STR,12
?CND16:	GETP	OBJ,P?LDESC
	EQUAL?	STR,STACK /?CND44
	FCLEAR	OBJ,TOUCHBIT
?CND44:	PUTP	OBJ,P?LDESC,STR
	RETURN	STR


	.FUNCT	CALL-FOR-PROP,OBJ,PER
	EQUAL?	PER,PLAYER /FALSE
	FSET?	OBJ,TOUCHBIT /FALSE
	CALL2	META-LOC,OBJ
	FSET?	STACK,SEENBIT /FALSE
	FCLEAR	OBJ,TAKEBIT
	MOVE	OBJ,PER
	GETP	PER,P?CAR
	PUTP	OBJ,P?CAR,STACK
	RETURN	OBJ


	.FUNCT	UNSNOOZE,PER
	GETP	PER,P?LDESC
	EQUAL?	STACK,2 \FALSE
	FCLEAR	PER,TOUCHBIT
	PUTP	PER,P?LDESC,1
	RTRUE	


	.FUNCT	DESCRIBE-PERSON,OBJ,STR=0,GOBJ,RM,DR
	FSET?	OBJ,NDESCBIT /FALSE
	EQUAL?	OBJ,BAD-SPY \?ELS5
	CALL2	QUEUED?,I-TRAVELER
	ZERO?	STACK /?ELS5
	CALL2	I-TRAVELER,TRUE-VALUE
	SET	'SUPPRESS-INTERRUPT,TRUE-VALUE
	RTRUE	
?ELS5:	FSET?	OBJ,SEENBIT \?ELS9
	CALL2	START-SENTENCE,OBJ
	CALL	HE-SHE-IT,OBJ,-1,STR?1
	JUMP	?CND1
?ELS9:	PRINTI	"There's "
	CALL2	PRINTA,OBJ
?CND1:	PRINTI	" here, "
	GETP	OBJ,P?LDESC >STR
	ZERO?	STR \?ELS20
	CALL2	NEW-LDESC,OBJ >STR
	JUMP	?CND18
?ELS20:	FSET?	OBJ,TOUCHBIT \?CND18
	EQUAL?	STR,36 /?CND18
	PRINTI	"still "
?CND18:	IN?	BRIEFCASE,OBJ \?CND27
	PRINTI	"holding the "
	PRINTD	BRIEFCASE
	PRINTI	" and "
?CND27:	EQUAL?	STR,PEEKING-CODE /?ELS34
	EQUAL?	STR,5 \?ELS37
	CALL2	THIS-IS-IT,CIGARETTE
	JUMP	?CND35
?ELS37:	EQUAL?	STR,6,7 \?ELS39
	CALL2	THIS-IS-IT,NEWSPAPER
	JUMP	?CND35
?ELS39:	EQUAL?	STR,11 \?ELS41
	CALL2	THIS-IS-IT,LUGGAGE
	JUMP	?CND35
?ELS41:	EQUAL?	STR,12 \?ELS43
	CALL2	THIS-IS-IT,TIMETABLE
	JUMP	?CND35
?ELS43:	EQUAL?	STR,31 \?CND35
	CALL2	THIS-IS-IT,PASSPORT
?CND35:	GET	ACT-STRINGS,STR
	PRINT	STACK
	JUMP	?CND32
?ELS34:	LOC	OBJ
	GETPT	STACK,P?IN >RM
	ZERO?	RM /?ELS49
	PTSIZE	RM
	EQUAL?	STACK,DEXIT \?CND50
	GET	RM,DEXITOBJ >DR
?CND50:	ZERO?	DR /?ELS55
	FSET?	DR,LOCKED \?ELS55
	PRINTI	"trying"
	CALL2	HIM-HER-IT,DR
	JUMP	?CND32
?ELS55:	PRINTI	"peeking into"
	GET	RM,REXIT
	CALL2	PRINTT,STACK
	JUMP	?CND32
?ELS49:	PRINTI	"looking around"
?CND32:	FSET	OBJ,TOUCHBIT
	FSET	OBJ,SEENBIT
	GETP	OBJ,P?CHARACTER >GOBJ
	ZERO?	GOBJ /?CND68
	GET	GLOBAL-CHARACTER-TABLE,GOBJ >GOBJ
	EQUAL?	OBJ,GOBJ /?CND68
	FSET	GOBJ,TOUCHBIT
	FSET	GOBJ,SEENBIT
?CND68:	PRINTI	"."
	EQUAL?	STR,14,17 /?THN81
	EQUAL?	STR,19,28 \?ELS80
?THN81:	PRINTC	32
	RTRUE	
?ELS80:	CRLF	
	RTRUE	


	.FUNCT	DONT-KNOW,PER,OBJ
	CALL2	PRODUCE-SOMETHING,PER
	RTRUE	


	.FUNCT	GLOBAL-PERSON,ARG=0,L
	EQUAL?	PRSA,V?WHAT /FALSE
	EQUAL?	PRSA,V?WALK-TO,V?WAIT-FOR,V?PHONE /FALSE
	EQUAL?	PRSA,V?LOOK-UP,V?FOLLOW,V?FIND /FALSE
	EQUAL?	PRSA,V?$WHERE \?ELS9
	ZERO?	ARG \FALSE
	GETP	PRSO,P?CHARACTER
	GET	CHARACTER-TABLE,STACK >PRSO
	RFALSE	
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS14
	GETP	PRSO,P?CHARACTER >L
	ZERO?	L /?ELS14
	ZERO?	ARG /?ORP20
	PUSH	ARG
	JUMP	?THN17
?ORP20:	GET	CHARACTER-TABLE,L
?THN17:	POP	'L
	ZERO?	L /?ELS14
	CALL2	CORRIDOR-LOOK,L
	ZERO?	STACK \FALSE
	CALL2	NOT-HERE,PRSO
	RSTACK	
?ELS14:	EQUAL?	PRSA,V?TELL-ABOUT,V?TELL,V?REPLY /?THN30
	EQUAL?	PRSA,V?HELLO,V?ASK-FOR,V?ASK-ABOUT \?ELS27
?THN30:	ZERO?	PRSO /?ELS27
	FSET?	PRSO,PERSONBIT \?ELS27
	IN?	PRSO,GLOBAL-OBJECTS /?ELS27
	EQUAL?	PRSA,V?REPLY \FALSE
	SET	'PRSA,V?TELL
	RFALSE	
?ELS27:	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-ABOUT \?ELS36
	ZERO?	PRSI /?ELS36
	GETP	PRSI,P?CHARACTER >L
	ZERO?	L /?ELS36
	IN?	PRSI,GLOBAL-OBJECTS \?ELS36
	ZERO?	ARG /?ORP42
	PUSH	ARG
	JUMP	?THN39
?ORP42:	GET	CHARACTER-TABLE,L
?THN39:	CALL	PERFORM,PRSA,PRSO,STACK
	RTRUE	
?ELS36:	SET	'P-CONT,FALSE-VALUE
	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-ABOUT /?THN48
	ZERO?	NOW-PRSI \?ELS47
?THN48:	CALL2	NOT-HERE-PERSON,PRSO
	RTRUE	
?ELS47:	ZERO?	PRSI /?ELS51
	CALL2	NOT-HERE-PERSON,PRSI
	RTRUE	
?ELS51:	CALL2	NOT-HERE-PERSON,WINNER
	RTRUE	


	.FUNCT	NOT-HERE-PERSON,PER,L
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTI	"("
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?1
	GETP	PER,P?CHARACTER >L
	ZERO?	L /?CND3
	GET	CHARACTER-TABLE,L >PER
?CND3:	CALL2	VISIBLE?,PER
	ZERO?	STACK /?ELS8
	PRINTI	"n't close enough"
	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?CND11
	PRINTI	" to hear you"
?CND11:	PRINTI	"."
	JUMP	?CND6
?ELS8:	PRINTI	"n't here!"
?CND6:	PRINTR	")"


	.FUNCT	PRODUCE-SOMETHING,PER
	EQUAL?	PER,CONDUCTOR,GUARD,THUG /?THN6
	RANDOM	100
	LESS?	50,STACK /?ELS5
?THN6:	CALL1	PRODUCE-GIBBERISH
	RSTACK	
?ELS5:	RANDOM	100
	LESS?	50,STACK /?ELS9
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?10
	PRINTI	" around fearfully but"
	CALL	HE-SHE-IT,PER,-1,STR?6
	PRINTR	" nothing."
?ELS9:	PRINTI	"""Mrzni Amerikan? Globfrp "
	CALL2	PICK-ONE-NEW,CELEBS
	PRINT	STACK
	PRINTR	"?"""


	.FUNCT	PRODUCE-GIBBERISH,N=0,COUNT,SUPER-COUNTER
	ZERO?	N \?CND1
	RANDOM	100
	LESS?	50,STACK /?ELS6
	SET	'N,1
	JUMP	?CND1
?ELS6:	SET	'N,2
?CND1:	PRINTC	34
	CALL2	PICK-ONE-NEW,VOWELS
	PRINTC	STACK
	SET	'SUPER-COUNTER,0
?PRG9:	INC	'SUPER-COUNTER
	SET	'COUNT,0
?PRG11:	INC	'COUNT
	CALL2	PICK-ONE-NEW,GIBBERISH
	PRINT	STACK
	EQUAL?	COUNT,5 \?PRG11
	EQUAL?	SUPER-COUNTER,N \?PRG9
	RANDOM	100
	LESS?	50,STACK /?ELS23
	PRINTR	"."""
?ELS23:	PRINTI	"?"""
	CRLF	
	RTRUE	

	.ENDI
