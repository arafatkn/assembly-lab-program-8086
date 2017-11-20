.MODEL SMALL
.STACK 100H
.DATA
    N   DB 0   
    NL DB 0DH, 0AH,'$'
    
    MSG1 DB 'Enter a number (<=255): $'
    MSG_P DB 'This is Prime Number.$'
    MSG_NP DB 'This is Not Prime Number.$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    START:
    mov ah,9
    lea dx,msg1
    int 21h
    
    mov cx,0
    mov ah,1
    
    INPUT:
        int 21h
        cmp al, 0DH
        JE BREAK
        sub al,48
        push ax
        inc cx
        JMP INPUT
    BREAK:
    
    mov bh,0
    mov n,bh
    STRING_NUMBER:
        pop dx
        mov al,dl
        mov dl,10
        
        mov bl,bh
        POWER10MUL:
            cmp bl,0
            JE BREAK10MUL
            mul dl
            dec bl
            JMP POWER10MUL
        BREAK10MUL:
        
        add n,al
        inc bh
    LOOP STRING_NUMBER
    
    mov ah,9
    lea dx,nl       ; new line
    int 21h
    
    mov bh,n
    cmp bh,1
    JBE NOT_PRIME
    cmp bh,3
    JBE PRIME
    TEST bh,1
    JZ NOT_PRIME
    
    mov bl,3
    CHECK:
        cmp bl,bh
        JAE PRIME
        mov al,bh
        mov ah,0                    
        div bl
        cmp ah,0
        JE NOT_PRIME
        add bl,2
        cmp al,bl
        JBE PRIME
    JMP CHECK
    
    PRIME:
        mov ah,9
        lea dx,msg_p
        int 21h
        JMP EXIT
    
    NOT_PRIME:
        mov ah,9
        lea dx,msg_np
        int 21h
        JMP EXIT
    
    EXIT:
        mov ah,9
        lea dx,nl
        int 21h
        JMP START
        mov ah,4ch
        int 21h
    
MAIN ENDP
END MAIN