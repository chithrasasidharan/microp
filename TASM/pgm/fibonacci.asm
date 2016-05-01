.model small
.data
	num db ?
	num1 db ?
	num2 db ?
.stack 
.code 

main proc
	mov ax,@data
	mov ds,ax
	mov ah,1
	int 21h
	mov num,al
	call fibonacci
	mov ax,4c00h
	int 21h 
main endp

fibonacci proc
	mov al,1
	mov num1,al
	call print
	mov al,2
	mov num2,al
	call print
loop1:
	cmp num,al
	jge l1
	mov al,num1
	add al,num2
	mov num1,num2
	mov num2,al
	call print
	jmp loop1
l1: ret
fibonacci endp

print proc 
	push dx
	mov dl,bl
	and dl,0f0h
	shr dl,4
	add dl,30h
	cmp dl,39h
	jle n
	add dl,7
n:
mov ah,2
	int 21h
	mov dl,bl
	and dl,0fh
	add dl,30h
	cmp dl,39h
	jle o
	add dl,7
o:
int 21h
	pop dx
	ret
print endp

end main