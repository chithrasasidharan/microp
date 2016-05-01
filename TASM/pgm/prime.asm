.model small 
.data 
	array db 1,2,3,4,5,6,7,8,11
	res db 10 dup("$")
.stack 
.code 
main proc 
	mov ax,@data 
	mov ds,ax
	lea si,array
l1:
	mov bl,[si]
	call prime
	inc si
	cmp si,8
	jle l1
	mov ax,4c00h
	int 21h
main endp
prime proc
	mov al,bl
	mov cl,1
	cmp al,1
	je label1
	cmp al,2
	je label2
label3:
	xor ax,ax
	mov al,bl
	inc cl
	cmp cl,al
	jz label2
	div cl
	cmp ah,0
	jne label3
	jmp label1
label2:
	mov dl,al
	call print
label1:
	ret 
prime endp
print proc
	push ax
	mov bl,dl
	and dl,0f0h
	shr dl,4
	add dl,30h
	cmp dl,39h
	jle skip
	add dl,7
skip:
	mov ah,2
	int 21h
	mov dl,bl
	and dl,0fh 
	add dl,30h
	cmp dl,39h
	jle skip1
	add dl,7
skip1:
	int 21h
	pop ax
	ret
print endp

end main