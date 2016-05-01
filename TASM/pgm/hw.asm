.model small

.data
	msg db 13,10,"$"
.stack
.code
prin macro
	mov ah,02
	mov dl,bl
	and dl,0f0h
	shr dl,4
	add dl,'0'
	int 21h
	mov dl,bl
	and dl,0fh
	add dl,'0'
	int 21h
endm

read proc
	
	push bx
	mov ah,1
	int 21h
	sub al,30h
	shl al,04
	mov bl,al
	int 21h
	sub al,'0'
	add al,bl
	pop bx
	ret
read endp


	main proc far
		mov ax, @data
		mov ds, ax
		call read
		mov bl,al
		call read
		add bl,al
		prin 
		; Code goes here...
	
		mov ax, 4c00h
		int 21h
	main endp
end main