# 8086汇编语言程序设计

`杨京蕾`		`2014141453208`

> 实验思路

- 从键盘读取输入
- 将输入依次与1，2，3，4比较（cmp语句），**应使用 `ASCII` 码来比较**。
- 检验`ZF`来判断是否相等，若相等，则跳转显示，不相等，继续比较。
- 循环上述步骤。

> 流程图
```flow
st=>start: Start
e=>end: End:>
input=>operation: get input from deyboard
cmp1=>condition: al = 1?
cmp2=>condition: al = 2?
cmp3=>condition: al = 3?
cmp4=>condition: al = 4?
cmpter=>condition: al = $?

disp1=>operation: show school name
disp2=>operation: show major
disp3=>operation: show number
disp4=>operation: show name
disperr=>operation: wrong input

st->input->cmp1(no, left)->cmp2(no, left)->cmp3(no, left)->cmp4(no, left)->cmpter(yes, left)->e
cmp1(yes, right)->disp1
cmp2(yes, right)->disp2
cmp3(yes, right)->disp3
cmp4(yes, right)->disp4
cmpter(no, right)->disperr

st->input->cmp1(no, left)->cmp2(no, left)->cmp3(no, left)->cmp4(no, left)->cmpter(yes, )->e




```

> 完整代码

```
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
```
> 实验结果截图

![](https://raw.githubusercontent.com/penguin-penpen/ASSEMBLEX/master/assignment_screenshot.png)