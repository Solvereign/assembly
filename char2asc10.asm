
org 100h
;garaas utga awch, al-d hadgalna
mov ah, 1         
int 21h  
                            
;utgaa cl-ruu huulaw
mov cl, al  
            
;tentsuugiin temdeg
mov ah, 2
mov dl, 3dh
int 21h

;bx-d 10g ugch baina
mov bx, 10 
mov ax, cx
mov si, [buffer +2]          

;div ni al = ax/operand. ah = remainder
ascii:
    mov dx, 0
    div bx
    add dx, 48
    mov [si], dl
    dec si 
    cmp ax, 1
    jl exit
    jmp ascii 
             
             
exit:
    mov dx, offset buffer
    mov ah, 9
    int 21h
    ret

buffer: db "000d$" ; 10tin temdgiig hadgalna


