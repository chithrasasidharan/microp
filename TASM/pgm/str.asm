.model small
.data
	withenter db 13,10,'$'
	sourcestring db 20,0 ,20 dup("$")
	stringlength dw ?
	sublength dw ?
	substring db 20,0, 20 dup ("$")
	notsubmsg db "not substring$"
	submsg db " substring$"
	stop db '$'
.stack 
.code 
main proc
	mov ax,@data
	mov ds,ax
	mov dx,offset sourcestring
	mov ah,0ah
	int 21h
	mov dx,offset withenter
	mov ah,9
	int 21h
	mov dx,offset substring
	mov ah,0ah
	int 21h
	mov dx,offset withenter
	mov ah,9
	int 21h
	mov ah,sourcestring+1
	mov byte ptr[stringlength],ah
	mov bh,substring+1
	mov byte ptr[sublength],bh
	mov ah,byte ptr[stringlength]
	cmp ah,bh
	jl notsubstring 
	mov bx,00h
check:
	lea si,stringlength[bx]
	inc bx
	lea di,substring
	xor cx,cx
	mov cl,byte ptr[sublength]
	repz cmpsb
	je substrig
	mov dl,byte ptr[stringlength]
	sub dl,bl
	cmp dl,byte ptr[sublength]
	jl notsubstring
	jmp check
substrig:
	lea dx,submsg
	jmp outputhere
notsubstring:
	lea dx,notsubmsg
outputhere:
	mov ah,9
	int 21h
	mov ax,4c00h
	int 21h 
main endp 
end main