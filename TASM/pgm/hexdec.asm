.model small
.data
	number dw 0ffffh
	result db 10 dup("$")
.stack
.code 
hextodec proc
mov bx,10
mov cx,00
l1:
mov dx,00
div bx
add dl,30h
push dx
inc cx
cmp ax,9
jg l1
add al,30h
mov [si],al
l2:pop ax
inc si
mov [si],al
loop l2
ret 
hextodec endp
main proc 
	mov ax,@data
	mov ds,ax
	mov ax,number
	lea si,result
	call hextodec
	lea dx,result
	mov ah,9
	int 21h
	mov ax,4c00h
	int 21h
main endp 
end main