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

hexprintf macro temd
    
    mov bl, temd
    mov al, bl
    shr al, 4 
    mov ah, 0
    mov si, ax
    mov dl, [si + hexa]
    mov hexno[0], dl
    
    mov al, bl
    shl al, 4
    shr al, 4  
    mov ah, 0  
    mov si, ax
    mov dl, [si + hexa]
    mov hexno[1], dl
    
    mov bx, handle
    mov dx, offset hexno 
    mov cx, 3
    mov ah, 40h
    int 21h
    
    
endm


binprintf macro temd 
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
    mov bx, handle
    mov ah, 40h
    int 21h     
    
endm

decprintf macro char
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
    
    mov ah, 40h
    mov bx, handle
    mov dx, offset arawt
    int 21h
endm

macro open dire 
    LOCAL err, k
    mov dx, offset dire
    mov al, 2
    mov ah, 3dh
    int 21h
    jc err
    mov handle, ax
    jmp k
    err:
    mov dx, offset error
    mov ah, 9h
    int 21h
    k:
endm

macro close 
    mov ah, 3eh
    mov bx, handle
    int 21h
endm

org 100h
    
    
    mov ah, 9h
    mov dx, offset msg00  
    int 21h
    mov dx, offset msg11  
    int 21h
    mov dx, offset msg22
    int 21h
    mov dx, offset msg33
    int 21h 
    
    start:
        mov ax, 3
        int 33h
        
        cmp bx, 2
        je exit
        cmp bx, 1
        jne start
        
        cmp dx, 12; dx - y
        jle l1
        cmp dx, 24
        jle l2
        cmp dx, 40
        jle l3
        cmp dx, 60
        jle l4
        jmp start
        l1:
            cmp cx, 32
            jle l11
            jmp start
        l2:
           cmp cx, 56
           jle l22
           jmp start     
    
        l3:
          cmp cx, 50
          jle l33
          jmp start
        
        l4: 
            cmp cx, 40
            jle l44
            jmp start
    
        l11:
        call readd
        jmp start
        
        l22:
        call convert
        jmp start
        l33:
        call create
        jmp start
        l44:
        call shiwelt
        jmp start
        
        jmp start
    
exit:
    ret

create: 
   mov dx, offset print
   mov cx, 0
   mov ah, 3ch
   int 21h
   jc err
   mov handle, ax
   jmp h
   err:
   mov dx, offset error
   mov ah, 9h
   int 21h 
   h:
ret

readd:
    open read
    mov dx, offset buffer
    mov bx, handle
    mov cx, 12
    mov ah, 3fh
    int 21h
    
    close
    
    mov ah, 9h
    mov dx, offset buffer
    int 21h
    nextline
ret
   

shiwelt:
    open print    
    
    ; 2tin utgig hewleh heseg 
    binf:
        mov bp, 0
        ;mov count, 12
        mov cx, 5
        mov bx, handle  
        mov dx, offset msg1
        mov ah, 40h
        int 21h
        mov cx, 9
    bin_midf:
        mov bx, 2
        binprintf buffer[bp]
        inc bp
        cmp bp, 12
        jne bin_midf
    
    ;10tin utgig hewleh heseg
    decif:
        mov bp, 0
        mov ah, 40h
        mov bx, handle
        mov cx, 6
        mov dx, offset msg2
        int 21h
        mov bx, 10
        mov cx, 4
    deci_midf:
        mov bx, 10 
        mov si, [arawt+2]
        decprintf buffer[bp]
        inc bp
        cmp bp, 12
        jl deci_midf
        
    ;16tin dugaaruudig hewleh heseg
    
    hexf:     
        mov bx, handle
        mov cx, 6
        mov dx, offset msg3
        mov ah, 40h
        int 21h
        mov bp, 0
    hex_midf:
        hexprintf buffer[bp]
        inc bp
        cmp bp, 12
        jl hex_midf                 
    
        
        
ret

convert:       
            
    ; 2tin utgig hewleh heseg 
    bin:
        beltgel 12  
        mov dx, offset msg1
        mov ah, 9h
        int 21h
        mov bx, 2
    bin_mid:
        binprint buffer[bp]
        inc bp
        loop bin_mid
        nextline
    
    ;10tin utgig hewleh heseg
    deci:
        beltgel 12
        mov ah, 9h
        mov dx, offset msg2
        int 21h
        mov bx, 10
    deci_mid: 
        mov si, [arawt+2]
        decprint buffer[bp]
        inc bp
        loop deci_mid    
        nextline
        
    ;16tin dugaaruudig hewleh heseg                 
    hex:
        mov dx, offset msg3
        mov ah, 9h
        int 21h
        beltgel 12
    hex_mid:
        hexprint buffer[bp]
        inc bp
          
        loop hex_mid  
ret        

msg00: db 'Read', 0dh, 0ah, 0ah, '$'
msg11: db 'Convert',0dh, 0ah, 0ah, '$'
msg22: db 'Create', 0dh, 0ah, 0ah, '$'
msg33: db 'Write', 0dh, 0ah, 0ah, '$'

msg1: db "bin: $"
msg2: db 0ah, "dec: $"
msg3: db 0ah, "hex: $"
   
hoyrt: db "00000000 $" ; 2tin temdgiig hadgalna 
arawt: db "000 $";
hexno: db "00 $"
hexa db "0123456789ABCDEF$"
temp db 0
 
read db 'hello.txt', 0
print db 'print.txt', 0
;dir db 'C:\emu8086\MySource', 0
handle dw ?        
error db 'aldaa garlaa', 0dh, 0ah, '$'

buffer db 13 dup('$')
;count dw 12

end