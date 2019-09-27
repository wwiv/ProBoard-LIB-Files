
% MODEL MEM_MOD

PUBLIC   _sound
PUBLIC   _nosound
PUBLIC   _soundclick

CODESEG

PROC _sound
        arg     freq:WORD
        push    bp
        mov     bp,sp
        mov     bx,[freq]
        mov     ax,034DDh
        mov     dx,012h
        cmp     dx,bx
        jae     @@exit
        div     bx
        mov     bx,ax
        in      al,061h
        test    al,3
        jne     lab

        or      al,3
        out     061h,al
        mov     al,0B6h
        out     043h,al

lab:    mov     al,bl
        out     042h,al
        mov     al,bh
        out     042h,al
@@exit: pop     bp
        ret
ENDP _sound

PROC _nosound
        push    bp
        mov     bp,sp
        in      al,061h
        and     al,0FCh
        out     061h,al
        pop     bp
        ret
ENDP _nosound

PROC _soundclick
        push    bp
        mov     bp,sp
        in      al,061h
        push    ax
        and     al,0fch
        out     061h,al
        mov     cx,200h
@@x:    loop    @@x
        or      al,2
        out     061h,al
        mov     cx,200h
@@y:    loop    @@y
        pop     ax
        out     061h,al
        pop     bp
        ret
ENDP _soundclick

 END
