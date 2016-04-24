;-------------------------------------------------------------------------------------------
; ex 4.9 在0020H单元和020AH单元开始，分别存放两个各为10个字节的未组合BCD数（地址最低处存放最低字节）。
;计算两个为组合BCD数的和，存放在0214H单元开始的存储单元中

STACK SEGMENT
	DB 15 DUP(?)
STACK ENDS

DATA SEGMENT
	
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK

	;PUT DATA INTO MEM

	;ADDRESS IN BX,CX,DX
	;DATA IN AX
	MOV BX, 0020H
	MOV CX, 10
	MOV DX, 020AH

	;CLEAN CF
	MOV AX, 0
	RCR AX, 1

	LOOP AGAIN
	; CALCULATE COMPLETE

	MOV CX, 10
	MOV BX, 0214H + 10
	LOOP MOVERESULT

	HLT

AGAIN: 
	MOV AL, [BX]
	MOV AH, [DX]
	ADC AL, AH
	AAA
	INC BX
	INC DX
	PUSH AL

MOVERESULT:
	POP AL
	MOV [BX], AL
	DEC BX

CODE ENDS

;-------------------------------------------------------------------------------------------
;ex 4.10
;自STRING单元开始有1000个数（字节），针对下面情况编程将它们中的最小值、最大值找出来，并分别存放在5000H和5001H中
;	1、无符号数
;	2、带符号数
;===============
;1、无符号数

DATA SEGMENT
	STRING DB ?
DATA ENDS

CODE SEGMENT
	
	ASSUME DS:DATA, CS:CODE

	;将第一个单元的数作为初始最大、最小值
	;依次将每一个数与当前最大、最小值比较，更新
	;最大值存在	BH
	;最小值存在  BL

	;INITIALIZE STRING
	MOV STRING 010000H

	;INITIALIZE MAX & MIN
	MOV BL, [STRING]
	MOV BH, [STRING]

	MOV CX, 1000
	LOOP AGAIN

	HLT

AGAIN:
	MOV AL, [STRING]
	JMP COMPARE
	INC STRING

COMPARE:
	CMP AL, BL
	JC RFSMIN
	CMP AL, BH
	JNC RFSMAX


RFSMIN:
	MOV AL, BL

RFSMAX:
	MOV AL, BH
CODE ENDS


;===============
;2、带符号数

DATA SEGMENT
	STRING DB ?
DATA ENDS

CODE SEGMENT
	
	ASSUME DS:DATA, CS:CODE

	;将第一个单元的数作为初始最大、最小值
	;依次将每一个数与当前最大、最小值比较，更新
	;最大值存在	BH
	;最小值存在  BL

	;INITIALIZE STRING
	MOV STRING 010000H

	;INITIALIZE MAX & MIN
	MOV BL, [STRING]
	MOV BH, [STRING]

	MOV CX, 1000
	LOOP AGAIN

	HLT

AGAIN:
	MOV AL, [STRING]
	JMP COMPARE
	INC STRING

COMPARE:
	CMP AL, BL
	JO RFSMIN
	CMP AL, BH
	JNO RFSMAX


RFSMIN:
	MOV AL, BL

RFSMAX:
	MOV AL, BH
CODE ENDS


;-------------------------------------------------------------------------------------------
;ex 4.11
;已知数组A包含10个互不相等的整数，数组B包含15个互不相等的整数。
;编写程序 将既在A中出现又在B中出现的偶数存放在数组C中

;问题：整数位数如何确定？数组如何定义？

DATA SEGMENT

	ARRA DW 1,2,3,4,5,6,7,8,9,10
	ARRB DW 2,3,4,5,6,7,8,9,0,11,34,1,67,13,17
	ARRC DW 10 DUP (?)

	LENA EQU 10
	LENB EQU 15

DATA ENDS

STACK SEGMENT STACK 'STACK'
	DB 100 DUP (?)
STACK ENDS

CODE SEGMENT
	ASSUME CS: CODE, DS: DATA, ES:DATA, SS:STACK

START:
	MOV AX, DATA
	MOV ES, AX	;INITIALIZE ES
	MOV DX, AX	;INITIALIZE DS

	LEA BX, ARRC
	LEA SI, ARRA
	MOV DX, LENA

LOOPA:
	MOV AX, [SI]	;PUT THE ELEMENT INTO AX
	INC SI
	INC SI 			;REFRESH SI
	JMP ISEVEN


	;REFRESH B AFTER REFRESHING A
	LEA DI, ARRB
	MOV CX, LENB

LOOPB:
	CMP AX, [DI]
	JNZ ADDB

	MOV [BX], AX
	INC BX
	INC BX
	JMP NEXT

ADDB:
	INC DI
	INC DI
	LOOP LOOPB

NEXT:
	DEC DX
	JNZ LOOPA

	;TERMINATE
	MOV AH, 4CH
	INT 21H

;TEST IF A IS EVEN
ISEVEN:
	TEST AX, 01H
	JZ LOOPB	;AX IS EVEN, TEST IF THERE IS AN ELEMENT IS EQUAL IN ARRB
	JNZ NEXT

CODE ENDS
	END START


;-------------------------------------------------------------------------------------------
;ex 4.13
;统计STRING字符串中数字字符（‘0’ - ‘9’）的个数，并将数字字符放入BUFFER区内（开始单元存放字符个数）

DATA SEGMENT
















