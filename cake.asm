paint macro col, row, color
    LOCAL label1, label2, exitm  
    mov cx, col 
    mov al, color
    mov ah, 0ch
    mov dx, row
    ;cx == x, dx == y bol dawtaltaas garna
    mov x, cx
    add x, 5
    mov y, dx
    add y, 5
   
    label1:
    mov dx, row

    
        label2:
        int 10h
        inc dx
        
        cmp dx, y
        jne label2
        
    inc cx        
    cmp cx, x
    je exitm        
            
    jmp label1
    
    exitm:
endm

paintcount macro col, row, color, count
    LOCAL label
    mov temp, count 
    mov bl, color
    mov bruh, col
    ;mov 
    mov al, color
    mov ah, 0ch
    label: 
        paint bruh, row, bl
        add bruh, 5
        dec temp
        cmp temp, 0
        jne label
endm


org 100h
    
    
    mov al, 13h
	mov ah, 0
	int 10h     ; set graphics video mode. 
	
	;ehnii mur                            
	
	
	;paintcount 35, 20, 1000b, 6
        	;paint 40, 20, 1000b
        	;paint 45, 20, 1000b
        	;paint 50, 20, 1000b
        	;paint 55, 20, 1000b
        	;paint 60, 20, 1000b
	;2r mur
	;paintcount 25, 25, 1000b, 2
	        ;paint 30, 25, 1000b
	paintcount 35, 25, 0111b, 6
        	;paint 40, 25, 0111b
        	;paint 45, 25, 0111b
        	;paint 50, 25, 0111b
        	;paint 55, 25, 0111b
        	;paint 60, 25, 0111b
	;paintcount 65, 25, 1000b, 2
	        ;paint 70, 25, 1000b
	        
	;3r mur
	;paintcount 15, 30, 1000b, 2
	        ;paint 20, 30, 1000b
	paintcount 25, 30, 0111b, 3
        	;paint 30, 30, 0111b
        	;paint 35, 30, 0111b
	paint 40, 30, 0100b
	paintcount 45, 30, 0111b, 6
	;paintcount 75, 30, 1000b, 2 
	
	;4r mur
	;paint 10, 35, 1000b
	paintcount 15,35, 0111b 2
	paint 25, 35, 0100b
	paintcount 30, 35, 0111b, 6
	paint 60, 35, 0100b
	paintcount 65, 35, 0111b, 4
	;paint 85, 35, 1000b 
	
	;5r mur
	;paint 10, 40, 1000b
	paintcount 15, 40, 0111b, 7
	paint 50, 40, 0100b
	paintcount 55, 40, 0111b, 3
	paint 70, 40, 0100b
	paintcount 75, 40, 0111b, 2
	;paint 85, 40, 1000b 
	
	;6r mur
	;paint 10, 45, 1000b
	paintcount 15, 45, 0111b, 3
	paint 30, 45, 0100b
	paintcount 35, 45, 0111b, 10
	;paint 85, 45, 1000b 
	
	;7r mur
	;paint 10, 50, 1000b
	paintcount 15, 50, 0111b, 7
	paint 50, 50, 0100b
	paintcount 55, 50, 0111b, 6
	;paint 85, 50, 1000b
	
	;8r mur
	;paint 10, 55, 0000b
	paintcount 15, 55, 0111b, 14
	;paint 85, 55, 0000b 
	
	;9r mur
	;paint 10, 60, 0000b
	paint 15, 60, 0110b
	paintcount 20, 60, 0111b, 11
	paintcount 75, 60, 0110b, 2
	;paint 85, 60, 0000b
	
	;10r mur 
	;paint 10, 65, 0000b
	paintcount 15, 65, 0110b, 3
	paintcount 30, 65, 0111b, 8
	paintcount 70, 65, 0110b, 3
	;paint 85, 65, 0000b
	
	;11r mur
	;paint 10, 70, 0000b
	paintcount 15, 70, 0110b, 5
	paint 40, 70, 0111b
	paintcount 45, 70, 0110b, 3
	paint 60, 70, 0111b
	paintcount 65, 70, 0110b, 4
	;paint 85, 70, 0000b
	              
	;12r mur
	;paintcount 15, 75, 0000b, 2
	paintcount 25, 75, 0110b, 11
	;paint 80, 75, 0000b
	
	;13r mur
	;paintcount 25, 80, 0000b, 2
	paintcount 35, 80, 0110b, 6
	;paintcount 65, 80, 0000b, 3
	
	;14r mur
	;paintcount 35, 85, 0000b, 6
	
	
exit:
    ret


x dw 0 ;huwisagch
y dw 0 ; huwisagch
temp db 0
bruh dw 0




