
org 100h
    ;ehnii msg-g delgetslew    
    mov ah, 9h
    mov dx, offset msg0
    int 21h
    ;garaas 9 hurtelh urttai string awah   
    mov dx, offset buffer
    mov ah, 0ah
    int 21h  
    ;daraagiin murund shiljih
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    ;msg1-g delgetslew
    mov dx, offset msg1
    mov ah, 9h
    int 21h      
    ;bp ni counter-n uuregtei
    mov bp, 0 
    mov ch, 0 
    mov cl, buffer[1]
    ;num dotor niit elementiin toog hadgalaw
    mov num, cx  
    
    jmp hex
    buffer db 10,?, 10 dup(' ') 
    
    ;16tin dugaaruudig hewleh heseg                 
    hex:
        mov bl, buffer[bp+2]
        jmp printhex
    hhe:       
        inc bp
        cmp bp, num
        je zogsots       
        jmp hex
           
    ;bl deh temdegtiin hex-g hewelne
    printhex:
        mov al, bl
        shr al, 4 
        mov ah, 0
        mov si, ax
        mov dl, [si + hexa]
        mov ah, 2
        int 21h
        
        mov al, bl
        shl al, 4
        shr al, 4  
        mov ah, 0  
        mov si, ax
        mov dl, [si + hexa]
        mov ah, 2
        int 21h
        
        mov dl, 20h
        int 21h 
        
        jmp hhe    
                              
    ;10tin toog hewleh heseg           
    decimal:  
        mov bl, buffer[bp+2]
        mov al, bl
        mov dx, 0
        mov si, [arawt+2]
        jmp insertdec
    hha:
        inc bp
        cmp bp, num
        je exit
        jmp decimal

    ;bl deh temdegtiin dec-g hewelne    
    insertdec:
        div cx
        add dx, 48
        mov [si], dl
        mov dx, 0
        dec si
        cmp ax, 0
        je printdec    
        jmp insertdec
        
        
        
    printdec:
        mov ah, 9h
        mov dx, offset arawt
        int 21h
        mov ah, 0
        mov [arawt], 30h
        mov [arawt+1], 30h
        
        jmp hha
        
        
    ;16tig hewlej duussani daraa beltgel ajil hiine    
    zogsots:
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h  
        
        mov dx, offset msg2
        mov ah, 9
        int 21h 
        
        mov ah, 0
        mov bp, 0
        mov cx, 10 
        jmp decimal
        
    ;daraa ni ustgana shuu
    print:
    xor bx, bx
    mov bl, buffer[1]
    mov buffer[bx+2], '$'
    mov dx, offset buffer + 2
    mov ah, 9
    int 21h
    jmp exit         
    
exit:
    ret  
msg0: db "9 hurtelh urttai temdegt mur oruul: $"
msg1: db "hex: $"
msg2: db "dec: $"   

arawt: db "000 $";
hexa db "0123456789ABCDEF$"
num dw 0              
    



