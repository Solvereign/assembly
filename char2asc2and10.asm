
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

;bx-d 2g ugch baina
mov bx, 2
;ax-ruu cx-g huulsnaar div functiong hereglene 
mov ax, cx
mov si, [hoyrt +7]          

;div ni al = ax/operand. ah = remainder
;eswel dx = remainder. end dx ni uldegdliig zaaj baina
binary:
    mov dx, 0
    div bx
    add dx, 48
    mov [si], dl
    dec si 
    cmp ax, 1
    jl pbin
    jmp binary 
             
             
pbin:
    mov dx, offset hoyrt
    mov ah, 9
    int 21h
    
    mov ah, 2
    mov dl, 2ch
    int 21h
    
    mov ax, cx
    mov si, [arawt+2]
    mov bx, 10
    jmp decimal

decimal:    
    mov dx, 0
    div bx
    add dx, 48
    mov [si], dl
    dec si 
    cmp ax, 1
    jl exit
    jmp decimal
    
exit:
    mov ah, 9
    mov dx, offset arawt    
    int 21h
    ret
    

    
    

hoyrt: db "00000000b$" ; 2tin temdgiig hadgalna  
arawt: db "000d$" ; 10t


