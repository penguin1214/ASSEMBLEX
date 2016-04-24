
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

DATA SEGMENT
    A DB 1
    B DB 0
    C DB 3
    D DB 0
    E DB 0
    
ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA 
    ;USE CL TO COUNT
    
    MOV CL, 0 ;INITIALIZE
    
    MOV AL, 0   
    CALL ISZERO
    
    MOV AL, 0
    CALL ISZERO

    MOV AL, 0
    CALL ISZERO
    
    ;IF CL == 0 
        ;SET D = 1
    ;ELSE
        ;SUM UP AND ASSINGN TO E
        
    TEST CL, 0FFH;
    JZ SETD
    
    MOV AH, B
    ADD AL, AH
    MOV AH, A
    ADC AL, AH
    MOV E, AL
    HLT
        
SETD: MOV D, 0
    HLT
    
    ISZERO PROC
        TEST AL, 0FFH  
        JNZ COUNT
        RET
        COUNT: INC CL
    ENDP
ENDS        
    
ret





