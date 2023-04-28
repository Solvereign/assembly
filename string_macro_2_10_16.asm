;bp-g teglej, cx-d heden too baigaag oruulna
beltgel macro h 
    mov bp, 0 
    mov ch, 0 
    mov cl, h
endm
;daraagiin murund shiljine
nextline macro 
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
endm

hexprint macro temd
    mov bl, temd
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

endm


binprint macro temd
    local binn
    mov ah, 0
    mov al, temd
    mov temp, 8
    mov si, [hoyrt+7]
    binn:
        mov dx, 0
        div bx
        add dl, 48
        mov [si], dl
        dec si
        dec temp
        cmp temp, 0
        jne binn
        
    mov dx, offset hoyrt
    mov ah, 9h
    int 21h     
    
endm

decprint macro char
    mov ah, 0
    mov al, char
    mov dx, 0
    div bx
    add dx, 48
    mov [si], dl
    dec si 
    
    mov dx, 0
    div bx
    add dx, 48
    mov [si], dl
    dec si
    
    add al, 48
    mov [si], al
    mov ah, 9h
    mov dx, offset arawt
    int 21h
endm






    
    
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
    nextline      
            
    ; 2tin utgig hewleh heseg 
    bin:
        beltgel buffer[1]  
        mov dx, offset msg1
        mov ah, 9h
        int 21h
        mov bx, 2
    bin_mid:
        binprint buffer[bp+2]
        inc bp
        loop bin_mid
        nextline
        
    
    
    
    ;10tin utgig hewleh heseg
    deci:
        beltgel buffer[1]
        mov ah, 9h
        mov dx, offset msg2
        int 21h
        mov bx, 10
    deci_mid: 
        mov si, [arawt+2]
        decprint buffer[bp+2]
        inc bp
        loop deci_mid    
        nextline
        
    
    ;16tin dugaaruudig hewleh heseg                 
    hex:
        mov dx, offset msg3
        mov ah, 9h
        int 21h
        beltgel buffer[1]
    hex_mid:
        hexprint buffer[bp+2]
        inc bp
        
        
        loop hex_mid
        
        jmp exit
        
    
exit:
    ret  
msg0: db "9 hurtelh urttai temdegt mur oruul: $" 
msg1: db "bin: $"
msg2: db "dec: $"
msg3: db "hex: $"
   
hoyrt: db "00000000 $" ; 2tin temdgiig hadgalna 
arawt: db "000 $";
hexa db "0123456789ABCDEF$"
temp db 0

buffer db 10,?, 10 dup(' ')

    



