;输入数字1,2,3,4,相应的在屏幕上显示自己的学校，专业，学号及姓名（英文或拼音皆可)

data segment
    msg1 db '1', '$'
    msg2 db '2', '$'
    msg3 db '3', '$'
    msg4 db '4', '$'
    errmsg db 'wrong input', '$' 
data ends

code segment
    assume ds: data, cs: code
    
start:    
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    jz display_1 
    cmp al, '2'
    jz display_2
    cmp al, '3'
    jz display_3
    cmp al, '4'
    jz display_4
    
    jmp error
    
    
display_1:
         
    mov ah, 09h
    mov dx, offset msg1
    int 21h   
    
display_2:
         
    mov ah, 09h
    mov dx, offset msg2
    int 21h
    
display_3:
         
    mov ah, 09h
    mov dx, offset msg3
    int 21h
    
display_4:
         
    mov ah, 09h
    mov dx, offset msg4
    int 21h 
    
error:
    mov ah, 09h
    mov dx, offset errmsg
    int 21h
    
exit:
    hlt
    
code ends
    end start