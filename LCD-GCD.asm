pchar	macro   para1		;��X�r��
	push    ax
        push    dx
        mov     dl,para1
        mov     ah,02h
        int     21h
        pop     dx
        pop     ax
        endm

pstring	macro   para2		;��X�r��
	push    ax
        push    dx
        mov     dx,offset para2
        mov     ah,09h
        int     21h
        pop     dx
        pop     ax
        endm

getkey	macro
        mov	ah,00h		;Ū��L
        int     16h
        cmp     al,1Bh
        je      L6
	pchar	al
        mov     bh,al
        mov     ah,00h
        int     16h
        cmp     al,1Bh
        je      L6
	pchar	al
        mov     bl,al
        sub	bh,30h		;�NASCII�X��30h�ܦ����T�Ʀr
 	sub	bl,30h
 	mov	al,bh
 	mov	ah,0Ah
 	mul	ah
 	add	al,bl
	endm


.model small
.data
mes1	db	'Press ESC to exit',10,13,'$'
mes2	db	'Enter the first number:$'
mes3	db	'Enter the second number:$'
lcm	db	'LCM:$'
gcd	db	'GCD:$'
char1	db	0AH,0DH,'$'
.stack 1000h
.code
main proc 
	mov	ax,@data
        mov	ds,ax

L1:	pstring	mes1			;L1��Ū��L
	pstring	mes2
        getkey
        mov	ch,al
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h
	pstring	mes3	
        getkey
        mov 	cl,al
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h

	mov	al,cl			;�N��Ƭۭ���Jdx�ƥ�
	mul	ch
	mov	dx,ax
	
	cmp	ch,cl			;�����Ƥj�p�P�_�O�_���p��Υ洫
	ja	L2			;�j��N������L2�����k
	jmp	L3			;�_�h��L3���洫
L2:	mov	al,ch			;L2������۰��k�������k����
	mov	ah,0
	div	cl
	mov	ch,ah
	mov	bl,0h
	cmp	bl,ch			;����l�ƬO�_��0
	je	L4
L3:	xchg	cl,ch			;L3������۰��k�����洫����
	jmp	L2
L4:	mov	bl,cl			;L4���NLCM�PGCD�ର10�i��
	mov	ch,0
	push	bx			;�]GCD�s�bbl�ҥH�Nbx��push����|�H�K��Ƥ���
	mov	ax,dx			;�}�l�p��LCM
	mov	dx,0
	div	cx
	mov	cx,0Ah			;�}�l�NLCM��10�i��
	div	cx
	mov	bx,dx
	mov	dx,0
	div	cx
	mov	cl,4
	shl	dx,cl
	add	bx,dx
	mov	cx,0Ah
	mov	dx,0
	div	cx
	mov	cl,8
	shl	dx,cl
	add	bx,dx
	mov	cl,12
	shl	ax,cl
	add	bx,ax
L5:	pstring	lcm			;L5����X���G
	mov	dx,bx			;�}�l��XLCM
	mov 	cl,12
	shr 	dx,cl
	add 	dx,30h
	mov 	ah,02h
	int 	21h

	mov	dx,bx
	mov	cl,4
	shl	dx,cl
	mov	cl,12
	shr	dx,cl
	add	dx,30h
	mov	ah,02h
	int	21h

	mov	dx,bx
	mov	cl,8
	shl	dx,cl
	mov	cl,12
	shr	dx,cl
	add	dx,30h
	mov	ah,02h
	int	21h

	mov	dx,bx
	mov	cl,12
	shl	dx,cl
	mov	cl,12
	shr	dx,cl
	add	dx,30h
	mov	ah,02h
	int	21h
	mov	dx,offset char1
	mov	ah,09h
	int	21h

	pop	bx			;�N�쥻�p��n��GCD�q���|�̨��X
	pstring	gcd
	mov	al,bl			;�}�l��XGCD
	mov	ah,0
	mov	cl,0Ah
	div	cl
	xchg	ah,al
	add	ah,30h
	add	al,30h
	mov	bx,ax

	mov	dx,ax
	mov	cl,8
	shr	dx,cl
	mov	ah,02h
	int	21h

	mov 	dx,bx
	mov 	cl,8
	shl 	dx,cl
	mov 	cl,8
	shr 	dx,cl
	mov 	ah,02h
	int 	21h
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h
	jmp	L1			;���^L1���s����@��
L6:     mov	ax,4c00h		;L6������
        int	21h
main endp
end main