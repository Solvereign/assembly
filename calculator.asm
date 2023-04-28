
org 100h
    
    ;ehnii toog oruul
    mov ah, 9h
    mov dx, offset msg0
    int 21h  
    
    ;ehnii toog oruulah heseg
	;mov dx, offset num1
	;int 21h
	mov cx, 0
	mov si, [num1+15]
	call inputNo
	    
	;operatorig oruul            
	mov ah, 9h
	mov dx, offset msg1
	int 21h
	
	;operator awah heseg
	mov ah, 1
	int 21h
	sub al, 30h
	mov opr, al
	
	;2 dahi too:
    mov ah, 9h
    mov dx, offset msg2
    int 21h  
    
    ;2 dahi toog oruulah heseg
	mov cx, 0
	mov si, [num2+15]
	call inputNo
	     
	mov bx, 15
	mov cx, 16   
	mov bp, 16
    mov flag, 0
    mov temp, 0 
    
    mov si, [result+15]
    mov pointer, si
	;operatorig todorhoiloh heseg
	operator:
	    cmp opr, 1 
	    je nemeh 
	    cmp opr, 2  
	    je hasah
	    cmp opr, 3
	    je urjih
	    
	       
	;nemdeg heseg       
	nemeh: 
	    mov al, 0
	    add al, flag 
	    mov flag, 0
	    add al, num1[bx]
	    add al, num2[bx]
	    cmp al, 9  
	    jg add_of ; al ni 9-s ih baiwal umnuh toog ni negeer ihesgeed, al-s 10g hasna 
	nemeh_mid:    
	    mov result[bx], al 
	    dec bx
	    loop nemeh
	    jmp exit
	     
	          
	hasah:
	    mov ax, 0       
	    mov al, flag
	    mov flag, 0
	    add num2[bx], al
	    mov al, num1[bx]
	    cmp al, num2[bx]  
	    jl sub_of ; al ni 9-s ih baiwal umnuh toog ni negeer ihesgeed, al-s 10g hasna 
	hasah_mid: 
	    sub al, num2[bx]   
	    mov result[bx], al 
	    dec bx
	    loop hasah
	    jmp exit
	    
	;dawhar dawtalt baih heregtei
	urjih:  
	    mov si, pointer
	    mov bx, 15
	    mov cx, 16
	    mov ah, 0
	    mov dh, num2[bp-1] 
	    mov temp1, 0 
	    mov count, 0
	    call negeer
	    
	    
	    dec pointer
	    inc temp
	    dec bp
	    cmp bp, 0
	    jne urjih
	      
	    jmp exit      
	           
	       
	exit: 
	    mov cx, 16
	    mov bx, 15
	    mov si, [result+15]
	    call nemelt
	    mov ah, 9h
	    mov dx, offset msg3
	    int 21h
	    
	    mov ah, 09h
	    mov dx, offset result
	    int 21h 
	    
	    ret  
	    

    inputNo:     
        mov ah, 1
        int 21h 
        cmp al, 0dh
        je str 
        mov ah, 0
        sub al, 30h
        push ax
        inc cx 
        cmp cx, 16
        je str
        jmp inputNo    
        
         
        
    str:
        pop ax
        mov [si], al
        dec si
        loop str
    
        ret
        
        
    ; si-d 16 dahi elementiin bairshlig uguud bugdiig ni 30h-aar nemegduuldeg.
    ; umnu ni bx=16 bolgoh heregtei    
    nemelt:
        mov al, [si]
        add al, 30h
        mov [si], al
        dec si
        loop nemelt
            
        ret
        
    add_of:
        mov flag, ah
        sub al, 10
        jmp nemeh_mid 
        
    mult_of:
        mov dl, 10
        div dl
        mov flag, al
        mov al, ah
        ret
        
    sub_of:    
        add al, 10
        mov flag, 1
        jmp hasah_mid
        
        
    negeer:        
        mov ah, 0
        mov dl, temp
        add dl, temp1
        cmp dl, 16 
        jge hhe
        
        mov al, num1[bx]
        mul dh        
        
        add al, flag    
        
        add al, [si]
        
        call mult_of    
        
        mov [si], al
        
        inc temp1 
        dec bx 
        dec si
        loop negeer
        ret
        
    hhe:
        ret          
        
	    
   

num1: db 16 dup(0), '$'   ;ehnii too
num2: db 16 dup(0), '$'    ;2 dahi too
result: db 16 dup(0), '$'   ;ur dun
opr db 0    ;operator

msg0 db 'ehnii toog oruul: $'
msg1 db 0dh,0ah,"operator (1-Add, 2-Subtract, 3-Multiply): $"
msg2 db 0dh,0ah,"2 dahi too: $" 
msg3 db 0dh, 0ah, "ur dun: $"
flag db 0

count db 0;
temp db 0 ; tur too hadgalah huwisagch, of deer ashiglaj baigaa
temp1 db 0 ; tooni orni too
pointer dw 0
