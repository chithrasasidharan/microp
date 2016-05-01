.model small 
.data 
	array db 1,2,5,6,7,3,4
.stack 
.code 
prime proc
	mov ax,bx
	cmp al,1
	je l3
	cmp al,2
	je l2
	mov cl,1
l1:	
	xor ax,ax
	mov al,bl
	inc cl
	cmp cl,al
	jz l2
	div cl
	cmp ah,0
	jne l1

	jmp l3
l2:	
	mov dx,bx
	add dl,30h
	mov ah,2
	int 21h
l3:	ret
prime endp
main proc 
	mov ax,@data
	mov ds,ax
	lea si,array
	mov ch,6
label1:
	mov bl,[si]
	call prime
	inc si
	dec ch
	jnz label1
	mov ax,4c00h
	int 21h
main endp
end main