
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
         
    ;bl ni counter-n uuregtei
    mov bx, 0 
    mov ch, 0 
    mov cl, buffer[1]
    ;num dotor niit elementiin toog hadgalaw
    mov num, cx    
    mov cl, 0
    ;husnegtiin ehnii elementiig min, max-d hadgalaw
    mov al, buffer[bx+2]
    mov min, al
    mov max, al
    
    ehlel: 
        inc bx
        cmp bx, num
        je tugsgul 
        mov al, buffer[bx+2]
        cmp al, min
        jl baga
    cmp_max:
        cmp al, max
        jg ih
    cmp_erembe:
        cmp buffer[bx+1], al
        jl usujbn
    cmp_buur:
        cmp buffer[bx+1], al
        jg buursan
        jmp ehlel
        
          
    
    ;daraa ni ustgana shuu
    print:
    xor bx, bx
    mov bl, buffer[1]
    mov buffer[bx+2], '$'
    mov dx, offset buffer + 2
    mov ah, 9
    int 21h
    jmp exit    
    
    ;al dahi ni min-s baga baiwal
    baga:
        mov min, al
        jmp cmp_max
        
    ;al dahi ni max-s ih baiwal     
    ih:
        mov max, al
        jmp cmp_erembe 
        
    usujbn:
        inc usuh
        jmp cmp_buur
        
    buursan:
        inc buurah
        jmp ehlel
        
    ;ur dungee hewelne       
    tugsgul: 
        ;msg1-g delgetslew
        mov dx, offset msg1
        mov ah, 9h
        int 21h    
        
        ;baga elementiig hewlew
        mov dl, min
        mov ah, 2
        int 21h
        
        ;daraagiin murluu
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h 
        
        ;msg2-g delgetslew
        mov dx, offset msg2
        mov ah, 9h
        int 21h
        
        ;ih temdegtiig hewlew
        mov dl, max
        mov ah, 2
        int 21h
        
        ;daraagiin mur
        mov dl, 10
        mov ah, 02h
        int 21h
        mov dl, 13
        mov ah, 02h
        int 21h 
        ;buurah = usuh = 0 => bugd ijil
        mov al, usuh
        add al, buurah
        cmp al, 0
        je ijil 
        ;usuh = 0 => buursan
        cmp usuh, 0
        je print_buurah
        ;usuh = 0 => ussun
        cmp buurah, 0
        je print_usuh
        ;ali ni ch bish => erembelegdeegui             
        jmp gg
        
        
    ijil:
        mov dx, offset msg3   
        mov ah, 9
        int 21h
        jmp exit 
    print_buurah:
        mov dx, offset msg4 
        mov ah, 9
        int 21h
        jmp exit
    print_usuh:   
        mov dx, offset msg5 
        mov ah, 9
        int 21h
        jmp exit
    gg:  
        mov dx, offset msg6 
        mov ah, 9
        int 21h
        jmp exit
        
        
    exit:     
        ret   
    
    
    
msg0: db "9 hurtelh urttai temdegt mur oruul: $"
msg1: db "min: $"
msg2: db "max: $"   
msg3: db "adilhan elementuud baina.$"    
msg4: db "buurahaar erembelegdsen$"
msg5: db "usuhuur erembelegdsen$"
msg6: db "erembelegdeegui$"
buffer db 10,?, 10 dup(' ') 

num dw 0 ;garaas awsan elementiin too

min db 0 ; hamgiin baga elementiig hadgalna
max db 0 ; hamgiin ih elementiig hadgalna
usuh db 0 ; daraalsan 2 too usuh daraalald baiwal nemegdene
buurah db 0 ; daraalsan 2 too buurah daraalald baiwal nemegdene
              
    



