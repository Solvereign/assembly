
org 100h

mov ah, 1         ;k buyu 6b ugluu gj body
int 21h  
                            

mov cl, al  
            
;equal temdegt
mov ah, 2
mov dl, 3dh
int 21h     
     
;first char
mov al, cl
shr al, 4
mov dl, al   ;dl-d 06 gesen utga baigaa  
cmp dl, 10
jl number
jmp char

number:
    add dl, 48
    int 21h
    jmp second
char:
    add dl, 55
    int 21h
   
second:
;second char
    mov al, cl
    shl al, 4
    shr al, 4
    mov dl, al ;dl-d 0b gesen utga baigaa 
    cmp dl, 10
    jl num
    jmp character

num:
    add dl, 48
    int 21h
    jmp exit
character:
    add dl, 55
    int 21h

 
exit:    
    ret




