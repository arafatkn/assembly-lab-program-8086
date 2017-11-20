.MODEL SMALL
.STACK 100H
.DATA
    NL DB 0DH, 0AH,'$'
    
    MSG1 DB 'Input String: $'
    MSG2 DB 'Output String: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    mov ah,9
    lea dx,msg1
    int 21h
    
    mov cx,0
    mov ah,1
    
    INPUT:
        int 21h
        cmp al, 0DH
        JE BREAK
        PUSH ax
        add cx,1
        JMP INPUT
    BREAK:
    
    mov ah,9
    lea dx,nl
    int 21h
    lea dx,msg2
    int 21h
    mov ah,2
    
    PRINT_STACK:
        pop dx
        int 21h
    LOOP PRINT_STACK
    
    
    
    EXIT:
        mov ah,4ch
        int 21h
    
MAIN ENDP

END MAIN