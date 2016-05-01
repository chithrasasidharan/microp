.model small
.data 
	number dw ?
	msg1 db 13,10,"Enter number:$"
	cnt db 13,10,"Number of ones:$"
	result db 13,10,"Result:$"
	deci db 13,10,"Decimal value:$"
	res db 10 dup ("$")
.stack 
.code 
string macro msg
	push ax
	lea dx,msg
	mov ah,9
	int 21h
	pop ax
endm
print macro 
	local n,o
	push ax
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
	pop ax
endm
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

main proc 
	mov ax,@data
	mov ds,ax
	string msg1
	mov ah,1
	int 21h
	sub al,30h
	mov ah,00
	mov number,ax
	mov ax,01h
	mov cx,number
l1:
	mul cx
	loop l1
	string result
	mov bl,ah
	print
	mov bl,al
	print
	string cnt
	call count
	lea si,res
	string deci
	call hextodec
	lea dx,res
	mov ah,9
	int 21h
	;palayam stop munnot nadak anna complex smartex
	mov ax,4c00h
	int 21h
main endp
count proc
	push ax
	push cx
	push dx
	mov cl,00
	label1:
	shr ax,1
	adc cl,0
	cmp ax,0
	jne label1
	mov dl,cl
	add dl,30h
	mov ah,2
	int 21h
	pop dx
	pop cx
	pop ax
	ret
count endp

end main