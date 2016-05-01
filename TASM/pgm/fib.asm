.model small
.data
	num db ?
	num1 db ?
	num2 db ?
	res db 10 dup ("$")
.stack 
.code 

main proc
	mov ax,@data
	mov ds,ax
	mov ah,1
	int 21h
	sub al,30h
	cmp al,9
	jle skip
	sub al,7
	skip:
	mov num,al
	call fibonacci
	mov ax,4c00h
	int 21h 
main endp
printbx macro
	push ax
	push bx
	push cx
	push dx
	mov ax,bx
	lea si,res
	call hextodec
	lea dx,res
	mov ah,9
	int 21h
	pop dx
	pop cx
	pop bx
	pop ax
endm
fibonacci proc
	mov bl,1
	mov num1,bl
	printbx
	cmp bl,num
	je l1
	mov bl,2
	mov num2,bl
	printbx
loop1:
	cmp num,bl
	jle l1
	mov bl,num1
	add bl,num2
	mov cl,num2
	mov num1,cl
	mov num2,bl
	printbx
	cmp num,bl
	jle l1
	jmp loop1
l1: ret
fibonacci endp

hextodec proc
	mov bx,10
	mov cx,00
lab1:
	mov dx,00
	div bx
	add dl,30h
	push dx
	inc cx
	cmp ax,9
	jg lab1
	add al,30h
	mov [si],al
lab2:
	pop ax
	inc si
	mov [si],al
	loop lab2
	ret 
hextodec endp

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