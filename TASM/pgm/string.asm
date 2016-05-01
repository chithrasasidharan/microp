.model small
.data 
	withenter db 13,10,'$'
	newstring db 20,0, 20 dup('$')
	stringlength dw 0
	sublength dw 0
	substring db 20,0, 20 dup('$')
	no db 13,10, "Not substring$"
	yes db 13,10, "Substring$"
	stop db '$'
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
	mov dx,offset newstring
	mov ah,0ah
	int 21h
	mov dx,offset withenter
	mov ah,9
	int 21h
	; mov dx,offset newstring+2
	; mov ah,9
	; int 21h
	; mov dx,offset withenter
	; mov ah,9
	; int 21h
	mov ah,newstring+1
	mov byte ptr[stringlength],ah
	mov dx,offset substring
	mov ah,0ah
	int 21h
	; mov dx,offset withenter
	; mov ah,9
	; int 21h
	; mov dx,offset substring+2
	; mov ah,9
	; int 21h
	; mov bh,substring+1
	; mov byte ptr[sublength],bh
	; mov ah,byte ptr[stringlength]
	; mov bh,byte ptr[sublength]
	; cmp bh,ah
	; jl l1
	; string no
	; jmp l2
	; l1:
	; lea di,newstring
	; lea si,substring
	; mov cx,sublength
	; repe cmpsb
	; jne l2
	; string yes
	; l2:
	mov ax,4c00h
	int 21h
main endp 
end main