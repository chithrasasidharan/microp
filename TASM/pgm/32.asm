.model small 
.data 
	msg1 db 13,10,"Enter first number:$"
	msg2 db 13,10,"Enter second number:$"
	result db 13,10,"Result:$"
	ahh db ?
.stack 
.code 

string macro msg
	push ax
	push dx
	lea dx,msg
	mov ah,9
	int 21h
	pop dx
	pop ax
endm
	
read macro
	local l,m
	push bx
	mov ah,1
	int 21h
	cmp al,39h
	jle l
	sub al,7
	l:
sub al,30h
	shl al,4
	mov bl,al
	int 21h
	cmp al,39h
	jle m
	sub al,7
	m:
sub al,30h
	add al,bl 
	pop bx
endm

print macro 
	local n,o
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
endm

main proc
	mov ax,@data
	mov ds,ax

;read first value
	string msg1
	read
	mov bh,al
	read
	mov bl,al
	read
	mov dh,al
	read
	mov dl,al

;read second value
	string msg2
	read
	mov ch,al
	read
	mov cl,al
	read
	mov ahh,al
	read

;adding and result printing
	string result
	mov ah,ahh
	add dx,ax
	adc cx,bx
	jnc nc
	mov bl,1
	print
nc:
mov bl,ch
	print
	mov bl,cl
	print
	mov bl,dh
	print
	mov bl,dl
	print
	mov ax,4c00h
	int 21h 
main endp
end main