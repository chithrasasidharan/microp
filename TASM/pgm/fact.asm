.model small
.stack 
.data 
	number dw ?
.code
print proc 
	push ax
	mov dl,bl
	and dl,0f0h
	shr dl,4
	add dl,30h
	cmp dl,39h
	jl skip
	add dl,7h
skip:
	mov ah,2
	int 21h
	mov dl,bl
	and dl,0fh
	add dl,30h
	cmp dl,39h
	jl skip1
	add dl,7
skip1:
	int 21h
	pop ax
	ret
print endp
main proc 
	mov ax,@data
	mov ds,ax
	mov ah,1
	int 21h
	sub al,30h
	mov ah,00
	mov number,ax
	mov ax,1
	mov cx,number
l1:	mul cx
	loop l1
	mov bl,ah
	call print
	mov bl,al
	call print
	call count
	mov ax,4c00h
	int 21h
main endp
count proc
	push ax
	push dx
	mov cl,0
lab1:
	shr ax,1
	adc cl,0
	cmp ax,0
	jne lab1
	mov dl,cl
	add dl,30h
	mov ah,2
	int 21h
	pop dx
	pop ax
	ret
count endp
end main