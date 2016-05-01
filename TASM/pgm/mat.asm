.model small 
.stack 
.data 
	matrix db 1,2,3,4,5,6,7,8,9
	col db 3
	row db 3
.code
main proc 
	mov ax,@data
	mov ds,ax
	lea si,matrix
	xor bx,bx
	mov bl,0
	outer:
		xor cx,cx
		mov ch,0
		inner:
			mov al,ch
			mul row
			add al,bl
			push bx
			xor bx,bx
			mov bl,al
			mov dl,[si+bx]
			add dl,30h
			mov ah,2
			int 21h
			pop bx
			inc ch
			cmp ch,col
			jl inner
		inc bl
		cmp bl,row
		jl outer

	mov ax,4c00h
	int 21h
main endp
end main