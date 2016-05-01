.model small 
.data
	yes db 13,10,"Yes$"
	no db 13,10,"No$" 
	num1 db ?
	num2 db ?
.stack 
.code
string macro msgs
	push ax
	lea dx,msgs
	mov ah,9
	int 21h
	pop ax
endm 
main proc 
	mov ax,@data 
	mov ds,ax
	mov ah,1
	int 21h
	sub al,30h
	mov bh,al
	mov num1,al 
	mov ah,1
	int 21h
	sub al,30h
	mov bl,al
	mov num2,al 
	call gcd
	mov ax,4c00h
	int 21h
main endp
gcd proc
	;first number in bh and the other in bl
	cmp bh,bl
	jg l1
	mov al,num2
	mov cl,num1
	div cl
	cmp ah,0
	jne l2
	mov dl,num2
	add dl,30h
	mov ah,2
	int 21h
	l1:
	mov al,num1
	mov cl,num2
	div cl
	cmp ah,0
	jne l2
	mov dl,num1
	add dl,30h
	mov ah,2
	int 21h
l2:	ret 
gcd endp

end main