;输入数字1,2,3,4,相应的在屏幕上显示自己的学校，专业，学号及姓名（英文或拼音皆可)

; multi-segment executable file template.

data segment
    msg db 'input $ to terminate.'
    msg1 db 'school: Sichuan University', '$'
    msg2 db 'major: EE', '$'
    msg3 db 'number: 2014141453208', '$'
    msg4 db 'name: Yang Jinglei', '$'
    errmsg db 'wrong input', '$' 
data ends

code segment
    assume ds: data, cs: code
    
start: 
	mov ax, data
	mov ds, ax
	
	;show program info
	mov dx, offset msg
    int 21h
    
again:
    ;get input   
    mov ah, 01h
    int 21h
    
    ;use ascii to compare
    cmp al, 31h
    jz display_1 
    cmp al, 32h
    jz display_2
    cmp al, 33h
    jz display_3
    cmp al, 34h
    jz display_4
    cmp al, 24h
    jz exit    
    jmp error
    
    
display_1:
         
    mov ah, 09h
    mov dx, offset msg1
    int 21h
    jmp again   
    
display_2:
         
    mov ah, 09h
    mov dx, offset msg2
    int 21h
    jmp again
    
display_3:
         
    mov ah, 09h
    mov dx, offset msg3
    int 21h
    jmp again
    
display_4:
         
    mov ah, 09h
    mov dx, offset msg4
    int 21h
    jmp again 
    
error:
    mov ah, 09h
    mov dx, offset errmsg
    int 21h
    jmp exit
    
exit:
    hlt
    
code ends
    end start