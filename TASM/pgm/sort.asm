.model small
.data 
	array db 12,43,1,5,9,63,7
.stack 
.code 
main proc 
	mov ax,@data 
	mov ds,ax
	mov cl,0
l3:
	mov bx,0
l2:
	mov dl,array[bx+1]
	cmp dl,array[bx]
	jg l1
	call swap
l1:
	inc bx
	cmp bl,6
	jl l2
	inc cl
	cmp cl,7
	jl l3
	mov si,0
l4:
	mov al,array[si]
	mov ah,0
	mov cx,0
	mov bx,10
loop1:
	mov dx,00
	div bx
	push dx
	inc cx
	cmp ax,9
	jg loop1
	push ax
	inc cx
loop2:
	pop ax
	mov dl,al
	add dl,30h
	mov ah,2
	int 21h
	loop loop2
	inc si
	cmp si,7
	jl l4
	mov ax,4c00h
	int 21h
main endp
swap proc
	mov ch,array[bx]
	mov array[bx],dl
	mov array[bx+1],ch
	ret 
swap endp
end main